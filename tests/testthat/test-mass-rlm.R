context("mass-rlm")

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
})

test_that("glance.rlm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 6)
})

test_that("augment.rlm", {
  
  au <- augment(fit)
  check_tibble(au, method = "augment")
  
  check_augment_function(
    aug = augment.rlm,
    model = fit,
    data = stackloss,
    newdata = stackloss
  )
})
