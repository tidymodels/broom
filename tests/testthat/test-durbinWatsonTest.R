context("car tidiers")

skip_if_not_installed("car")

test_that("tidy.durbinWatsonTest", {
  
  check_arguments(tidy.durbinWatsonTest)

  dw <- car::durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
  td <- tidy(dw)
  gl <- glance(dw)
  
  check_tidy_output(td)
  check_glance_outputs(gl)
  
  check_dims(td, 1, 5)
})
