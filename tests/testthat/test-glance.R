context("NULL and default glance")

test_that("NULL glance returns NULL", {
    expect_length(glance(NULL), 0)
})

test_that("default glance throws error for unimplemented methods", {
    expect_error(glance(TRUE))
    expect_error(glance(1))
    expect_error(glance(1L))
    expect_error(glance("a"))
})
