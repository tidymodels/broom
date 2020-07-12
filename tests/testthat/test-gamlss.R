context("gamlss")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("gamlss")
skip_if_not_installed("gamlss.data")
skip_if_not_installed("gamlss.dist")

library(gamlss)
library(gamlss.data)
library(gamlss.dist)

data(abdom, package = "gamlss.data")

fit <- gamlss(
  y ~ pb(x),
  sigma.fo = ~ pb(x),
  family = BCT,
  data = abdom,
  method = mixed(1, 20),
  control = gamlss.control(trace = FALSE)
)

test_that("gamless tidier arguments", {
  check_arguments(tidy.gamlss)
})

test_that("tidy.gamlss", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 6, 6)
})
