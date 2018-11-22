context("lmtest")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("leaps")

test_that("tidy.regsubsets", {
  
  check_arguments(tidy.regsubsets)
  
  all_fits <- leaps::regsubsets(hp ~ ., mtcars)
  td <- tidy(all_fits)
  
  check_tidy_output(td)
})
