context("auc tidiers")

library(AUC)

test_that("tidy.roc works", {
    data(churn)
    r <- roc(churn$predictions,churn$labels)
    td <- tidy(r)
    check_tidy(td, exp.col = 3)
})
