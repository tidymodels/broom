context("kmeans tidiers")

test_that("kmeans tidiers work", {
    set.seed(2)
    x <- rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
               matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
    
    cl <- kmeans(x, 2)
    td <- tidy(cl)
    check_tidy(td, exp.row = 2, exp.col = 5)
    
    expect_error(augment(cl)) # data argument cannot be empty
    au <- augment(cl, x)
    check_tidy(au, exp.row = 100, exp.col = 3)
    
    gl <- glance(cl)
    check_tidy(gl, exp.col = 4)
})
