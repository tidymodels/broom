skip_if_not_installed("modeltests")
library(modeltests)

test_that("lm tidier arguments", {
  check_arguments(tidy.lm)
  check_arguments(glance.lm)
  # errors with "Tidiers with `conf.level` argument must have `conf.int` argument."
  # check_arguments(augment.lm)
})

fit <- lm(mpg ~ wt, mtcars)
fit2 <- lm(mpg ~ wt + log(disp), mtcars)
fit3 <- lm(mpg ~ 1, mtcars)
fit4 <- lm(mpg ~ 0 + cyl, mtcars)

# zero weights used to break influence columns in augment.lm
wts <- c(0, rep(1, nrow(mtcars) - 1))
fit_0wts <- lm(mpg ~ 1, weights = wts, data = mtcars)

# the cyl:qsec term isn't defined for this fit
na_row_data <- mtcars[c(6, 9, 13:15, 22), ]
fit_na_row <- lm(mpg ~ cyl * qsec + gear, data = na_row_data)

# rank-deficient fit
rd_data <- data.frame(y = rnorm(10), x = letters[seq_len(10)])
fit_rd <- lm(y ~ x - 1, data = rd_data)

test_that("tidy.lm works", {
  td <- tidy(fit)
  td2 <- tidy(fit2)
  td3 <- tidy(fit3)
  td_na_row <- tidy(fit_na_row)

  # conf.int = TRUE works for rank deficient fits
  # should get a "NaNs produced" warning
  expect_snapshot(td_rd <- tidy(fit_rd, conf.int = TRUE))
  
  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td_rd)
  check_tidy_output(td_na_row)

  check_dims(td, expected_rows = 2)
  check_dims(td2, expected_rows = 3)
  check_dims(td3, expected_rows = 1)
  check_dims(td_na_row, expected_rows = 5)

  expect_equal(td$term, c("(Intercept)", "wt"))
  expect_equal(td2$term, c("(Intercept)", "wt", "log(disp)"))
  expect_equal(td3$term, c("(Intercept)"))

  # shouldn't error. regression test for issues #166 and #241.
  # rows for confidence intervals of undefined terms should be dropped
  expect_no_error(tidy(fit_na_row, conf.int = TRUE))
})

test_that("glance.lm", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  gl3 <- glance(fit3)
  gl4 <- glance(fit4)

  check_glance_outputs(gl, gl2, gl3, gl4)
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

  check_augment_function(
    aug = augment.lm,
    model = fit3,
    data = mtcars,
    newdata = mtcars
  )

  if (paste(R.version$major, R.version$minor, sep = ".") <= "4.2.2") {
    expect_warning(
      check_augment_function(
        aug = augment.lm,
        model = fit_na_row,
        data = na_row_data,
        newdata = na_row_data
      ),
      "prediction from a rank-deficient fit may be misleading"
    )
  }

  check_augment_function(
    aug = augment.lm,
    model = fit_rd,
    data = rd_data,
    newdata = rd_data
  )

  check_augment_function(
    aug = augment.lm,
    model = fit_0wts,
    data = mtcars,
    newdata = mtcars
  )

  # conf.level defaults to 0.95
  aug <- augment(fit, newdata = mtcars, interval = "confidence")
  pred <- predict(fit, newdata = mtcars, interval = "confidence", level = 0.95)
  expect_equal(aug$.lower, pred[, "lwr"])
  expect_equal(aug$.upper, pred[, "upr"])

  # conf.level is respected
  aug <- augment(fit, newdata = mtcars, interval = "confidence", conf.level = 0.75)
  pred <- predict(fit, newdata = mtcars, interval = "confidence", level = 0.75)
  expect_equal(aug$.lower, pred[, "lwr"])
  expect_equal(aug$.upper, pred[, "upr"])

  # conf.level works for prediction intervals as well
  aug <- augment(fit, newdata = mtcars, interval = "prediction", conf.level = 0.25)
  pred <- predict(fit, newdata = mtcars, interval = "prediction", level = 0.25)
  expect_equal(aug$.lower, pred[, "lwr"])
  expect_equal(aug$.upper, pred[, "upr"])

  # conf.level is ignored when interval = "none"
  aug <- augment(fit, newdata = mtcars, interval = "none", conf.level = 0.25)
  expect_false(any(names(aug) %in% c(".lower", ".upper")))
  
  # warns when passed as level rather than conf.level
  expect_snapshot(
    augment(fit, newdata = mtcars, interval = "confidence", level = 0.95)
  )
})

test_that("glance.lm returns non-NA entries with 0-intercept model (#1209)", {
  fit <- lm(mpg ~ 0 + cyl, mtcars)
  fit_glance <- glance(fit)
  expect_false(is.na(fit_glance[["statistic"]]))
  expect_false(is.na(fit_glance[["p.value"]]))
  expect_false(is.na(fit_glance[["df"]]))
})
