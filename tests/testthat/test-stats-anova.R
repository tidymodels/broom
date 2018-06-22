context("stats-anova")

test_that("tidy.anova, tidy.aov, and tidy.aovlist work", {
  anovafit <- anova(lm(mpg ~ wt + disp, mtcars))
  td <- tidy(anovafit)
  check_tidy(td, exp.row = 3, exp.col = 6)
  expect_true("Residuals" %in% td$term)
  
  aovfit <- aov(mpg ~ wt + disp, mtcars)
  td <- tidy(aovfit)
  check_tidy(td, exp.row = 3, exp.col = 6)
  expect_true("Residuals" %in% td$term)
  
  aovlistfit <- aov(mpg ~ wt + disp + Error(drat), mtcars)
  td <- suppressWarnings(tidy(aovlistfit))
  check_tidy(td, exp.row = 4, exp.col = 7)
  expect_true("Residuals" %in% td$term)
})

test_that("tidy.anova warns unknown column names when comparing two loess", {
  loessfit <- anova(
    loess(dist ~ speed, cars),
    loess(dist ~ speed, cars, control = loess.control(surface = "direct"))
  )
  expect_warning(tidy(loessfit))
})


test_that("tidy.aovlist", {
  check_arguments("tidy.aovlist")
  
  aovlist <- aov(mpg ~ wt + disp + Error(drat), mtcars)
  aovlist2 <- aov(mpg ~ wt + qsec + Error(cyl / (wt * qsec)), data = mtcars)
  
  td <- tidy(aovlist)
  td2 <- tidy(aovlist2)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  
  check_dims(td, 4, 7)
  check_dims(td2, 7, 7)
  
  expect_true("Residuals" %in% td$term)
  expect_true("Residuals" %in% td2$term)
  expect_true(length(unique(td2$stratum)) == 5)
})


test_that("test.manova works", {
  npk2 <- within(npk, foo <- rnorm(24))
  npk2.aov <- manova(cbind(yield, foo) ~ block + N * P * K, npk2)
  td <- tidy(npk2.aov)
  check_tidy(td, exp.row = 8, exp.col = 7)
})



test_that("tidy.TukeyHSD works", {
  fm1 <- aov(breaks ~ wool + tension, data = warpbreaks)
  thsd <- TukeyHSD(fm1, "tension", ordered = TRUE)
  td <- tidy(thsd)
  check_tidy(td, exp.row = 3, exp.col = 6)
  td <- tidy(thsd, separate.levels = TRUE)
  check_tidy(td, exp.row = 3, exp.col = 7)
})

