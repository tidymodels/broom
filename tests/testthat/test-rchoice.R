context("Rchoice")

skip_on_cran()
skip_if_not_installed("modeltests")
skip_if_not_installed("Rchoice")

library(modeltests)
library(Rchoice)

mod <- Rchoice(vs ~ mpg + hp + factor(cyl),
               data = mtcars,
               family = binomial("probit"))

test_that("Rchoice tidier arguments", {
  check_arguments(tidy.Rchoice)
  check_arguments(glance.Rchoice)
})

test_that("tidy.Rchoice", {
  t1 <- tidy(mod)
  t2 <- tidy(mod, conf.int = TRUE)
  t3 <- tidy(mod, conf.int = TRUE, conf.level = .99)
  g1 <- glance(mod)

  check_tidy_output(t1)
  check_tidy_output(t2)
  check_tidy_output(t3)
  check_dims(t1, expected_cols = 5, expected_rows = 5)
  check_dims(t2, expected_cols = 7, expected_rows = 5)
  check_dims(t3, expected_cols = 7, expected_rows = 5)

  check_glance_outputs(g1)
  check_dims(g1, expected_cols = 5, expected_rows = 1)
})
