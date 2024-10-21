test_that("augment.glmRob errors informatively", {
  x <- structure(1L, class = "glmRob")
  expect_snapshot(error = TRUE, augment(x))
})
