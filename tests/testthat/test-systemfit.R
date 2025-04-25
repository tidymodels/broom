skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("systemfit")
suppressPackageStartupMessages(library(systemfit))

# Testing using systemfit examples ----------------------------------------

data("Kmenta")
eqDemand <- consump ~ price + income
eqSupply <- consump ~ price + farmPrice + trend
system <- list(demand = eqDemand, supply = eqSupply)

# OLS estimation
fitols <- systemfit(system, data = Kmenta)

test_that("tidy.systemfit with OLS", {
  td <- tidy(fitols)
  check_tidy_output(td)
  check_dims(td, 7, 7)

  td <- tidy(fitols, conf.level = .99)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})

# OLS estimation with 2 restrictions
Rrestr <- matrix(0, 2, 7)
Rrestr[1, 3] <- 1
Rrestr[1, 7] <- -1
Rrestr[2, 2] <- -1
Rrestr[2, 5] <- 1

qrestr <- c(0, 0.5)

fitols2 <- systemfit(
  system,
  data = Kmenta,
  restrict.matrix = Rrestr,
  restrict.rhs = qrestr
)

test_that("tidy.systemfit with OLS 2 restrictions", {
  td <- tidy(fitols2)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})


# OLS estimation with the same 2 restrictions in symbolic form
restrict <- c(
  "demand_income - supply_trend = 0",
  "- demand_price + supply_price = 0.5"
)
fitols2b <- systemfit(system, data = Kmenta, restrict.matrix = restrict)

test_that("tidy.systemfit with OLS 2 restrictions", {
  td <- tidy(fitols2b)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})

# OLS with restrictions on the coefficients by modifying the regressor matrix
# with argument restrict.regMat
modReg <- matrix(0, 7, 6)
colnames(modReg) <- c(
  "demIntercept",
  "demPrice",
  "demIncome",
  "supIntercept",
  "supPrice2",
  "supTrend"
)

modReg[1, "demIntercept"] <- 1
modReg[2, "demPrice"] <- 1
modReg[3, "demIncome"] <- 1
modReg[4, "supIntercept"] <- 1
modReg[5, "supPrice2"] <- 1
modReg[6, "supPrice2"] <- 1
modReg[7, "supTrend"] <- 1

fitols3 <- systemfit(system, data = Kmenta, restrict.regMat = modReg)

test_that("tidy.systemfit with OLS 2 restrictions and modifications", {
  td <- tidy(fitols3)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})

# iterated SUR estimation
fitsur <- systemfit(system, "SUR", data = Kmenta, maxit = 100)

test_that("tidy.systemfit with SUR", {
  td <- tidy(fitsur)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})


# 2SLS estimation
inst <- ~ income + farmPrice + trend
fit2sls <- systemfit(system, "2SLS", inst = inst, data = Kmenta)
test_that("tidy.systemfit with 2SLS", {
  td <- tidy(fit2sls)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})


# 2SLS estimation with different instruments in each equation
inst1 <- ~ income + farmPrice
inst2 <- ~ income + farmPrice + trend

instlist <- list(inst1, inst2)

fit2sls2 <- systemfit(system, "2SLS", inst = instlist, data = Kmenta)

test_that("tidy.systemfit with 2SLS with different instruments", {
  td <- tidy(fit2sls2)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})

# 3SLS estimation with GMM-3SLS formula
inst <- ~ income + farmPrice + trend

fit3sls <- systemfit(
  system,
  "3SLS",
  inst = inst,
  data = Kmenta,
  method3sls = "GMM"
)

test_that("tidy.systemfit with 3SLS", {
  td <- tidy(fit3sls)
  check_tidy_output(td)
  check_dims(td, 7, 7)
})
