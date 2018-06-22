context("null-and-default")

test_that("augment.NULL", {
  expect_equal(augment(NULL), tibble())
})

test_that("augment.default", {
  expect_error(augment(TRUE))
  expect_error(augment(1))
  expect_error(augment(1L))
  expect_error(augment("a"))
  
  x <- 5
  class(x) <- c("foo", "bar")
  expect_error(augment(x), regexp = "foo")
  expect_error(augment(x), regexp = "[^bar]")
})

test_that("glance.NULL", {
  expect_null(glance(NULL))
})

test_that("glance.default", {
  expect_error(glance(TRUE))
  expect_error(glance(1))
  expect_error(glance(1L))
  expect_error(glance("a"))
  
  x <- 5
  class(x) <- c("foo", "bar")
  expect_error(glance(x), regexp = "foo")
  expect_error(glance(x), regexp = "[^bar]")
})
