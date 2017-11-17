context("lmodel2 tidiers")

library(lmodel2)

test_that("lmodel2 tidiers work", {
    data(mod2ex2)
    Ex2.res <- lmodel2(Prey ~ Predators, data = mod2ex2, "relative", "relative", 99)
    td <- tidy(Ex2.res)
    check_tidy(td, exp.row = 8, exp.col = 5)
    
    gl <- glance(Ex2.res)
    check_tidy(gl, exp.col = 4)
})
