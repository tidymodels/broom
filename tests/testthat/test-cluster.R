context("test-cluster")

skip_if_not_installed("modeltests")
library(modeltests)

x <- iris %>%
  select(-Species)

fit <- pam(x, k = 3)

test_that("pam tidier arguments", {
  check_arguments(tidy.pam)
  check_arguments(glance.pam)
  check_arguments(augment.pam)
})

test_that("tidy.pam", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 3, 11)
})

test_that("glance.pam", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 1)
})

test_that("augment.pam", {
  
  check_augment_function(
    aug = augment.pam,
    model = fit,
    data = x,
    newdata = x
  )
})
