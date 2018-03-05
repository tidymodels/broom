context("orcutt tidiers")

library(orcutt)

test_that("orcutt tidiers work", {
    reg <- lm(mpg ~ wt + qsec + disp, mtcars)
    co <- cochrane.orcutt(reg)
    td <- tidy(co)
    check_tidy(td, exp.row = 4, exp.col = 5)
    
    gl <- glance(co)
    check_tidy(gl, exp.col = 8)
})
