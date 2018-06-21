context("null-and-default")

test_that("augment.NULL returns empty tibble", {
  expect_equal(augment(NULL), tibble())
})

test_that("augment.defaults errors for unimplemented methods", {
  expect_error(augment(TRUE))
  expect_error(augment(1))
  expect_error(augment(1L))
  expect_error(augment("a"))
  
  x <- 5
  class(x) <- c("foo", "bar")
  expect_error(augment(x), regexp = "foo")
  expect_error(augment(x), regexp = "[^bar]")
})
