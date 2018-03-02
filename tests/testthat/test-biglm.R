context("biglm")

library(biglm)

test_that("biglm tidiers work", {
    bfit <- biglm(mpg ~ wt + disp, mtcars)
    td <- tidy(bfit)
    tdq <- tidy(bfit, quick = TRUE)
    gl <- glance(bfit)
    
    check_tidy(
        td,
        exp.row = 3,
        exp.col = 4,
        exp.names = c("term", "estimate", "std.error", "p.value")
    )
    check_tidy(
        tdq,
        exp.row = 3,
        exp.col = 2,
        exp.names = c("term", "estimate")
    )
    check_tidy(gl, exp.col = 4)
})
