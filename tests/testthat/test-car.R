context("car")

skip_if_not_installed("modeltests")
library(modeltests)
library(survival)

skip_if_not_installed("car")

test_that("tidy.durbinWatsonTest", {
  
  check_arguments(tidy.durbinWatsonTest)
  
  dw <- car::durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
  td <- tidy(dw)
  gl <- glance(dw)
  
  check_tidy_output(td)
  check_glance_outputs(gl)
  
  check_dims(td, 1, 5)
})

test_that("tidy car::Anova glm", {
  
  fit <- glm(am ~ mpg, mtcars, family = "binomial")
  car_anova <- car::Anova(fit, test.statistic = "LR")
  
  expected <- tibble(
    term = "mpg",
    statistic = car_anova$`LR Chisq`,
    df = car_anova$Df,
    p.value = car_anova$`Pr(>Chisq)`
  )
  
  expect_equal(tidy(car_anova), expected)
})

test_that("tidy car::Anova coxph", {
  fit <- coxph(Surv(time, status) ~ differ, data = colon)
  car_anova_coxph <- car::Anova(fit)
  
  expected <- tibble(
    term = c(NULL, "differ"),
    logLik = car_anova_coxph$loglik,
    statistic = car_anova_coxph$Chisq,
    df = car_anova_coxph$Df,
    p.value = car_anova_coxph$`Pr(>|Chisq|)`
  )
  
  expect_equal(tidy(car_anova_coxph), expected)
})
