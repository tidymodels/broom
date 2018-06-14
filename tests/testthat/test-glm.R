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
      expected = structure(
        list(
          term = "mpg", 
          statistic = 13.5545656286209, 
          df = 1, 
          p.value = 0.000231727053726745
        ), 
        class = "data.frame", 
        .Names = c("term", "statistic", "df", "p.value"),
        row.names = c(NA, -1L)
      )
    )
  }
)
