context("Arima tidiers")

fit1 <- arima(lh, order = c(1, 0, 0))

fit2 <- arima(
  USAccDeaths,
  order = c(0, 1, 1),
  seasonal = list(order = c(0, 1, 1)),
  method = "CSS"
)

test_that("tidy.Arima", {
  check_tidy_arguments(tidy.Arima)
  
  td1 <- tidy(fit1, conf.int = TRUE)
  check_tidy_output(td1)
  check_dims(td1, 2, 5)
  
  td2 <- tidy(fit2)
  check_tidy_output(td2)
  check_dims(td2, 2, 3)
})

test_that("glance.Arima", {
  check_glance_arguments(glance.Arima)
  
  gl1 <- glance(fit1)
  check_glance_output(gl1)
  
  # currently failing. the first of many bugs to emerge i presume.
  gl2 <- glance(fit2)  
  check_glance_output(gl2)
  
  check_glance_multiple_outputs(gl1, gl2)
})
