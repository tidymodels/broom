skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("glmnetUtils")
suppressPackageStartupMessages(library(glmnetUtils))

set.seed(27)

skip_if_not_installed("modeldata")
library(modeldata)
data(hpc_data)

hpc_data <- hpc_data[1:300, ]

fit <- glmnet(formula = mpg ~ ., data = mtcars)
fit2 <- glmnet(
  formula = class ~ compounds + input_fields + iterations + num_pending,
  data = hpc_data,
  family = "multinomial"
)

cv_fit <- cv.glmnet(formula = mpg ~ ., data = mtcars)
cv_fit2 <- cv.glmnet(
  formula = class ~ compounds + input_fields + iterations + num_pending,
  data = hpc_data,
  family = "multinomial"
)


test_that("glmnet.formula tidier arguments", {
  check_arguments(tidy.glmnet)
  check_arguments(glance.glmnet)

  check_arguments(tidy.cv.glmnet)
  check_arguments(glance.cv.glmnet)
})

test_that("tidy.glmnet.formula", {
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

  expect_s3_class(td2, "tbl_df")

  expect_equal(dim(td2), c(1511L, 6L))
  expect_equal(dim(td2z), c(2000L, 6L))

  expect_true(all(td2$estimate != 0))
  expect_true(any(td2z$estimate == 0))

  # regression tests
  expect_true(is.numeric(td$step) && !any(is.na(td$step)))
  expect_true(is.numeric(td2$step) && !any(is.na(td2$step)))
})

test_that("glance.glmnet.formula", {
  gl <- glance(fit)
  gl2 <- glance(fit2)

  check_glance_outputs(gl, gl2)

  expect_s3_class(gl, "tbl_df")
  expect_equal(dim(gl), c(1L, 3L))
})
