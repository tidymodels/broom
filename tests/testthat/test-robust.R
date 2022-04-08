context("robust")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("robust")
library(robust)

fit <- lmRob(mpg ~ wt, data = mtcars)
fit2 <- glmRob(am ~ wt, data = mtcars, family = "binomial")

test_that("robust tidier arguments", {
  check_arguments(tidy.lmRob)
  check_arguments(glance.lmRob)
  check_arguments(augment.lmRob)

  check_arguments(tidy.glmRob)
  check_arguments(glance.glmRob)
})

test_that("tidy.lmRob", {
  td <- tidy(fit)
  td2 <- tidy(fit, conf.int = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)
})

test_that("glance.lmRob", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.lmRob", {
  check_augment_function(
    aug = augment.lmRob,
    model = fit,
    data = mtcars,
    newdata = mtcars
  )
})

test_that("tidy.glmRob", {
  td <- tidy(fit2)
  td2 <- tidy(fit2)

  check_tidy_output(td)
  check_tidy_output(td2)
})

test_that("glance.glmRob", {
  gl <- glance(fit2)
  check_glance_outputs(gl)
})

test_that("no more rlang issues with model objects from robust", { # from issue 720

  expect_equal(
    tidy(fit, conf.int = TRUE),
    tidy(fit)
  )

  expect_equal(
    tidy(fit, exponentiate = TRUE),
    tidy(fit)
  )

  expect_equal(
    tidy(fit2, conf.int = TRUE),
    tidy(fit2)
  )

  expect_equal(
    tidy(fit2, exponentiate = TRUE),
    tidy(fit2)
  )
})
