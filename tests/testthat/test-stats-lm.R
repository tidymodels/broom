context("stats-lm")

skip_if_not_installed("modeltests")
library(modeltests)

test_that("lm tidier arguments", {
  check_arguments(tidy.lm)
  check_arguments(glance.lm)
  check_arguments(augment.lm)
})

fit <- lm(mpg ~ wt, mtcars)
fit2 <- lm(mpg ~ wt + log(disp), mtcars)

# the cyl:qsec term isn't defined for this fit
na_row_data <- mtcars[c(6, 9, 13:15, 22), ]
fit_na_row <- lm(mpg ~ cyl * qsec + gear, data = na_row_data)

# rank-deficient fit
rd_data <- data.frame(y = rnorm(10), x = letters[seq_len(10)])
fit_rd <- lm(y ~ x - 1, data = rd_data)

test_that("tidy.lm works", {
  td <- tidy(fit)
  td2 <- tidy(fit2)
  
  # conf.int = TRUE works for rank deficient fits
  # should get a "NaNs produced" warning
  expect_warning(td_rd <- tidy(fit_rd, conf.int = TRUE))

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td_rd)

  check_dims(td, expected_rows = 2)
  check_dims(td2, expected_rows = 3)
  
  expect_equal(td$term, c("(Intercept)", "wt"))
  expect_equal(td2$term, c("(Intercept)", "wt", "log(disp)"))


  # shouldn't error. regression test for issues 166, 241
  # rows for confidence intervals of undefined terms should be dropped
  expect_error(tidy(fit_na_row, conf.int = TRUE), NA)
})

test_that("glance.lm", {
  gl <- glance(fit)
  gl2 <- glance(fit2)

  check_glance_outputs(gl, gl2)
})

test_that("augment.lm", {
  check_augment_function(
    aug = augment.lm,
    model = fit,
    data = mtcars,
    newdata = mtcars
  )

  check_augment_function(
    aug = augment.lm,
    model = fit2,
    data = mtcars,
    newdata = mtcars
  )

  expect_warning(
    check_augment_function(
      aug = augment.lm,
      model = fit_na_row,
      data = na_row_data,
      newdata = na_row_data
    ),
    "prediction from a rank-deficient fit may be misleading"
  )

  check_augment_function(
    aug = augment.lm,
    model = fit_rd,
    data = rd_data,
    newdata = rd_data
  )
})
