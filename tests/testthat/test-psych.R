context("psych")

test_that("tidy.kappa works", {
    rater1 <- 1:9
    rater2 <- c(1, 3, 1, 6, 1, 5, 5, 6, 7)
    suppressWarnings(ck <- psych::cohen.kappa(cbind(rater1, rater2)))
    td <- tidy(ck)
    check_tidy(td, exp.row = 2, exp.col = 4)
})
