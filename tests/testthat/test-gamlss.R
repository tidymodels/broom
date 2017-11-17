context("gamlss tidiers")

library(gamlss)
data(abdom)
mod <- gamlss(
    y ~ pb(x),
    sigma.fo =  ~ pb(x),
    family = BCT,
    data = abdom,
    method = mixed(1, 20),
    control = gamlss.control(trace = FALSE)
)

test_that("tidy.gamlss work", {
    td <- tidy(mod)
    check_tidy(td, exp.row = 6, exp.col = 6)
})

test_that("quick tidy.gamlss works", {
    td <- tidy(mod, quick = TRUE)
    check_tidy(td, exp.row = 2, exp.col = 2)
})
