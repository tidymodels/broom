context("hmisc")

skip_if_not_installed("Hmisc")

test_that("tidy.rcorr", {
  check_arguments(tidy.rcorr)
  
  mat <- replicate(52, rnorm(100))
  mat[sample(length(mat), 2000)] <- NA
  colnames(mat) <- c(LETTERS, letters)
  rc <- Hmisc::rcorr(mat)
  
  td <- tidy(rc)
  
  check_tidy_output(td)
  check_dims(td, expected_cols = 5)
})
