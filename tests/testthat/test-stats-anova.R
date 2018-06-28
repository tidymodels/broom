context("stats-anova")

test_that("tidy.aov", {
  check_arguments(tidy.aov)
  
  aovfit <- aov(mpg ~ wt + disp, mtcars)
  td <- tidy(aovfit)
  
  check_tidy_output(td)
  check_dims(td, 3, 6)
  
  expect_true("Residuals" %in% td$term)
})

test_that("tidy.anova", {
  check_arguments(tidy.anova)
  
  anovafit <- anova(lm(mpg ~ wt + disp, mtcars))
  td <- tidy(anovafit)
  
  check_tidy_output(td)
  check_dims(td, 3, 6)
             
  expect_true("Residuals" %in% td$term)
  
  loess_anova <- anova(
    loess(dist ~ speed, cars),
    loess(dist ~ speed, cars, control = loess.control(surface = "direct"))
  )
  
  # TODO: can we throw a more informative error here
  expect_warning(tidy(loess_anova))
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


test_that("tidy.manova", {
  check_arguments(tidy.manova)
  
  df <- within(npk, foo <- rnorm(24))
  fit <- manova(cbind(yield, foo) ~ block + N * P * K, df)
  
  td <- tidy(fit)
  
  check_tidy_output(td)
  check_dims(td, 8, 7)
})

test_that("tidy.TukeyHSD", {
  check_arguments(tidy.TukeyHSD)
  
  aovfit <- aov(breaks ~ wool + tension, data = warpbreaks)
  thsd <- TukeyHSD(aovfit, "tension", ordered = TRUE)
  
  td <- tidy(thsd)
  
  check_tidy_output(td)
  check_dims(td, 3, 6)
})

