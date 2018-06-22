context("car tidiers")

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


test_that(
  "tidy.anova from car", {
    skip_if_not_installed("car")
    model <- glm(am ~ mpg, mtcars, family = "binomial")
    car_output <- car::Anova(model, test.statistic = "LR")
    
    expect_equal(
      object = tidy(car_output),
      expected =
        tibble(
          term = "mpg",
          statistic = car_output$`LR Chisq`,
          df = car_output$Df,
          p.value = car_output$`Pr(>Chisq)`
        )
    )
  }
)
