context("stats-anova")

skip_if_not_installed("modeltests")
library(modeltests)

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

  anovafit <- stats::anova(lm(mpg ~ wt + disp, mtcars))
  td <- tidy(anovafit)

  check_tidy_output(td)
  check_dims(td, 3, 6)

  expect_true("Residuals" %in% td$term)

  loess_anova <- stats::anova(
    loess(dist ~ speed, cars),
    loess(dist ~ speed, cars, control = loess.control(surface = "direct"))
  )

  expect_warning(tidy(loess_anova))
})

test_that("glance.anova", {
  check_arguments(glance.anova)
  
  a <- lm(mpg ~ wt + qsec + disp, mtcars)
  b <- lm(mpg ~ wt + qsec, mtcars)
  gl <- glance(anova(a, b))
  
  check_glance_outputs(gl)
  check_dims(gl, 1, 2)
  
  gl_a <- glance(anova(a))
  check_dims(gl_a, 0, 0)
})

test_that("tidy.aovlist", {
  check_arguments(tidy.aovlist)

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
  fit <- stats::manova(cbind(yield, foo) ~ block + N * P * K, df)

  td <- tidy(fit)

  check_tidy_output(td, strict = FALSE)
  check_dims(td, 8, 7)
})

test_that("tidy.TukeyHSD", {
  check_arguments(tidy.TukeyHSD)

  aovfit <- aov(breaks ~ wool + tension, data = warpbreaks)
  thsd <- TukeyHSD(aovfit, "tension", ordered = TRUE)

  td <- tidy(thsd)

  check_tidy_output(td, strict = FALSE)
  check_dims(td, 3, 7)
})

test_that("tidy.linearHypothesis", {
  skip_if_not_installed("car")

  fit <- stats::lm(mpg ~ disp + hp, mtcars)
  fit_lht <- car::linearHypothesis(fit, "disp = hp")

  td_lht <- tidy(fit_lht)

  check_tidy_output(td_lht, strict = FALSE)
  check_dims(td_lht, 1, 10)

  expect_true("null.value" %in% colnames(td_lht))
  
  expect_equal(td_lht$term, 'disp - hp')
  expect_equal(td_lht$null.value, 0)
  expect_equal(td_lht$estimate, -0.00551, tolerance = .00001)

})


