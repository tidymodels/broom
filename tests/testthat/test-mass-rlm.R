context("mass-rlm")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("MASS")
library(MASS)

fit <- rlm(stack.loss ~ ., stackloss)

test_that("MASS::rlm tidier arguments", {
  check_arguments(tidy.rlm)
  check_arguments(glance.rlm)
  check_arguments(augment.rlm)
})

test_that("tidy.rlm", {
  
  td <- tidy(fit, quick = TRUE)
  td2 <- tidy(fit, conf.int = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  
  # regression test for #380
  expect_false(NA %in% td2$conf.low)
  expect_false(NA %in% td2$conf.high)
})

test_that("glance.rlm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 7)
})

test_that("augment.rlm", {
  
  check_augment_function(
    aug = augment.rlm,
    model = fit,
    data = stackloss,
    newdata = stackloss
  )
})
