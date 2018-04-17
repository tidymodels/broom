context("glmnet tidiers")

set.seed(2014)
x <- matrix(rnorm(100 * 20), 100, 20)

test_that("glmnet tidiers work", {
    y <- rnorm(100)
    fit1 <- glmnet::glmnet(x, y)
    
    td <- tidy(fit1)
    check_tidy(td, exp.col = 5)
    
    gl <- glance(fit1)
    check_tidy(gl, exp.col = 2)
})

test_that("multinomial response glmnet tidier works", {
    g <- sample(1:4, 100, replace = TRUE)
    fit2 <- glmnet::glmnet(x, g, family = "multinomial")
    
    expect_warning(td <- tidy(fit2))
    check_tidy(td, exp.col = 6)
})

test_that("cv.glmnet tidiers work", {
    set.seed(2014)
    nobs <- 100
    nvar <- 50
    real <- 5
    x <- matrix(rnorm(nobs * nvar), nobs, nvar)
    beta <- c(rnorm(real, 0, 1), rep(0, nvar - real))
    y <- c(t(beta) %*% t(x)) + rnorm(nvar, sd = 3)
    cvfit1 <- glmnet::cv.glmnet(x, y)
    
    td <- tidy(cvfit1)
    check_tidy(td, exp.col = 6)
    
    gl <- glance(cvfit1)
    check_tidy(gl, exp.col = 2)
})

glm_td <- function() {
    cars_matrix <- model.matrix(mpg ~ wt + disp, data = mtcars)
    glm_fit <- glmnet::glmnet(cars_matrix[, -1], mtcars$mpg)
    glm_fit
}

cv_glm_td <- function() {
    set.seed(1234)
    cars_matrix <- model.matrix(mpg ~ wt + disp, data = mtcars)
    glm_fit <- glmnet::cv.glmnet(cars_matrix[, -1], mtcars$mpg)
    glm_fit
}

test_that("tidy.glmnet works", {
    td <- tidy(glm_td())
    tidy_names <- c("term", "step", "estimate", "lambda", "dev.ratio")
    check_tidy(td, exp.col = 5, exp.names = tidy_names)
    expect_true(all(c("(Intercept)", "wt", "disp") %in% td$term))
})

test_that("glance.glmnet works", {
    td <- glance(glm_td())
    tidy_names <- c("nulldev", "npasses")
    check_tidy(td, exp.row = 1, exp.col = 2, exp.names = tidy_names)
})

test_that("tidy.cv.glmnet works", {
    td <- tidy(cv_glm_td())
    tidy_names <- unlist(strsplit("lambda estimate std.error conf.high conf.low nzero", split = "[ ]"))
    check_tidy(td, exp.col = 6, exp.names = tidy_names)
})

test_that("glance.cv.glmnet works", {
    td <- glance(cv_glm_td())
    tidy_names <- c("lambda.min", "lambda.1se")
    check_tidy(td, exp.row = 1, exp.col = 2, exp.names = tidy_names)

})
