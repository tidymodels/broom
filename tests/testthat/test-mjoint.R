# test tidy, augment, glance methods for mjoint object (joineRML package)
context("mjoint tidiers (joineRML package)")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("joineRML")
library(joineRML)

# Data
data(heart.valve, package = "joineRML")
hvd <- heart.valve[!is.na(heart.valve$log.grad) & !is.na(heart.valve$log.lvmi) & heart.valve$num <= 50, ]

# Model fits
fit1 <- suppressMessages(joineRML::mjoint(
  formLongFixed = list("grad" = log.grad ~ time + sex + hs),
  formLongRandom = list("grad" = ~1 | num),
  formSurv = survival::Surv(fuyrs, status) ~ age,
  data = hvd,
  inits = list(
    "gamma" = c(0.1, 2.7),
    "beta" = c(2.5, 0.0, 0.1, 0.2)
  ),
  timeVar = "time"
))
fit2 <- suppressMessages(joineRML::mjoint(
  formLongFixed = list(
    "grad" = log.grad ~ time + sex + hs,
    "lvmi" = log.lvmi ~ time + sex
  ),
  formLongRandom = list(
    "grad" = ~1 | num,
    "lvmi" = ~time | num
  ),
  formSurv = Surv(fuyrs, status) ~ age,
  data = hvd,
  inits = list(
    "gamma" = c(0.11, 1.51, 0.80),
    "beta" = c(2.52, 0.01, 0.03, 0.08, 4.99, 0.03, -0.20)
  ),
  timeVar = "time"
))

# Bootstrapped SEs
bSE1 <- suppressMessages(joineRML::bootSE(fit1, nboot = 5, safe.boot = TRUE, progress = FALSE))
bSE2 <- suppressMessages(joineRML::bootSE(fit2, nboot = 5, safe.boot = TRUE, progress = FALSE))

test_that("tidy works on mjoint models with a single longitudinal process", {
  td <- tidy(fit1)
  check_tidy_output(td)
  check_dims(td, expected_rows = 2)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit1, component = "survival")
  check_tidy_output(td)
  check_dims(td, expected_rows = 2)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit1, component = "longitudinal")
  check_tidy_output(td)
  check_dims(td, expected_rows = 4)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit1, component = "survival", bootSE = bSE1)
  check_tidy_output(td)
  check_dims(td, expected_rows = 2)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit1, component = "longitudinal", bootSE = bSE1)
  check_tidy_output(td)
  check_dims(td, expected_rows = 4)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit1, component = "survival")
  expect_equal(td$term, c("age", "gamma_1"))
  td <- tidy(fit1, component = "longitudinal")
  expect_equal(td$term, c("(Intercept)_1", "time_1", "sex_1", "hsStentless valve_1"))
})

test_that("tidy works on mjoint models with more than one longitudinal process", {
  td <- tidy(fit2)
  check_tidy_output(td)
  check_dims(td, expected_rows = 3)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit2, component = "survival")
  check_tidy_output(td)
  check_dims(td, expected_rows = 3)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit2, component = "longitudinal")
  check_tidy_output(td)
  check_dims(td, expected_rows = 7)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit2, component = "survival", bootSE = bSE2)
  check_tidy_output(td)
  check_dims(td, expected_rows = 3)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit2, component = "longitudinal", bootSE = bSE2)
  check_tidy_output(td)
  check_dims(td, expected_rows = 7)
  check_dims(td, expected_cols = 5)

  td <- tidy(fit2, component = "survival")
  expect_equal(td$term, c("age", "gamma_1", "gamma_2"))
  td <- tidy(fit2, component = "longitudinal")
  expect_equal(td$term, c("(Intercept)_1", "time_1", "sex_1", "hsStentless valve_1", "(Intercept)_2", "time_2", "sex_2"))
})

test_that("augment works on mjoint models with a single longitudinal process", {
  augdf <- augment(fit1)
  expect_equal(nrow(augdf), nrow(hvd))
  expect_equal(ncol(augdf), ncol(hvd) + 4)
  expect_equal(names(augdf), c(names(hvd), ".fitted_grad_0", ".fitted_grad_1", ".resid_grad_0", ".resid_grad_1"))
  check_augment_function(aug = augment.mjoint, model = fit1, data = fit1$data, strict = FALSE)
})

test_that("augment works on mjoint models with more than one longitudinal process", {
  augdf <- augment(fit2)
  expect_equal(nrow(augdf), nrow(hvd))
  expect_equal(ncol(augdf), ncol(hvd) + 8)
  expect_equal(names(augdf), c(names(hvd), ".fitted_grad_0", ".fitted_lvmi_0", ".fitted_grad_1", ".fitted_lvmi_1", ".resid_grad_0", ".resid_lvmi_0", ".resid_grad_1", ".resid_lvmi_1"))
  check_augment_function(aug = augment.mjoint, model = fit2, data = fit2$data, strict = FALSE)
})

test_that("augment returns the same output whether we pass 'data' or not", {
  expect_equal(object = names(augment(fit1)), expected = names(augment(fit1, data = list(hvd))))
  expect_equal(object = dim(augment(fit1)), expected = dim(augment(fit1, data = list(hvd))))
  expect_equal(object = names(augment(fit2)), expected = names(augment(fit2, data = list(hvd))))
  expect_equal(object = dim(augment(fit2)), expected = dim(augment(fit2, data = list(hvd))))
})

test_that("glance works on mjoint models with a single longitudinal process", {
  glnc <- glance(fit1)
  check_glance_outputs(glnc, strict = FALSE)
  check_dims(glnc, expected_cols = 4, expected_rows = 1)
  expect_equal(names(glnc), c("sigma2_1", "AIC", "BIC", "logLik"))
})

test_that("glance works on mjoint models with more than one longitudinal process", {
  glnc <- glance(fit2)
  check_glance_outputs(glnc, strict = FALSE)
  check_dims(glnc, expected_cols = 5, expected_rows = 1)
  expect_equal(names(glnc), c("sigma2_1", "sigma2_2", "AIC", "BIC", "logLik"))
})
