context("loess tidiers")

test_that("augment.loess works", {
    lo <- loess(mpg ~ wt, mtcars)
    au <- augment(lo)
    check_tidy(au, exp.col = 6)
})
