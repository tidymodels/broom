context("psych tidiers")

skip_if_not_installed("psych")

test_that("tidy.kappa works", {
  
  check_arguments(tidy.kappa)
  
  df <- tibble(
    rater1 = 1:9,
    rater2 = c(1, 3, 1, 6, 1, 5, 5, 6, 7)
  )
  
  suppressWarnings(fit <- psych::cohen.kappa(df))
  
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 2, 4)
})
