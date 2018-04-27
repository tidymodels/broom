context("smooth.spline tidiers")

test_that("smooth.spline tidiers work", {
    spl <- smooth.spline(mtcars$wt, mtcars$mpg, df = 4)
    
    au <- augment(spl)
    check_tidy(au, exp.row = 32, exp.col = 5)
    
    gl <- glance(spl)
    check_tidy(gl, exp.col = 7)
})
