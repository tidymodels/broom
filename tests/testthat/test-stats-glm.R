context("stats-glm")

test_that("glm tidier arguments", {
  
  # note that:
  #   - tidy.glm just points to tidy.lm
  #   - augment.glm just points to augment.lm
  
  check_arguments(tidy.glm)
  check_arguments(glance.glm)
  check_arguments(augment.glm)
})

gfit <- glm(am ~ wt, mtcars, family = "binomial")
gfit2 <- glm(cyl ~ wt + disp, mtcars, family = "poisson")

test_that("tidy.glm works", {
  
  td <- tidy(gfit)
  td2 <- tidy(gfit2)
  tde <- tidy(gfit, exponentiate = TRUE)
  tde2 <- tidy(gfit2, exponentiate = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(tde)
  check_tidy_output(tde2)
  
  check_dims(td, 2, 5)
  check_dims(td2, 3, 5)
  
  expect_equal(td$term, c("(Intercept)", "wt"))
  expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
})

test_that("glance.glm works", {
  gl <- glance(gfit)
  gl2 <- glance(gfit2)
  
  check_glance_outputs(gl)
  check_glance_outputs(gl2)
})


test_that("augment.glm", {
  check_augment_function(
    aug = augment.lm,
    model = gfit,
    data = mtcars,
    newdata = mtcars
  )
  
  check_augment_function(
    aug = augment.lm,
    model = gfit2,
    data = mtcars,
    newdata = mtcars
  )
})

