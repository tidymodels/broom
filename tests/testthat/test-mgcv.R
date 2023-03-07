context("mgcv")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("mgcv")

fit <- mgcv::gam(weight ~ s(Time) + factor(Diet), data = ChickWeight)

test_that("mgcv tidier arguments", {
  check_arguments(tidy.gam)
  check_arguments(glance.gam)
  check_arguments(augment.gam, strict = FALSE)
})

test_that("tidy.gam", {
  td <- tidy(fit)
  tdp <- tidy(fit, parametric = TRUE, conf.int = TRUE)
  tdp_exp <- tidy(fit, parametric = TRUE, conf.int = TRUE, exponentiate = TRUE)

  check_tidy_output(td, strict = FALSE)
  check_tidy_output(tdp)

  # test coef exponentiated
  expect_equal(
    as.matrix(tdp_exp[, c("estimate", "conf.low", "conf.high")]),
    exp(as.matrix(tdp[, c("estimate", "conf.low", "conf.high")]))
  )
})

test_that("glance.gam", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.gam", {
  suppressWarnings(
    check_augment_function(
      augment.gam,
      fit,
      data = ChickWeight,
      newdata = ChickWeight
    )
  )
})
