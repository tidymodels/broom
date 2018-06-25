context("stats-smooth.spline")

fit <- smooth.spline(mtcars$wt, mtcars$mpg)

test_that("smooth.spline tidier arguments", {
  check_arguments(glance.smooth.spline)
  check_arguments(augment.smooth.spline)
})

test_that("glance.smooth.spline", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.smooth.spline", {
  check_augment_function(
    aug = augment.smooth.spline,
    model = fit,
    data = mtcars
  )
})
