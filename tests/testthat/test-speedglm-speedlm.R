context("speedglm")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("speedglm")
library(speedglm)

fit <- speedlm(mpg ~ wt, mtcars, fitted = TRUE)
fit2 <- speedlm(mpg ~ wt + disp, mtcars, fitted = TRUE)
fit3 <- speedlm(mpg ~ wt, mtcars)

test_that("speedlm tidiers arguments", {
  check_arguments(tidy.speedlm)
  check_arguments(glance.speedlm)
  check_arguments(augment.speedlm)
})

test_that("tidy.speedlm", {
  td <- tidy(fit)
  td2 <- tidy(fit2)

  check_tidy_output(td)
  check_tidy_output(td2)

  check_dims(td, 2)
  check_dims(td2, 3)

  expect_equal(td$term, c("(Intercept)", "wt"))
  expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
})

test_that("glance.speedlm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.speedlm", {
  check_augment_function(
    aug = augment.speedlm,
    model = fit,
    data = mtcars,
    newdata = mtcars
  )

  check_augment_function(
    aug = augment.speedlm,
    model = fit2,
    data = mtcars,
    newdata = mtcars
  )

  expect_error(
    augment(fit3),
    "Must specify `data` argument or refit speedglm with `fitted = TRUE`."
  )
})
