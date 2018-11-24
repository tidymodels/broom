context("list-optim")

skip_if_not_installed("modeltests")
library(modeltests)

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

test_that("optim std.error inclusion works", {
  func <- function(x) {
    (x[1] - 2)^2 + (x[2] - 3)^2 + (x[3] - 8)^2
  }
  
  o <- optim(c(1, 1, 1), func, hessian = TRUE)
  
  check_arguments(tidy_optim)
  check_arguments(glance_optim)
  
  td <- tidy(o)
  check_tidy_output(td)
  check_dims(td, 3, 3)
  expect_true("std.error" %in% names(td))
})
