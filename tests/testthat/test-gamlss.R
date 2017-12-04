context("gamlss tidiers")

data(abdom, package = "gamlss.data")
mod <- gamlss::gamlss(
    y ~ gamlss::pb(x),
    sigma.fo =  ~ gamlss::pb(x),
    family = gamlss.dist::BCT,
    data = abdom,
    method = mixed(1, 20),
    control = gamlss::gamlss.control(trace = FALSE)
)

test_that("tidy.gamlss work", {
    td <- tidy(mod)
    check_tidy(td, exp.row = 6, exp.col = 6)
})

test_that("quick tidy.gamlss works", {
    td <- tidy(mod, quick = TRUE)
    check_tidy(td, exp.row = 2, exp.col = 2)
})
