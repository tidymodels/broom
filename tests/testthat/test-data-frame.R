test_that("glance.tbl_df errors informatively", {
  expect_snapshot(error = TRUE, glance.tbl_df(tibble::tibble(x = 1)))
})
