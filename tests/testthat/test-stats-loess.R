skip_if_not_installed("modeltests")
library(modeltests)

test_that("augment.loess", {
  check_arguments(augment.loess)

  fit <- loess(mpg ~ wt, mtcars)

  check_augment_function(
    aug = augment.loess,
    model = fit,
    data = mtcars,
    newdata = mtcars
  )
})
