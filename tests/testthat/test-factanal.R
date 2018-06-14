# test tidy, augment, glance from factanal objects

context("factanal tidiers")

test_that("tidy.factanal works", {
  n_factors <- 3
  fit <- factanal(mtcars, n_factors)
  td <- tidy(fit)
  check_tidy(td, exp.row = ncol(mtcars), exp.col = 2 + n_factors)
  expect_equal(td$variable, colnames(mtcars))

  n_factors2 <- 3
  fit2 <- factanal(mtcars, n_factors2)
  td2 <- tidy(fit2)
  expect_equal(ncol(td2), 2 + n_factors2)
})

test_that("glance.factanal works", {
  n_factors <- 3
  fit <- factanal(mtcars, n_factors)
  td <- glance(fit)
  check_tidy(td, exp.row = 1, exp.col = 8)
  expect_equal(td$n.factors, n_factors)
})

test_that("augment.factanal works", {
  n_factors <- 3
  fit <- factanal(mtcars, n_factors, scores = "regression")
  td <- augment(fit)
  check_tidy(td, exp.row = nrow(mtcars), exp.col = 1 + n_factors)
  expect_equal(td$.rowname, rownames(mtcars))

  fit2 <- factanal(mtcars, n_factors, scores = "Bartlett")
  td2 <- augment(fit2, mtcars)
  check_tidy(td2, exp.row = nrow(mtcars), exp.col = 1 + n_factors + ncol(mtcars))
})

test_that("augment.factanal does not support none scores", {
  n_factors <- 3
  fit <- factanal(mtcars, n_factors, scores = "none")
  expect_error(augment(fit))
  expect_error(augment(fit, mtcars))
})
