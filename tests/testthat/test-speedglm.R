context("speedglm")

skip_if_not_installed("speedglm")
library(speedglm)

fit <- speedlm(mpg ~ wt, mtcars)
fit2 <- lm(mpg ~ wt + disp, mtcars)

test_that("speedglm tidiers arguments", {
  check_arguments(tidy.speedlm)
  check_arguments(glance.speedlm)
  check_arguments(augment.speedlm)
})

test_that("tidy.speedlm", {
  
  td <- tidy(fit)
  td2 <- tidy(fit2)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  
  check_dims(td, 2)
  check_dims(td2, 3)
  
  expect_equal(td$term, c("(Intercept)", "wt"))
  expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
})

test_that("glance.speedlm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment works on speedlm", {
  check_augment_function(
    aug = augment.speedlm,
    model = fit, 
    data = mtcars,
    newdata = mtcars
  )
})
