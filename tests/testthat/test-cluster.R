context("cluster")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("cluster")
library(cluster)

skip_if_not_installed("modeldata")
library(modeldata)
data(hpc_data)

x <- hpc_data[, 2:5]
fit <- pam(x, k = 3)

test_that("pam tidier arguments", {
  check_arguments(tidy.pam)
  check_arguments(glance.pam)
  check_arguments(augment.pam)
})

test_that("tidy.pam", {
  td <- tidy(fit)

  # includes names of input data columns, so strict = FALSE
  check_tidy_output(td, strict = FALSE)
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
