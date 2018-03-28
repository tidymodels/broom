context("betareg tidiers")

library(betareg)

test_that("betareg tidiers work", {
    data(GasolineYield)
    mod <- betareg(yield ~ batch + temp, data = GasolineYield)

    td <- tidy(mod, conf.int = TRUE, conf.level = .99)
    au <- augment(mod)
    gl <- glance(mod)
    
    check_tidy(td, exp.row = 12, exp.col = 8)
    check_tidy(au, exp.row = 32, exp.col = 6)
    check_tidy(gl, exp.col = 6)
})
