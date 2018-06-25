context("list")

test_that("optim tidiers works", {
  func <- function(x) {
    (x[1] - 2)^2 + (x[2] - 3)^2 + (x[3] - 8)^2
  }
  
  o <- optim(c(1, 1, 1), func)
  
  check_arguments(tidy_optim)
  check_arguments(glance_optim)

  td <- tidy(o)
  check_tidy_output(td)
  check_dims(td, 3, 2)

  gl <- glance(o)
  check_glance_outputs(gl)
})

test_that("xyz tidiers work", {
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

test_that("not all lists can be tidied", {
  nl <- list(a = NULL)
  
  expect_error(tidy(nl), "No tidy method recognized for this list.")
  expect_error(glance(nl), "No glance method recognized for this list.")
})
