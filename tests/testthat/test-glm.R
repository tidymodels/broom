context("glm tidiers")

test_that("glance.glm works", {
  g <- glm(am ~ mpg, mtcars, family = "binomial")
  gl <- glance(g)
  check_tidy(gl, exp.col = 7)
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
