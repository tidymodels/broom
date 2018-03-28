context("matrix tidiers")

test_that("matrix tidiers work", {
    mat <- as.matrix(mtcars)
    
    td <- tidy(mat)
    check_tidy(td, exp.row = 32, exp.col = 12)
    
    gl <- glance(mat)
    check_tidy(gl, exp.col = 4)
})
