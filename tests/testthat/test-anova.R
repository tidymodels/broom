context("anova tidiers")

test_that("tidy.aovlist works", {
  aovlistfit <- aov(mpg ~ wt + disp + Error(drat), mtcars)
  td <- tidy(aovlistfit)
  check_tidy(td, exp.row = 4, exp.col = 7)
  expect_true("Residuals" %in% td$term)
  
  # add in anova test with extra nested errors
  aovlistfit2 <- aov(mpg ~ wt + qsec + Error(cyl/(wt*qsec)), data = mtcars)
  td2 <- tidy(aovlistfit2)
  check_tidy(td2, exp.row = 7, exp.col = 7)
  expect_true("Residuals" %in% td2$term)
  expect_true(length(unique(td2$stratum)) == 5)
})
