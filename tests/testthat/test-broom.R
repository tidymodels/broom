context("Package wide tests")

test_that("Package Style", {
  skip("No linting test yet")
  # skip_if_not_installed("lintr")
  lintr::expect_lint_free()
})
