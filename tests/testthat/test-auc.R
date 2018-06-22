context("auc")
skip_if_not_installed("AUC")

test_that("AUC::roc tidier arguments", {
  check_arguments(tidy.roc)
})

test_that("tidy.roc", {
  
  data(churn, package = "AUC")
  r <- AUC::roc(churn$predictions, churn$labels)
  
  td <- tidy(r)
  check_tidy_output(td)
  check_dims(td, expected_cols = 3)
})
