context("mice tidiers")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("mice")
library(mice)

dat <- data.frame(y = c(.1, .2, .3, .4, .5), 
                  x = c(.01, .02, .04, .02, .01), 
                  z = c(0, 2, 1, NA, 5))
imp <- mice(dat, print = FALSE, seed = 1234)
fit <- with(imp, lm(y ~ x + z))
poo <- pool(fit)

test_that("mice tidier arguments", {
  check_arguments(tidy.mira)
  check_arguments(glance.mira)
  check_arguments(tidy.mipo)
  check_arguments(glance.mipo)
})

test_that("tidy.mipo", {
  td <- tidy(poo, conf.int = TRUE, conf.level = .99)
  check_tidy_output(td)
  check_dims(td, expected_cols = 8)
})

test_that("glance.mipo", {
  gl <- glance(poo)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 1)
})

test_that("tidy.mira", {
  td <- tidy(fit, conf.int = TRUE, conf.level = .99)
  check_tidy_output(td)
  check_dims(td, expected_cols = 8)
})

test_that("glance.mira", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 4)
})
