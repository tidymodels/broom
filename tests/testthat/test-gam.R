if (requireNamespace("gam")) {
    context("gam models from package gam")
    data(kyphosis, package = "gam")
    g <- gam::gam(Kyphosis ~ gam::s(Age,4) + Number, family = binomial, data = kyphosis)
    test_that("tidy works on gam models", {
        td <- tidy(g)
        check_tidy(td, exp.row = 3, exp.col = 6)
    })
    test_that("glance works on gam models", {
        gl <- glance(g)
        check_tidiness(gl)
    })
}

if (requireNamespace("mgcv")) {
    context("gam models from package mgcv")
    d <- as.data.frame(ChickWeight)
    g <- mgcv::gam(weight ~ s(Time) + factor(Diet), data = d)
    test_that("tidy works on mgcv::gam models", {
        td <- tidy(g)
        check_tidiness(td)
        tdp <- tidy(g, parametric = TRUE)
        check_tidy(tdp, exp.col = 5)
    })
    test_that("glance works on mgcv::gam models", {
        gl <- glance(g)
        check_tidiness(gl)
    })
}
