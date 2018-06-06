context("Package wide tests")

if (requireNamespace("lintr", quietly = TRUE)) {
  context("lints")
  skip("Skip linting for now")
  test_that("Package Style", {
    lintr::expect_lint_free()
  })
}
