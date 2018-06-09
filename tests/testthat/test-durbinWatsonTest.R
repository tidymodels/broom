context("durbinWatsonTest tidiers")

test_that("tidy.durbinWatsonTest same as glance.durbinWatsonTest", {
  dw <- durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
  expect_identical(tidy(dw), glance(dw))
})

test_that("tidy.durbinWatsonTest works", {
  dw <- durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
  td <- tidy(dw)
  check_tidy(td, exp.col = 5, exp.row = 1)
})
