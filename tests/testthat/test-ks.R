context("ks")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("ks")

test_that("tidy.kde", {
  
  check_arguments(tidy.kde)

  fit <- ks::kde(purrr::keep(mtcars[, 1:3], is.numeric))
  td <- tidy(fit)
  
  check_tidy_output(td)
  check_dims(td, expected_cols = 4)
})
