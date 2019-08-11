context("robustbase")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("robustbase")
library(robustbase)

fit <- lmrob(mpg ~ wt, data = mtcars)
fit2 <- glmrob(am ~ wt, data = mtcars, family = "binomial")

test_that("robustbase tidier arguments", {
  check_arguments(tidy.lmrob)
  check_arguments(glance.lmrob)
  check_arguments(augment.lmrob)
  
  check_arguments(tidy.glmrob)
  # check_arguments(glance.glmrob)
  check_arguments(augment.glmrob)
})

test_that("tidy.lmrob", {
  # check tidy.lmrob returns right columns
  td <- tidy(fit)
  check_tidy_output(td)
  # check tidy.lmrob returns confidence intervals for params when requested
  td_ci <- tidy(fit, conf.int = TRUE)
  check_dims(td_ci, 2, 7)
})

test_that("glance.lmrob", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.lmrob", {
  check_augment_function(
    aug = augment.lmrob,
    model = fit,
    data = mtcars,
    newdata = mtcars
  )
  # check that .se.fit column is included
  check_dims(augment(fit, se_fit = TRUE), 32, 6)
})

test_that("tidy.glmrob", {
  td <- tidy(fit2)
  check_tidy_output(td)
  td_ci <- tidy(fit2, conf.int = TRUE)
  check_dims(td_ci, 2, 7)
})

# test_that("glance.glmrob", {
# })

test_that("augment.glmrob", {
  check_augment_function(
    aug = augment.glmrob,
    model = fit2,
    data = mtcars,
    newdata = mtcars
  )
  
  # check that .se.fit column is included
  check_dims(augment(fit2, se_fit = TRUE), 32, 6)
})
