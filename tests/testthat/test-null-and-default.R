skip_if_not_installed("modeltests")
library(modeltests)

test_that("tidy.NULL", {
  expect_equal(tidy(NULL), tibble())
})

test_that("tidy.default", {
  expect_snapshot(error = TRUE, td <- tidy(raw(1)))

  x <- 5
  class(x) <- c("foo", "bar")
  expect_snapshot(error = TRUE, glance(x))
  expect_snapshot(error = TRUE, glance(x))
})


test_that("glance.NULL", {
  expect_equal(glance(NULL), tibble())
})

test_that("glance.default", {
  expect_snapshot(error = TRUE, glance(TRUE))
  expect_snapshot(error = TRUE, glance(1))
  expect_snapshot(error = TRUE, glance(1L))
  expect_snapshot(error = TRUE, glance("a"))

  x <- 5
  class(x) <- c("foo", "bar")
  expect_snapshot(error = TRUE, glance(x))
  expect_snapshot(error = TRUE, glance(x))
})

test_that("augment.NULL", {
  expect_equal(augment(NULL), tibble())
})

test_that("augment.default", {
  expect_snapshot(error = TRUE, augment(TRUE))
  expect_snapshot(error = TRUE, augment(1))
  expect_snapshot(error = TRUE, augment(1L))
  expect_snapshot(error = TRUE, augment("a"))

  x <- 5
  class(x) <- c("foo", "bar")
  expect_snapshot(error = TRUE, augment(x))
  expect_snapshot(error = TRUE, augment(x))
})
