skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

test_that("tidy_xyz", {
  check_arguments(tidy_xyz)

  a <- list(
    x = 1:5,
    y = 1:3,
    z = matrix(runif(5 * 3), nrow = 5)
  )

  b <- list(
    x = 1:5,
    y = 1:3,
    z = matrix(runif(4 * 2), nrow = 4)
  )

  c <- list(
    x = 1:5,
    y = 1:3,
    z = matrix(runif(10 * 2), nrow = 5)
  )

  d <- list(x = 1:5, y = 1:3, z = "cat")

  check_arguments(tidy_xyz)

  td <- tidy(a)

  check_tidy_output(td, strict = FALSE)
  check_dims(td, 15, 3)

  expect_true(is.numeric(td$x))
  expect_true(is.numeric(td$y))
  expect_true(is.numeric(td$z))

  expect_snapshot(error = TRUE, tidy(b))
  expect_snapshot(error = TRUE, tidy(c))
  expect_snapshot(error = TRUE, tidy(d))
})
