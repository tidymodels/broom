context("glmnet")

skip_if_not_installed("glmnet")
library(glmnet)

# TODO: tests for glmnetUtils wrappers

set.seed(27)

x <- matrix(rnorm(100 * 20), 100, 20)
y <- rnorm(100)
g <- sample(1:4, 100, replace = TRUE)

fit <- glmnet(x, y)
fit2 <- glmnet(x, g, family = "multinomial")

cv_fit <- cv.glmnet(x, y)
cv_fit2 <- cv.glmnet(x, g, family = "multinomial")

test_that("glmnet tidier arguments", {
  check_arguments(tidy.glmnet)
  check_arguments(glance.glmnet)
  
  check_arguments(tidy.cv.glmnet)
  check_arguments(glance.cv.glmnet)
  
  # no augment because no formula/dataframe interface is my guess?
  # TODO: sanity check if the glance methods are sensical
})

test_that("tidy.glmnet", {
  
  td <- tidy(fit)
  tdz <- tidy(fit, return_zeros = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(tdz)
  
  check_dims(td, expected_cols = 5)
  check_dims(tdz, expected_cols = 5)
  
  expect_true(all(td$estimate != 0))
  expect_true(any(tdz$estimate == 0))
  
  # multinomial
  
  td2 <- tidy(fit2)
  td2z <- tidy(fit2, return_zeros = TRUE)
  
  check_tidy_output(td2)
  check_tidy_output(td2z)
  
  expect_true(all(td2$estimate != 0))
  expect_true(any(td2z$estimate == 0))
  
  # regression tests
  expect_true(is.numeric(td$step) && !any(is.na(td$step)))
  expect_true(is.numeric(td2$step) && !any(is.na(td2$step)))
})

test_that("glance.glmnet", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  
  check_glance_outputs(gl, gl2)
})

test_that("tidy.cv.glmnet", {
  
  td <- tidy(cv_fit)
  
  check_tidy_output(td)
  check_dims(td, expected_cols = 6)
  
  # multinomial
  
  td2 <- tidy(cv_fit2)
  
  check_tidy_output(td2)
  check_dims(td2, expected_cols = 6)
})

test_that("glance.cv.glmnet", {
  gl <- glance(cv_fit)
  gl2 <- glance(cv_fit2)
  
  check_glance_outputs(gl, gl2)
})
