context("stats-times-series")

test_that("tidy.acf works", {
  result <- acf(lh, plot = FALSE)
  td <- tidy(result)
  check_tidy(td, exp.row = 17, exp.col = 2)
})


test_that("tidy.ts works for univariate series", {
  x <- ts(1:10, frequency = 4, start = c(1959, 2))
  tx <- tidy(x)
  check_tidiness(tx)
  check_tidy(tx, exp.names = c("index", "value"))
})

test_that("tidy.ts works for multivariate series", {
  z <- ts(matrix(rnorm(300), 100, 3), start = c(1961, 1), frequency = 12)
  tz <- tidy(z)
  check_tidiness(tz)
  check_tidy(tz, exp.names = c("index", "series", "value"))
})


test_that("tidy.specworks", {
  spc <- spectrum(lh, plot = FALSE)
  td <- tidy(spc)
  check_tidy(td, exp.row = 24, exp.col = 2)
})
