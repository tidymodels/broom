skip_on_cran()

skip_if_not_installed("modeltests")
skip_if_not_installed("leaps")
library(modeltests)

test_that("tidy.regsubsets", {
  check_arguments(tidy.regsubsets)

  all_fits <- leaps::regsubsets(hp ~ ., mtcars)
  td <- tidy(all_fits)

  # column names are essentially those for glance,
  # also column names from training data sneak through,
  # so strict tests will fail
  check_tidy_output(td, strict = FALSE)
})
