context("stats-time-series")

test_that("tidy.acf works", {
  check_arguments(tidy.acf)
  
  result <- acf(lh, plot = FALSE)
  td <- tidy(result)
  check_tidy_output(td)
  check_dims(td, 17, 2)
})


test_that("tidy.ts", {
  check_arguments(tidy.ts)
  
  x <- ts(1:10, frequency = 4, start = c(1959, 2))
  td <- tidy(x)
  check_tidy_output(td)
  
  z <- ts(matrix(rnorm(300), 100, 3), start = c(1961, 1), frequency = 12)
  td2 <- tidy(z)
  check_tidy_output(td2)
})


test_that("tidy.spec", {
  check_arguments(tidy.spec)
  
  spc <- spectrum(lh, plot = FALSE)
  td <- tidy(spc)
  
  check_tidy_output(td)
  check_dims(td, 24, 2)
})
