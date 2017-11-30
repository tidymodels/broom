context("matrix tidiers")

test_that("matrix tidiers work", {
    mat <- as.matrix(mtcars)
    
    td <- tidy(mat)
    check_tidy(td, exp.row = 150, exp.col = 4)
    
    gl <- glance(mat)
    check_tidy(gl, exp.col = 4)
})
