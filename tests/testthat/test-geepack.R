context("geepack")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("geepack")
library(geepack)

dat <- data.frame(state.region, state.x77)

fit <- geeglm(
  Income ~ Frost + Murder,
  id = state.region,
  data = dat,
  corstr = "exchangeable"
)

test_that("tidy.geeglm", {
  check_arguments(tidy.geeglm)

  td <- tidy(fit, conf.int = TRUE)

  expect_warning(
    td2 <- tidy(fit, conf.int = FALSE, exponentiate = TRUE),
    regexp = paste(
      "Exponentiating coefficients, but model did not use a log",
      "or logit link function"
    )
  )

  check_tidy_output(td)
  check_tidy_output(td2)
})

test_that("glance.geeglm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})
