context("mgcv")

skip_if_not_installed("mgcv")

fit <- mgcv::gam(weight ~ s(Time) + factor(Diet), data = ChickWeight)

test_that("mgcv tidier arguments", {
  check_arguments(tidy.gam)
  check_arguments(glance.gam)
})

test_that("tidy.gam", {
  td <- tidy(fit)
  tdp <- tidy(fit, parametric = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(tdp)
})

test_that("glance.gam", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})


