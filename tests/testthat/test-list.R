context("list tidiers")

test_that("optim tidiers works", {
    func <- function(x) {
        (x[1] - 2) ^ 2 + (x[2] - 3) ^ 2 + (x[3] - 8) ^ 2
    }
    o <- optim(c(1, 1, 1), func)
    
    td <- tidy(o)
    check_tidy(td, exp.row = 3, exp.col = 2)
    
    gl <- glance(o)
    check_tidy(gl, exp.col = 4)
})

test_that("xyz tidiers work", {
    A <- list(x = 1:5,
              y = 1:3,
              z = matrix(runif(5 * 3), nrow = 5))
    td <- tidy(A)
    check_tidy(td, exp.row = 15, exp.col = 3)
    
    B <- list(x = 1:5,
              y = 1:3,
              z = matrix(runif(4 * 2), nrow = 4))
    expect_error(tidy(B))
    
    C <- list(x = 1:5,
              y = 1:3,
              z = matrix(runif(10 * 2), nrow = 5))
    expect_error(tidy(C))
})

test_that("not all lists can be tidied", {
    expect_error(tidy(list(A = NULL)))
    expect_error(glance(list(A = NULL)))
})
