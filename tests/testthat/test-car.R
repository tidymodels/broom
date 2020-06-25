context("car")

skip_on_cran()

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
  fit2 <- glm(am ~ mpg + wt, mtcars, family = "binomial")
  
  car_anova <- car::Anova(fit, test.statistic = "LR")
  car_anova2 <- car::Anova(fit2, test.statistic = "LR")
  
  td <- tidy(car_anova)
  td2 <- tidy(car_anova2)

  check_tidy_output(td)
  check_tidy_output(td2)
  
  check_dims(td, expected_rows = 1, expected_cols = 4)
  check_dims(td2, expected_rows = 2, expected_cols = 4)
})

test_that("tidy car::Anova coxph", {
  fit <- coxph(Surv(time, status) ~ differ, data = colon)
  fit2 <- coxph(Surv(time) ~ differ, data = colon)
  fit3 <- coxph(Surv(time) ~ differ + extent, data = colon)
  
  car_anova_coxph <- car::Anova(fit)
  car_anova_coxph2 <- car::Anova(fit2)
  car_anova_coxph3 <- car::Anova(fit3)

  td <- tidy(car_anova_coxph)
  td2 <- tidy(car_anova_coxph2)
  td3 <- tidy(car_anova_coxph3)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td3)
    
  check_dims(td, expected_rows = 2, expected_cols = 5)
  check_dims(td2, expected_rows = 2, expected_cols = 5)
  check_dims(td3, expected_rows = 2, expected_cols = 4)
})
