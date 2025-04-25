skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("spdep")
suppressPackageStartupMessages(library(spdep))

skip_if_not_installed("spatialreg")
suppressPackageStartupMessages(library(spatialreg))

data(oldcol, package = "spdep")
listw <- spdep::nb2listw(COL.nb, style = "W")

fit_lag <- lagsarlm(
  CRIME ~ INC + HOVAL,
  data = COL.OLD,
  listw = listw,
  method = "eigen"
)
fit_error <- errorsarlm(CRIME ~ INC + HOVAL, data = COL.OLD, listw)

fit_sac <- sacsarlm(CRIME ~ INC + HOVAL, data = COL.OLD, listw)

test_that("spdep tidier arguments", {
  check_arguments(tidy.sarlm)
  check_arguments(glance.sarlm)
  check_arguments(augment.sarlm, strict = FALSE)
})

test_that("tidy.sarlm", {
  td1 <- tidy(fit_lag)
  td2 <- tidy(fit_error)
  td3 <- tidy(fit_sac)
  td4 <- tidy(fit_sac, conf.int = TRUE)

  check_tidy_output(td1)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td4)

  check_dims(td1, 4, 5)
  check_dims(td2, 4, 5)
  check_dims(td3, 5, 5)
  check_dims(td4, 5, 7)
})


test_that("glance.sarlm", {
  gl1 <- glance(fit_lag)
  gl2 <- glance(fit_error)
  gl3 <- glance(fit_sac)

  check_glance_outputs(gl1, gl2, gl3)

  check_dims(gl1, 1, 6)
  check_dims(gl2, 1, 6)
  check_dims(gl3, 1, 6)
})

test_that("augment.sarlm", {
  check_augment_function(
    aug = augment.sarlm,
    model = fit_lag,
    data = fit_lag$X,
    strict = FALSE
  )
})
