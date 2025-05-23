skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("biglm")
suppressPackageStartupMessages(library(biglm))

fit <- biglm(mpg ~ wt + disp, mtcars)
fit2 <- bigglm(am ~ mpg, mtcars, family = binomial())

test_that("biglm tidier arguments", {
  check_arguments(tidy.biglm)
  check_arguments(glance.biglm)
})

test_that("tidy.biglm", {
  td <- tidy(fit)
  td2 <- tidy(fit2, conf.int = TRUE, conf.level = 0.9, exponentiate = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)

  check_dims(td, 3, 4)
})


test_that("glance.betareg", {
  gl <- glance(fit)
  check_glance_outputs(gl)

  gl2 <- glance(fit2)
  check_glance_outputs(gl2) # separate glance checks since different models
})
