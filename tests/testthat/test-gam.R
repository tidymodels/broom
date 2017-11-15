context("gam models from package gam")

library(gam)

test_that("tidy and glance work on gam models", {
    data(kyphosis)
    g <- gam::gam(Kyphosis ~ gam::s(Age, 4) + Number, family = binomial,
                  data = kyphosis)
    td <- tidy(g)
    gl <- glance(g)
    
    check_tidy(td, exp.row = 3, exp.col = 6)
    check_tidy(gl, exp.col = 6)
})


context("gam models from package mgcv")

library(mgcv)

test_that("tidy and glance work on mgcv::gam models", {
    set.seed(2)
    dat <- gamSim(1, n = 400, dist = "normal", scale = 2, verbose = FALSE)
    b <- mgcv::gam(y ~ s(x0) + s(x1) + s(x2) + s(x3), data = dat)
    td <- tidy(b)
    tdp <- tidy(b, parametric = TRUE)
    gl <- glance(b)
    
    check_tidy(td, exp.row = 4, exp.col = 5)
    check_tidy(tdp, exp.col = 5)
    check_tidy(gl, exp.col = 6)
})

