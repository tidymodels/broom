context("ks")

skip_if_not_installed("ks")

test_that("tidy.kde", {
  
  check_arguments(tidy.kde)

  fit <- ks::kde(mtcars[, 1:3])
  td <- tidy(fit)
  
  check_tidy_output(td)
  check_dims(td, expected_cols = 4)
})
