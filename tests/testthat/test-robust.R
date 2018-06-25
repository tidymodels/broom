context("robust")

skip_if_not_installed("robust")
library(robust)

fit <- lmRob(mpg ~ wt, data = mtcars)
fit2 <- glmRob(am ~ wt, data = mtcars, family = "binomial")

# tidy and augment methods call lm tidiers. as long as nothing explodes
# basics tests okay

test_that("robust glance arguments", {
  check_arguments(glance.lmRob)
  check_arguments(glance.glmRob)
})

test_that("tidy.lmRob", {
  td <- tidy(fit)
  check_tidy_output(td)
})

test_that("glance.lmRob", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.lmRob", {
  au <- augment(fit)
  check_tibble(au, method = "augment")
})

test_that("tidy.glmRob", {
  td <- tidy(fit2)
  check_tidy_output(td)
})

test_that("glance.glmRob", {
  gl <- glance(fit2)
  check_glance_outputs(gl)
})

test_that("augment.glmRob", {
  au <- augment(fit2)
  check_tibble(au, method = "augment")
})
