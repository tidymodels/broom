context("ergm")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("ergm")
library(ergm)

data(florentine)
data(faux.mesa.high)

gest <- ergm(flomarriage ~ edges + absdiff("wealth"))
gest2 <- ergm(flomarriage ~ edges + absdiff("wealth"), family = "gaussian")
gest3 <- ergm(faux.mesa.high ~ edges + degree(1:3))

test_that("ergm tidier arguments", {
  check_arguments(tidy.ergm)
  check_arguments(glance.ergm)
})

test_that("tidy.ergm", {
  tde <- tidy(gest, conf.int = TRUE, exponentiate = TRUE)

  check_tidy_output(tde)

  # regression test for #688
  expect_true("term" %in% colnames(tde))

  # number of columns in output varies with ergm version
  # so this test is temporarily deactivated
  # check_dims(tde, 2, 7)

  # tidy.ergm warns when exponentiating w/o link
  expect_warning(td2 <- tidy(gest2, conf.int = TRUE, exponentiate = TRUE))

  check_tidy_output(td2)

  # see comment above:
  # check_dims(td2, 2, 7)
})

test_that("glance.ergm", {
  gl <- glance(gest, deviance = TRUE)
  gl2 <- glance(gest3, deviance = TRUE, mcmc = TRUE)
  expect_message(
    gl3 <- glance(gest, deviance = TRUE, mcmc = TRUE)
  )

  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 9)
  check_dims(gl2, expected_cols = 12)
  check_dims(gl, expected_cols = 9)
})
