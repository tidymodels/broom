context("survival-survfit")

skip_if_not_installed("survival")
library(survival)

cfit <- coxph(Surv(time, status) ~ age + strata(sex), lung)
sfit <- survfit(cfit)

fit2 <- survfit(
  Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
  data = mgus1,
  subset = (start == 0)
)

test_that("survfit tidier arguments", {
  check_arguments(tidy.survfit)
  check_arguments(glance.survfit)
})

test_that("tidy.survfit", {
  td <- tidy(sfit)
  td2 <- tidy(fit2)
  
  check_tidy_output(td)
  check_tidy_output(td2)
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
  
  # TODO: another test here?
})

