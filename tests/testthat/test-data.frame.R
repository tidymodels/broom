context("data.frame tidiers")

test_that("tidy.data.frame works", {
    tidy_df <- tidy(mtcars)
    check_tidy(tidy_df, exp.row = 11, exp.col = 13)
    expect_false("var" %in% names(tidy_df))
    expect_equal(names(tidy_df)[1], "column")
})

test_that("augment.data.frame throws an error", {
    expect_error(augment(mtcars))
})

test_that("glance.data.frame works", {
    glance_df <- glance(mtcars)
    check_tidy(glance_df, exp.row = 1, exp.col = 4)
})
