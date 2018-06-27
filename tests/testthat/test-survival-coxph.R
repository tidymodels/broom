context("survival-coxph")

skip_if_not_installed("survival")
library(survival)

fit <- coxph(Surv(time, status) ~ age + sex, lung)
fit2 <- coxph(Surv(time, status) ~ age + sex, lung, robust = TRUE)

test_that("coxph tidier arguments", {
  check_arguments(tidy.coxph)
  check_arguments(glance.coxph)
  check_arguments(augment.coxph)
})

test_that("tidy.coxph", {
  td <- tidy(fit)
  td2 <- tidy(fit, exponentiate = TRUE)
  td3 <- tidy(fit2)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td3)
})

test_that("glance.coxph", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  
  check_glance_outputs(gl, gl2)
})

test_that("augment.coxph", {
  
  expect_error(
    augment(fit),
    regexp = "Must specify either `data` or `newdata` argument."
  )
  
  check_augment_function(
    aug = augment.coxph,
    model = fit,
    data = lung,
    newdata = lung
  )
  
  check_augment_function(
    aug = augment.coxph,
    model = fit2,
    data = lung,
    newdata = lung
  )
})
