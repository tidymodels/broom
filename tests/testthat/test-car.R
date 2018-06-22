context("car")

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

test_that("tidy car::Anova", {
  
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
