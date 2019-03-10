context("gamlss")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("gamlss")
skip_if_not_installed("gamlss.data")
skip_if_not_installed("gamlss.dist")

library(gamlss)
library(gamlss.data)
library(gamlss.dist)

data(abdom, package = "gamlss.data")

# all 50 warnings are the same
# "In regularize.values(x, y, ties, missing(ties)) :
# collapsing to unique 'x' values"
fit <- suppressWarnings(gamlss(
  y ~ pb(x),
  sigma.fo = ~ pb(x),
  family = BCT,
  data = abdom,
  method = mixed(1, 20),
  control = gamlss.control(trace = FALSE)
))

test_that("gamless tidier arguments", {
  check_arguments(tidy.gamlss)
})

test_that("tidy.gamlss", {
  td <- tidy(fit)
  tdq <- tidy(fit, quick = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(tdq)
  
  check_dims(td, 6, 6)
  check_dims(tdq, 2, 2)
})

test_that("glance.gamlss", {
  glance_df <- glance(fit)

  check_dims(glance_df, 1, 7)
})
