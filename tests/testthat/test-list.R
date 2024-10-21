skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

test_that("not all lists can be tidied", {
  nl <- list(a = NULL)

  expect_snapshot(error = TRUE, tidy(nl))
  expect_snapshot(error = TRUE, glance(nl))
})
