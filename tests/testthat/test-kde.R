context("kde tidier works")

test_that("tidy.kde works", {
  skip_if_not_installed("ks")
  set.seed(1)
  dat <- replicate(2, rnorm(100))
  k <- ks::kde(dat)
  td <- tidy(k)
  check_tidy(td, exp.col = 3)
})
