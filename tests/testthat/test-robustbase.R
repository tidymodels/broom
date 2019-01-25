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
  check_arguments(glance.glmrob)
})

test_that("tidy.lmrob", {
  td <- tidy(fit)
  check_tidy_output(td)
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
})

test_that("tidy.glmrob", {
  td <- tidy(fit2)
  check_tidy_output(td)
})

test_that("glance.glmrob", {
  expect_error(
    glance.glmrob(),
    "`glance.glmrob()` has not yet been implemented. See the documentation."
  )
})

test_that("augment.glmrob", {
  check_augment_function(
    aug = augment.glmrob,
    model = fit2,
    data = mtcars,
    newdata = mtcars
  )
})
