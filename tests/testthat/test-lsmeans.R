context("lsmeans tidiers")

suppressPackageStartupMessages(library(lsmeans))
oranges_lm1 <- lm(sales1 ~ price1 + price2 + day + store, data = oranges)
oranges_rg1 <- ref.grid(oranges_lm1)
marginal <- lsmeans(oranges_rg1, "day")

test_that("lsmobj tidiers work", {
    td <- tidy(marginal)
    check_tidy(td, exp.row = 6, exp.col = 6)
})

test_that("ref.grid tidiers work", {
    td <- tidy(oranges_rg1)
    check_tidy(td, exp.row = 36, exp.col = 7)
})

test_that("pairwise contrasts work", {
    td <- tidy(contrast(marginal, method = "pairwise"))
    check_tidy(td, exp.row = 15, exp.col = 7)
})
