context("kde tidier works")

library(ks)

test_that("tidy.kde works", {
    set.seed(1)
    dat <- replicate(2, rnorm(100))
    k <- kde(dat)
    td <- tidy(k)
    check_tidy(td, exp.col = 3)
})
