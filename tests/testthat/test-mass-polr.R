context("mass-polr")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("MASS")
library(MASS)

fit <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
fit2 <- polr(Sat ~ Freq, data = housing)

test_that("MASS::polr tidier arguments", {
  check_arguments(tidy.polr)
  check_arguments(glance.polr)
  check_arguments(augment.polr)
})

test_that("tidy.polr", {
  
  td <- tidy(fit, quick = TRUE)
  td2 <- tidy(fit, conf.int = TRUE, exponentiate = TRUE)
  td3 <- tidy(fit2, conf.int = TRUE, exponentiate = TRUE)
  
  check_tidy_output(td, strict = FALSE)
  check_tidy_output(td2, strict = FALSE)
  check_tidy_output(td3, strict = FALSE)
  
  check_dims(td, expected_cols = 3)
  check_dims(td2, expected_cols = 7)
  check_dims(td3, expected_cols = 7)
})

test_that("glance.polr", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.polr", {
  check_augment_function(
    aug = augment.polr,
    model = fit,
    data = housing,
    newdata = housing
  )
})
