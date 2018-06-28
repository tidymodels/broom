context("psych")

skip_if_not_installed("psych")

test_that("tidy.kappa works", {
  
  check_arguments(tidy.kappa)
  
  # breaks on R 3.4 is df is a tibble
  df <- cbind(
    rater1 = 1:9,
    rater2 = c(1, 3, 1, 6, 1, 5, 5, 6, 7)
  )
  
  fit <- psych::cohen.kappa(df)
  
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 2, 4)
})
