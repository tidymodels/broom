context("stats-arima")

fit1 <- arima(lh, order = c(1, 0, 0))

fit2 <- arima(
  USAccDeaths,
  order = c(0, 1, 1),
  seasonal = list(order = c(0, 1, 1)),
  method = "CSS"
)

test_that("Arima tidier arguments", {
  check_arguments(tidy.Arima)
  check_arguments(glance.Arima)
})

test_that("tidy.Arima", {
  td1 <- tidy(fit1, conf.int = TRUE)
  force(td1)
  check_tidy_output(td1)
  check_dims(td1, 2, 5)
  
  td2 <- tidy(fit2)
  check_tidy_output(td2)
  check_dims(td2, 2, 3)
})

test_that("glance.Arima", {
  gl1 <- glance(fit1)
  gl2 <- glance(fit2)
  
  check_glance_outputs(gl1, gl2)
})
