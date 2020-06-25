context("list")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

test_that("not all lists can be tidied", {
  nl <- list(a = NULL)

  expect_error(tidy(nl), "No tidy method recognized for this list.")
  expect_error(glance(nl), "No glance method recognized for this list.")
})
