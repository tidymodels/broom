context("margins")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("margins")

fit1 <- glm(am ~ cyl + hp + wt, data = mtcars, family = binomial)
marg1 <- margins::margins(fit1)

fit2 <- lm(mpg ~ wt * cyl * disp, data = mtcars)
marg2a <- margins::margins(fit2)
marg2b <- margins::margins(fit2, variable = "wt")
marg2c <- margins::margins(fit2, at = list(cyl = c(4, 6, 8)))
marg2d <- margins::margins(fit2, variables = "wt", at = list(cyl = c(4, 6, 8), drat = c(3, 3.5, 4)))

test_that("margins tidier arguments", {
  check_arguments(tidy.margins)
  check_arguments(glance.margins)
})

test_that("tidy.margins", {
  td1a <- tidy(marg1)
  td1b <- tidy(marg1, conf.int = TRUE)
  td2a <- tidy(marg2a)
  td2b <- tidy(marg2b)
  td2c <- tidy(marg2c)
  td2d <- tidy(marg2d)

  check_tidy_output(td1a)
  check_tidy_output(td1b)
  check_tidy_output(td2a)
  check_tidy_output(td2b)
  check_tidy_output(td2c)
  check_tidy_output(td2d)

  check_dims(td1a, 3, 5)
})

test_that("glance.margins", {
  gl1 <- glance(fit1)
  gl2 <- glance(fit2)

  check_dims(gl1, expected_cols = 8)
  check_dims(gl2, expected_cols = 12)
})
