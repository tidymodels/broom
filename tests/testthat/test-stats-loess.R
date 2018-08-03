context("stats-loess")

skip_if_not_installed("modeltests")
library(modeltests)
library(broom)

test_that("augment.loess", {
  check_arguments(augment.loess, strict = FALSE)
  
  fit <- loess(mpg ~ wt, mtcars)
  
  check_augment_function(
    aug = augment.loess,
    model = fit, 
    data = mtcars,
    newdata = mtcars,
    strict = FALSE
  )
})
