context("auc tidiers")
skip_if_not_installed("AUC")

test_that("tidy.roc", {
  check_tidy_arguments(tidy.roc)
  
  data(churn, package = "AUC")
  r <- AUC::roc(churn$predictions, churn$labels)
  
  td <- tidy(r)
  check_tidy_output(td)
  check_dims(td, expected_cols = 3)
})
