context("boot tidiers")

test_that("boot tidiers work", {
    clotting <- data.frame(
        u = c(5, 10, 15, 20, 30, 40, 60, 80, 100),
        lot1 = c(118, 58, 42, 35, 27, 25, 21, 19, 18),
        lot2 = c(69, 35, 26, 21, 18, 16, 13, 12, 12)
    )
    
    g1 <- glm(lot2 ~ log(u), data = clotting, family = Gamma)
    
    bootfun <- function(d, i) {
        coef(update(g1, data = d[i, ]))
    }
    bootres <- boot::boot(clotting, bootfun, R = 100)
    td <- tidy(bootres, conf.int = TRUE)
    
    bootresw <- boot::boot(clotting, bootfun, R = 100, weights = rep(1 / 9, 9))
    tdw <- tidy(bootresw, conf.int = TRUE)
    
    check_tidy(td, exp.row = 2, exp.col = 6)
    check_tidy(tdw, exp.row = 2, exp.col = 7)
})

test_that("time series bootstrap tidying works", {
    lynx.fun <- function(tsb) {
        ar.fit <- ar(tsb, order.max = 25)
        c(ar.fit$order, mean(tsb), tsb)
    }
    lynx.1 <- boot::tsboot(log(lynx), lynx.fun, R = 99, l = 20, orig.t = FALSE)
    td <- tidy(lynx.1)
    check_tidy(td, exp.col = 2, exp.names = c("estimate", "std.error"))
})
