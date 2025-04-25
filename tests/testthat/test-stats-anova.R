skip_if_not_installed("modeltests")
library(modeltests)

test_that("tidy.aov", {
  aovfit <- aov(mpg ~ wt + disp, mtcars)
  td <- tidy(aovfit)
  td2 <- tidy(aovfit, intercept = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_dims(td, 3, 6)
  check_dims(td2, 4, 6)

  expect_true("Residuals" %in% td$term)
  expect_true("Residuals" %in% td2$term)
  expect_true("(Intercept)" %in% td2$term)
})

test_that("tidy.anova", {
  check_arguments(tidy.anova)

  m1 <- lm(mpg ~ wt + disp, mtcars)
  m2 <- update(m1, . ~ . - disp)
  anovafit <- stats::anova(m1)
  td <- tidy(anovafit)

  check_tidy_output(td)
  check_dims(td, 3, 6)

  anovacomp <- stats::anova(m2, m1)
  td2 <- tidy(anovacomp)

  # see #1159
  for (i in 1:20) {
    mtcars[[paste0("column", i)]] <- rnorm(nrow(mtcars))
  }
  m3 <- stats::glm(mpg ~ ., mtcars, family = stats::gaussian)
  anovacomp2 <- stats::anova(m1, m3)
  td3 <- tidy(anovacomp2)

  expect_equal(nrow(td3), 2)

  expect_true("Residuals" %in% td$term)

  loess_anova <- stats::anova(
    loess(dist ~ speed, cars),
    loess(dist ~ speed, cars, control = loess.control(surface = "direct"))
  )

  expect_snapshot(.res <- tidy(loess_anova))
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

  expect_equal(td_lht$term, "disp - hp")
  expect_equal(td_lht$null.value, 0)
  expect_equal(td_lht$estimate, -0.005506, tolerance = .0001)
})

# Matrix ABI version may differ (#1204)
skip_if_not_r_version("4.4.0")

skip_if_not_installed("lme4")
test_that("tidy.anova for merMod objects", {
  m1_mer <- lme4::lmer(mpg ~ wt + (1 | cyl), data = mtcars)
  m2_mer <- update(m1_mer, . ~ . + disp)
  aa_mer <- anova(m1_mer, m2_mer, refit = FALSE)
  td <- tidy(aa_mer)
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 2, 9)
})
