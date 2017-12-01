context("glmnet tidiers")

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
