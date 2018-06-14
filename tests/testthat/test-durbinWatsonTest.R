context("car tidiers")

test_that("tidy.durbinWatsonTest works", {
  skip_if_not_installed("car")
  
  dw <- car::durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
  td <- tidy(dw)
  check_tidy(td, exp.col = 5, exp.row = 1)
  
  expect_identical(td, glance(dw))
})
