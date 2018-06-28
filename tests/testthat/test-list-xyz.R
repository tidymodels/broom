context("list-xyz")

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
  
  check_tidy_output(td)
  check_dims(td, 15, 3)
  
  expect_error(
    tidy(b),
    regexp = paste(
      "To tidy an xyz list, the length of element `x` must equal the number",
      "the number of rows of element `z`, and the length of element `y` must",
      "equal the number of columns of element `z`."
    )
  )
  
  expect_error(
    tidy(c),
    regexp = paste(
      "To tidy an xyz list, the length of element `x` must equal the number",
      "the number of rows of element `z`, and the length of element `y` must",
      "equal the number of columns of element `z`."
    )
  )
  
  expect_error(tidy(d), "To tidy an xyz list, `z` must be a matrix.")
})
