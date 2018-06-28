context("list")

test_that("not all lists can be tidied", {
  nl <- list(a = NULL)
  
  expect_error(tidy(nl), "No tidy method recognized for this list.")
  expect_error(glance(nl), "No glance method recognized for this list.")
})
