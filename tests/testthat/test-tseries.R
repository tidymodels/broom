context("tseries")

skip_if_not_installed("tseries")
library(tseries)

dax <- diff(log(EuStockMarkets))[, "DAX"]
fit <- garch(dax, control = garch.control(trace = FALSE))

test_that("tseries tidier arguments", {
  check_arguments(tidy.garch)
  check_arguments(glance.garch)
  check_arguments(augment.garch)
})

test_that("tidy.garch", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 3)
})

test_that("glance.garch", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 7)
})

test_that("it should augment tseries::garch fits", {
  
  skip("Think if augmenting garch models makes sense")
  
  # data specified as a ts object, this could be messy
  
  check_augment_function(
    aug = augment.garch,
    model = fit,
    data = dax,
    newdata = dax
  )
  
  expect_error(
    augment(fit),
    "TODO: Something about data argument cannot be empty"
  )

})

