skip_on_cran()

skip_if_not_installed("epiR")

dat <- matrix(c(13, 2163, 5, 3349), nrow = 2, byrow = TRUE)
rownames(dat) <- c("DF+", "DF-")
colnames(dat) <- c("FUS+", "FUS-")

skip_if_not_installed("MASS")
suppressPackageStartupMessages(library(MASS))
birthwt <- MASS::birthwt

birthwt$low <- factor(birthwt$low, levels = c(1, 0))
birthwt$smoke <- factor(birthwt$smoke, levels = c(1, 0))
birthwt$race <- factor(birthwt$race, levels = c(1, 2, 3))
tab1 <- table(birthwt$smoke, birthwt$low, dnn = c("Smoke", "Low BW"))
tab2 <- table(
  birthwt$smoke,
  birthwt$low,
  birthwt$race,
  dnn = c("Smoke", "Low BW", "Race")
)

suppressPackageStartupMessages(library(epiR))
fit1 <- epi.2by2(
  dat = as.table(dat),
  method = "cross.sectional",
  conf.level = 0.95,
  units = 100,
  outcome = "as.columns"
)
fit2 <- epi.2by2(
  dat = tab1,
  method = "cohort.count",
  conf.level = 0.95,
  units = 100,
  outcome = "as.columns"
)
fit3 <- epi.2by2(
  dat = tab2,
  method = "cohort.count",
  conf.level = 0.95,
  units = 100,
  outcome = "as.columns"
)

test_that("epi2by2 arguments", {
  check_arguments(tidy.epi.2by2)
})

test_that("tidy.epi2by2", {
  tidy1 <- tidy(fit1)
  tidy2 <- tidy(fit2)
  tidy3 <- tidy(fit3, parameters = "stat")

  check_tidy_output(tidy1)
  check_tidy_output(tidy2)
  check_tidy_output(tidy3)

  # check_dims(tidy1, 13, 4)
})
