context("ergm")

skip_if_not_installed("ergm")
library(ergm)
data(florentine)

gest <- ergm(flomarriage ~ edges + absdiff("wealth"))
gest2 <- ergm(flomarriage ~ edges + absdiff("wealth"), family = "gaussian")

test_that("ergm tidier arguments", {
  check_arguments(tidy.ergm)
  check_arguments(glance.ergm)
})

test_that("tidy.ergm", {
  tdq <- tidy(gest, quick = TRUE)
  tde <- tidy(gest, conf.int = TRUE, exponentiate = TRUE)
  
  check_tidy_output(tdq)
  check_tidy_output(tde)
  
  check_dims(tdq, 2, 2)
  check_dims(tde, 2, 7)
  
  # tidy.ergm warns when exponentiating w/o link
  expect_warning(td2 <- tidy(gest2, conf.int = TRUE, exponentiate = TRUE))
  
  check_tidy_output(td2)
  check_dims(td2, 2, 7)
})

test_that("glance.ergm", {
  
  gl <- glance(gest, deviance = TRUE, mcmc = TRUE)
  
  check_glance_outputs(gl)
  check_dims(gl, expected_col = 12)
})
