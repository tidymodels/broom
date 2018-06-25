context("mass-fitdistr")

skip_if_not_installed("MASS")

set.seed(27)
x <- rnorm(100, 5, 2)
fit <- suppressWarnings(MASS::fitdistr(x, dnorm, list(mean = 3, sd = 1)))

test_that("fitdistr tidier arguments", {
  check_arguments(tidy.fitdistr)
  check_arguments(glance.fitdistr)
})

test_that("tidy.fitdistr", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 2, 3)
})

test_that("glance.fitdistr", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 4)
})
