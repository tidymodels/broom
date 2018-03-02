context("mclust tidiers")

library(mclust)
dat <- iris[, 1:4]

test_that("mclust tidiers work", {
    mod1 <- Mclust(dat, G = 7, modelNames = "EII", verbose = FALSE)
    
    td <- tidy(mod1)
    check_tidy(td, exp.row = 7, exp.col = 8)
    
    au <- augment(mod1, dat)
    check_tidy(au, exp.row = 150, exp.col = 6)
    
    gl <- glance(mod1)
    check_tidy(gl, exp.col = 7)
})

test_that("G = 1 works", {
    mod2 <- Mclust(dat, G = 1, verbose = FALSE)
    td <- tidy(mod2)
    check_tidy(td, exp.row = 1, exp.col = 7)
})
