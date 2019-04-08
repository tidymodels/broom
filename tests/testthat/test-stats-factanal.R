context("stats-factanal")

skip_if_not_installed("modeltests")
library(modeltests)

n_factors <- 3
n_factors2 <- 3

fit <- factanal(mtcars, n_factors)
fit2 <- factanal(mtcars, n_factors2)

test_that("factanal tidier arguments", {
  check_arguments(tidy.factanal)
  check_arguments(glance.factanal)
  check_arguments(augment.factanal, strict = FALSE)
})

test_that("tidy.factanal", {
  td <- tidy(fit)
  td2 <- tidy(fit2)

  check_tidy_output(td, strict = FALSE)
  check_tidy_output(td2, strict = FALSE)
  check_dims(td, ncol(mtcars), 2 + n_factors)

  expect_equal(td$variable, colnames(mtcars))
  expect_equal(ncol(td2), 2 + n_factors2)
})

test_that("glance.factanal works", {
  gl <- glance(fit)
  gl2 <- glance(fit2)

  check_glance_outputs(gl, gl2)
  check_dims(gl, 1, 9)

  expect_equal(gl$n.factors, n_factors)
})

test_that("augment.factanal works", {
  fit_reg <- factanal(mtcars, n_factors, scores = "regression")
  fit_bart <- factanal(mtcars, n_factors, scores = "Bartlett")

  check_augment_function(
    aug = augment.factanal,
    model = fit_reg,
    data = mtcars,
    strict = FALSE
  )

  check_augment_function(
    aug = augment.factanal,
    model = fit_bart,
    data = mtcars,
    strict = FALSE
  )

  # errors for `scores = "none"`
  fit_none <- factanal(mtcars, n_factors, scores = "none")
  expect_error(
    augment(fit_none),
    regexp = "Cannot augment factanal objects fit with `scores = 'none'`."
  )
})

test_that("augment.factanal works with matrix", {
  library(broom)
  set.seed(123)

  library(broom)
  set.seed(123)
  
  # data
  v1 <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 4, 5, 6)
  v2 <- c(1, 2, 1, 1, 1, 1, 2, 1, 2, 1, 3, 4, 3, 3, 3, 4, 6, 5)
  v3 <- c(3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 4, 6)
  v4 <- c(3, 3, 4, 3, 3, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 5, 6, 4)
  v5 <- c(1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 6, 4, 5)
  v6 <- c(1, 1, 1, 2, 1, 3, 3, 3, 4, 3, 1, 1, 1, 2, 1, 6, 5, 4)
  fit1 <- cbind.data.frame(v1, v2, v3, v4, v5, v6)
  
  # new data
  fit2 <-
    cbind.data.frame(
      x1 = rev(v1),
      x2 = rev(v2),
      x3 = rev(v3),
      x4 = rev(v4),
      x5 = rev(v5),
      x6 = rev(v6)
    )

  # objects
  fit1 <- stats::factanal(m1, factors = 3, scores = "Bartlett")
  fit2 <- stats::factanal(m1, factors = 3, scores = "regression")

  # augmented dataframe
  df1 <- broom::augment(fit1)
  df2 <- broom::augment(fit2)

  # augmented dataframe (with new data)
  df3 <- broom::augment(fit1, data = m2)
  df4 <- broom::augment(fit2, data = m2)

  # checking dataframe dimensions
  testthat::expect_is(df1, "tbl_df")
  testthat::expect_equal(dim(df1), c(18L, 4L))
  testthat::expect_equal(dim(df2), c(18L, 4L))
  testthat::expect_equal(dim(df3), c(18L, 10L))
  testthat::expect_equal(dim(df4), c(18L, 10L))
  testthat::expect_identical(names(df1), c(".rownames", ".fs1", ".fs2", ".fs3"))
  testthat::expect_identical(names(df3),
                             c(
                               ".rownames",
                               "v1",
                               "v2",
                               "v3",
                               "v4",
                               "v5",
                               "v6",
                               ".fs1",
                               ".fs2",
                               ".fs3"
                             ))
})
