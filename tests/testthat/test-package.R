context("package")

skip_if_not_installed("lintr")

test_that("passes lintr check", {
  skip("Don't lint yet")
  lintr::expect_lint_free()
})

# automate goodpractice tests?
