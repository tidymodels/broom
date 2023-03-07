context("mass-negbin")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("MASS")
library(MASS)

fit <- glm.nb(Days ~ Sex / (Age + Eth * Lrn), data = MASS::quine)

test_that("MASS::glm.nb tidier arguments", {
  check_arguments(tidy.negbin)
  check_arguments(glance.negbin)
})

test_that("tidy.negbin", {
  td1 <- tidy(fit)
  td2 <- tidy(fit, conf.int = TRUE)
  td3 <- tidy(fit, exponentiate = TRUE, conf.int = TRUE)

  check_tidy_output(td2)
  check_tidy_output(td1)

  expect_false(NA %in% td2$conf.low)
  expect_false(NA %in% td2$conf.high)

  # exponentiate arg check
  expect_equal(
    as.matrix(td3[, c("estimate", "conf.low", "conf.high")]),
    exp(as.matrix(td2[, c("estimate", "conf.low", "conf.high")]))
  )
})

test_that("glance.negbin", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 8)
})
