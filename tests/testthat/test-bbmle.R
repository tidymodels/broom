context("bbmle")

skip_if_not_installed("bbmle")

test_that("tidy.mle2", {
  
  check_arguments(tidy.mle2)
 
  df <- tibble(
    x = 0:10,
    y = c(26, 17, 13, 12, 20, 5, 9, 8, 5, 4, 8)
  )
  
  fit <- bbmle::mle2(y ~ dpois(lambda = ymean),
    start = list(ymean = 10), data = df
  )
  
  td <- tidy(fit, conf.int = TRUE)
  
  check_tidy_output(td)
  check_dims(td, 1, 7)
})
