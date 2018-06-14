context("multinom tidiers")

test_that("multinom tidiers work", {
  skip_if_not_installed("nnet")
  
  fit.gear <- nnet::multinom(gear ~ mpg + factor(am),
    data = mtcars,
    trace = FALSE
  )
  td <- tidy(fit.gear, conf.int = TRUE)
  check_tidy(td, exp.row = 6, exp.col = 8)

  gl <- glance(fit.gear)
  check_tidy(gl, exp.col = 3)
})
