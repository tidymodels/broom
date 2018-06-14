context("straighten.R")

# The examples for straighten apply tidy, glance, and augment.

fit1 <- lm(mpg ~ wt + disp, data = mtcars)
fit2 <- lm(mpg ~ wt + disp + factor(gear), data = mtcars)

test_that(
  "Cast an error if fn is not tidy, glance, or augment",
  {
    expect_error(
        straighten(fit1, fit2, fn = as.data.frame)
    )
  }
)

test_that(
  "Names are correctly allocated with unnamed arguments",
  {
    expect_equal(
      straighten(fit1, fit2, fn = glance)$model,
      c("fit1", "fit2")
    )
  }
)

test_that(
  "Names are correctly allocated with unnamed arguments",
  {
    expect_equal(
      straighten(fit1, model2 = fit2, fn = glance)$model,
      c("fit1", "model2")
    )
  }
)
