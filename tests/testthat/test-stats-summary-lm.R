skip_if_not_installed("modeltests")
library(modeltests)

test_that("summary.lm tidier arguments", {
  check_arguments(tidy.summary.lm)
  check_arguments(glance.summary.lm)
})

fit <- lm(mpg ~ wt, mtcars)
fit_summ <- summary(fit)

fit2 <- lm(mpg ~ wt + log(disp), mtcars)
fit2_summ <- summary(fit2)

test_that("tidy.summary.lm works", {
  td <- tidy(fit)
  std <- tidy(fit_summ)
  td2 <- tidy(fit2, conf.int = TRUE)
  std2 <- tidy(fit2_summ, conf.int = TRUE)

  check_tidy_output(std)
  check_tidy_output(std2)

  expect_equal(td, std)
  expect_equal(td2, std2)
})

test_that("glance.summary.lm", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  sgl <- glance(fit_summ)
  sgl2 <- glance(fit2_summ)

  check_glance_outputs(sgl, sgl2)

  expect_equal(
    dplyr::select(gl, -c("logLik", "AIC", "BIC", "deviance")),
    sgl
  )
  expect_equal(
    dplyr::select(gl2, -c("logLik", "AIC", "BIC", "deviance")),
    sgl2
  )
})
