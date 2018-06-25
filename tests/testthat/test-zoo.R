context("zoo")

skip_if_not_installed("zoo")

test_that("tidy.zoo", {
  set.seed(1071)
  z.index <- zoo::as.Date(sample(12450:12500, 10))
  z.data <- matrix(rnorm(30), ncol = 3)
  
  colnames(z.data) <- c("Aa", "Bb", "Cc")
  z <- zoo::zoo(z.data, z.index)
  
  check_arguments(tidy.zoo)

  td <- tidy(z)
  check_tidy_output(td)
  check_dims(td, 30, 3)
})
