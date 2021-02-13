context("nnet")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("nnet")
library(nnet)

fit <- multinom(gear ~ mpg + factor(am), data = mtcars, trace = FALSE)

response <- t(rmultinom(100, 1, c(0.1, 0.2, 0.3, 0.4)))
fit_matrix_response <- multinom(response~1, trace = FALSE)

test_that("nnet tidier arguments", {
  check_arguments(tidy.multinom)
  check_arguments(glance.multinom)
})

test_that("tidy.multinom when y has only 2 levels",{
  dfr <- data.frame(a = rnorm(100))
  dfr$y <- dfr$a + rnorm(100)
  twolevels <- nnet::multinom(I(y > 0) ~ a, dfr, trace = FALSE)
  td1 <- tidy(twolevels, conf.int = TRUE)
  check_tidy_output(td1)
  check_dims(td1, 2, 8)
})

test_that("tidy.multinom", {
  td1 <- tidy(fit, conf.int = TRUE)
  td2 <- tidy(fit_matrix_response, conf.int = TRUE)
  check_tidy_output(td1)
  check_tidy_output(td2)
  check_dims(td1, 6, 8)
  check_dims(td2, 3, 8)
})

test_that("glance.multinom", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 4)
})
