context("bingroup tidiers")

library(binGroup)

test_that("binWidth tidiers work", {
    bw <- binWidth(100, .1)
    td <- tidy(bw)
    
    check_tidy(td, exp.row = 1, exp.col = 4)
})

test_that("binDesign tidiers work", {
    bd <- binDesign(nmax = 300, delta = 0.06, p.hyp = 0.1, power = .8)
    td <- tidy(bd)
    gl <- glance(bd)
    
    check_tidy(td, exp.col = 2)
    check_tidy(gl, exp.col = 4)
})
