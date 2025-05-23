skip_if_not_installed("modeltests")
suppressPackageStartupMessages(library(modeltests))

suppressMessages(skip_if_not_installed("tseries"))
suppressPackageStartupMessages(library(tseries))

dax <- diff(log(EuStockMarkets))[, "DAX"]
fit <- garch(dax, control = garch.control(trace = FALSE))

test_that("tseries tidier arguments", {
  check_arguments(tidy.garch)
  check_arguments(glance.garch)
})

test_that("tidy.garch", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 3)

  td <- tidy(fit, conf.int = TRUE, conf.level = .99)
  check_tidy_output(td)
  check_dims(td, 3, 7)
})

test_that("glance.garch", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 8)
})
