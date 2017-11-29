context("zoo tidiers")

test_that("tidy.zoo works", {
    set.seed(1071)
    Z.index <- zoo::as.Date(sample(12450:12500, 10))
    Z.data <- matrix(rnorm(30), ncol = 3)
    colnames(Z.data) <- c("Aa", "Bb", "Cc")
    Z <- zoo::zoo(Z.data, Z.index)

    td <- tidy(Z)
    check_tidy(td, exp.row = 30, exp.col = 3)
})
