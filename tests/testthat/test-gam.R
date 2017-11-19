if (requireNamespace("gam")) {
    context("gam models from package gam")
    data(kyphosis, package = "gam")
    g <- gam::gam(Kyphosis ~ gam::s(Age,4) + Number, family = binomial, data = kyphosis)
    test_that("tidy works on gam models", {
        tidy(g)    
    })
    test_that("glance works on gam models", {
        glance(g)    
    })
}

if (requireNamespace("mgcv")) {
    context("gam models from package mgcv")
    d <- as.data.frame(ChickWeight)
    g <- mgcv::gam(weight ~ s(Time) + factor(Diet), data = d)
    test_that("tidy works on mgcv::gam models", {
        tidy(g) 
        tidy(g, parametric = TRUE) 
    })
    test_that("glance works on mgcv::gam models", {
        glance(g)
    })
}

