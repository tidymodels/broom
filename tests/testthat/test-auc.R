context("auc tidiers")

test_that("tidy.roc works", {
    data(churn, package = "AUC")
    r <- AUC::roc(churn$predictions, churn$labels)
    td <- tidy(r)
    check_tidy(td, exp.col = 3)
})
