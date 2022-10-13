context("stats-glm")

skip_if_not_installed("modeltests")
library(modeltests)

test_that("glm tidier arguments", {
  check_arguments(tidy.glm) # just points to tidy.lm
  check_arguments(glance.glm)
  check_arguments(augment.glm)
})

nrow_mtcars <- nrow(mtcars)
glm_weights <- rep(c(0, 1), each = nrow_mtcars / 2)
gfit <- glm(am ~ wt, mtcars, family = "binomial")
gfit2 <- glm(cyl ~ wt + log(disp), mtcars, family = "poisson")
gfit3 <- glm(am ~ wt, mtcars, family = "binomial", weights = glm_weights)

# the gear term isn't defined for this fit
na_row_data <- mtcars[c(1, 2, 13:15, 22), ]
gfit_na_row <- glm(am ~ cyl * qsec + gear, data = na_row_data)

test_that("tidy.glm works", {
  td <- tidy(gfit)
  td2 <- tidy(gfit2)
  tde <- tidy(gfit, exponentiate = TRUE)
  tde2 <- tidy(gfit2, exponentiate = TRUE)
  td_na_row <- tidy(gfit_na_row)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(tde)
  check_tidy_output(tde2)
  check_tidy_output(td_na_row)

  check_dims(td, 2, 5)
  check_dims(td2, 3, 5)
  check_dims(td_na_row, expected_rows = 5)

  expect_equal(td$term, c("(Intercept)", "wt"))
  expect_equal(td2$term, c("(Intercept)", "wt", "log(disp)"))
})

test_that("glance.glm works", {
  gl <- glance(gfit)
  gl2 <- glance(gfit2)

  check_glance_outputs(gl)
  check_glance_outputs(gl2)
})


test_that("augment.glm", {
  check_augment_function(
    aug = augment.glm,
    model = gfit,
    data = mtcars,
    newdata = mtcars
  )

  check_augment_function(
    aug = augment.glm,
    model = gfit2,
    data = mtcars,
    newdata = mtcars
  )
})
