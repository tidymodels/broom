context("multinom tidiers")

library(nnet)

test_that("multinom tidiers work", {
    bwt.mu <- multinom(low ~ ., bwt)
    td <- tidy(bwt.mu, conf.int = TRUE)
    check_tidy(td, exp.row = 11, exp.col = 8)
    
    gl <- glance(bwt.mu)
    check_tidy(gl, exp.col = 3)
})
