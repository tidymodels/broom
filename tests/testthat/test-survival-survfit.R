context("survival-survfit")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("survival")
library(survival)

cfit <- coxph(Surv(time, status) ~ age + strata(sex), lung)
sfit <- survfit(cfit)

cfit2 <- coxph(Surv(time, status) ~ age, lung)
sfit2 <- survfit(cfit2)

fit2 <- survfit(
  Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
  data = mgus1,
  subset = (start == 0)
)

# To test 3 parsing 3 or more strata variables
fit3 <- survfit(Surv(stop - start, status) ~ age + sex + pcdx, data = mgus1)

# To test whether parsing fails when there's a problem with the variable name
fit4 <- survfit(Surv(stop - start, status) ~ interaction(sex, pcdx),
                data = mgus1)
fit5 <- survfit(Surv(time, status) ~ (age <= 68), data = lung)

# To test that parsing fils when there's a problem with the variable values
mgus1[, "bad_var"] <- sample(c("bad, 1", "bad2"), size = nrow(mgus1),
                             replace = T)
mgus1[, "bad_var2"] <- sample(c("bad=bad", "bad3"), size = nrow(mgus1), 
                             replace = T)
fit6 <- survfit(Surv(stop - start, status) ~ bad_var, data = mgus1)
fit7 <- survfit(Surv(stop - start, status) ~ bad_var2, data = mgus1)

test_that("survfit tidier arguments", {
  check_arguments(tidy.survfit)
  check_arguments(glance.survfit)
})

test_that("tidy.survfit", {
  td <- tidy(sfit)
  td2 <- tidy(fit2)
  
  # Verify that it created the strata column correctly
  expect_equal(tail(names(td), 1), "sex")
  
  # Verify that all the other variables are tidy
  check_tidy_output(subset(td, select = -sex))
  check_tidy_output(td2)
  
  # Verify that parsing strata works with 3+ variables
  td3 <- tidy(fit3)
  expect_equal(tail(names(td3), 3), c("age", "sex", "pcdx"))
  
  # Verify that parsing strata fails when there are excess "=" or "," in the
  # variable name
  expect_warning(
    td4 <- tidy(fit4), 
    "Could not automatically detect strata names."
    )
  expect_warning(tidy(fit5), "Could not automatically detect strata names.")
  
  # Verify that parsing fails when there are excess "=" or "," in the variable
  # values
  expect_warning(tidy(fit6), "Could not automatically detect strata names.")
  expect_warning(tidy(fit7), "Could not automatically detect strata names.")
  
  # Verify that the warnings do not attempt to parse strata names
  check_tidy_output(td4)
})

test_that("glance.survfit", {
  
  expect_error(
    glance(sfit),
    regexp = "Cannot construct a glance of a multi-strata survfit object."
  )
  
  expect_error(
    glance(fit2),
    regexp = "Cannot construct a glance of a multi-state survfit object."
  )
  
  gl <- glance(sfit2)
  check_glance_outputs(gl)
})

