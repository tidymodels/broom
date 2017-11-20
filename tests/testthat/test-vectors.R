context("vector tidiers")

test_that("tidying numeric vectors works", {
    vec <- 1:10
    tidy_vec <- tidy(vec)
    check_tidy(tidy_vec, exp.row = 10, exp.col = 1)
    # test with names
    vec2 <- vec
    names(vec2) <- LETTERS[1:10]
    tidy_vec2 <- tidy(vec2)
    check_tidy(tidy_vec2, exp.row = 10, exp.col = 2)
    expect_true(all(c("names", "x") %in% names(tidy_vec2)))
})

test_that("tidying logical vectors works", {
    vec <- rep(c(TRUE, FALSE), 5)
    tidy_vec <- tidy(vec)
    check_tidy(tidy_vec, exp.row = 10, exp.col = 1)
    # test with names
    vec2 <- vec
    names(vec2) <- 1:10
    tidy_vec2 <- tidy(vec2)
    check_tidy(tidy_vec2, exp.row = 10, exp.col = 2)
    expect_true(all(c("names", "x") %in% names(tidy_vec2)))
})

test_that("tidying character vectors works", {
    vec <- LETTERS[1:10]
    tidy_vec <- tidy(vec)
    check_tidy(tidy_vec, exp.row = 10, exp.col = 1)
    # test with names
    vec2 <- vec
    names(vec2) <- 1:10
    tidy_vec2 <- tidy(vec2)
    check_tidy(tidy_vec2, exp.row = 10, exp.col = 2)
    expect_true(all(c("names", "x") %in% names(tidy_vec2)))
})
