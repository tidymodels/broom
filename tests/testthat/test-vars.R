context("vars")

skip_on_cran()
skip_if_not_installed("modeltests")
skip_if_not_installed("vars")

library(vars)
library(modeltests)

data("Canada", package = "vars")
fit <- VAR(Canada, p=1, type="both")

test_that("vars tidier arguments", {
  check_arguments(tidy.varest)
  check_arguments(glance.varest)
})

test_that("tidy.vars", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 24, 6)
  # vars does not produce confidence intervals
  expect_warning(tidy(fit, conf.int = TRUE))
})


test_that("glance.vars", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})
