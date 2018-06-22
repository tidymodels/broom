context("nnet")

skip_if_not_installed("nnet")
library(nnet)

fit <- multinom(gear ~ mpg + factor(am), data = mtcars, trace = FALSE)

test_that("nnet tidier arguments", {
  check_arguments(tidy.multinom)
  check_arguments(glance.multinom)
})

test_that("tidy.multinom", {
  td <- tidy(fit, conf.int = TRUE)
  check_tidy_output(td)
  check_dims(td, 6, 8)
})

test_that("glance.multinom", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 3)
})
