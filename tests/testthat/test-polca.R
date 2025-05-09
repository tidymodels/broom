skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("poLCA")
skip_if_not_installed("MASS")
suppressPackageStartupMessages(library(poLCA))

data(values)
fit <- poLCA(cbind(A, B, C, D) ~ 1, values, nclass = 2, verbose = FALSE)

test_that("poLCA tidier arguments", {
  check_arguments(tidy.poLCA)
  check_arguments(glance.poLCA)
  check_arguments(augment.poLCA)
})

test_that("tidy.poLCA", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 16, 5)
})

test_that("glance.poLCA", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 8)
})

test_that("augment.poLCA", {
  au <- augment(fit)

  check_augment_function(
    aug = augment.poLCA,
    model = fit,
    data = values,
    newdata = values,
    strict = FALSE
  )
})
