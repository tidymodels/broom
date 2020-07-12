context("mclust")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("mclust")
library(mclust)

skip_if_not_installed("modeldata")
library(modeldata)
data(hpc_data)

dat <- hpc_data[, 2:5]
dat3 <- hpc_data[, 2, drop = FALSE]
dat4 <- hpc_data[, 2]

fit <- Mclust(dat, G = 7, modelNames = "EII", verbose = FALSE)
fit2 <- Mclust(dat, G = 1, verbose = FALSE)
fit3 <- Mclust(dat3, G = 2, verbose = FALSE)
fit4 <- Mclust(dat4, G = 2, verbose = FALSE)

test_that("mclust tidier arguments", {
  check_arguments(tidy.Mclust)
  check_arguments(glance.Mclust)
  check_arguments(augment.Mclust, strict = FALSE)
})

test_that("tidy.Mclust", {
  td <- tidy(fit)
  td2 <- tidy(fit2)
  td3 <- tidy(fit3)
  td4 <- tidy(fit4)

  check_tidy_output(td, strict = FALSE)
  check_tidy_output(td2, strict = FALSE)
  check_tidy_output(td3, strict = FALSE)
  check_tidy_output(td4, strict = FALSE)

  check_dims(td, 7, 8)
  check_dims(td2, 1, 7)
  check_dims(td3, 2, 5)
  check_dims(td4, 2, 5)
})

test_that("glance.Mclust", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  gl3 <- glance(fit3)
  gl4 <- glance(fit4)

  check_glance_outputs(gl, gl2, gl3, gl4)
})

test_that("augment.Mclust", {
  check_augment_function(
    aug = augment.Mclust,
    model = fit,
    data = dat,
    newdata = dat
  )

  check_augment_function(
    aug = augment.Mclust,
    model = fit2,
    data = dat,
    newdata = dat
  )

  check_augment_function(
    aug = augment.Mclust,
    model = fit3,
    data = dat3,
    newdata = dat3,
    strict = FALSE
  )

  fit_on_vector <- Mclust(1:10)

  # fix later: tibble warnings since data matrix doesn't have column
  # names
  # expect_silent(
  #   augment(fit_on_vector)
  # )

  expect_error(
    augment(fit, 1:10),
    "`data` must be a data frame or matrix."
  )
})
