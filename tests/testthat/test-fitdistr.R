context("fitdistr tidiers")

test_that("fitdistr tidiers work", {
    set.seed(2015)
    x <- rnorm(100, 5, 2)
    fit <- suppressWarnings(MASS::fitdistr(x, dnorm, list(mean = 3, sd = 1)))
    td <- tidy(fit)
    check_tidy(td, exp.row = 2, exp.col = 3)
    
    gl <- glance(fit)
    check_tidy(gl, exp.col = 4)
})
