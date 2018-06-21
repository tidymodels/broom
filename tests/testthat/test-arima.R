context("Arima tidiers")

test_that("Arima tidiers work", {
  fit <- arima(lh, order = c(1, 0, 0))
  td <- tidy(fit, conf.int = TRUE)
  check_tidy(td, exp.row = 2, exp.col = 5)
  gl <- glance(fit)
  check_tidy(gl, exp.col = 4)
  fit_css <- arima(lh, order = c(1, 0, 0), method = "CSS")
  gl_css <- glance(fit_css)
  check_tidy(gl_css, exp.row = 1, exp.col = 2)
})
