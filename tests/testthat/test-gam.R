if (requireNamespace("gam")) {
    data(kyphosis, package = "gam")
    g <- gam::gam(Kyphosis ~ gam::s(Age,4) + Number, family = binomial, data = kyphosis)
    
    td <- tidy(g)
}
