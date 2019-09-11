context("pls-mvr")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("pls")
library(pls)
library(modeltests)

data(yarn)
yarn_pcr <- pcr(density ~ NIR, 6, data = yarn, validation = "CV")
yarn_pls <- plsr(density ~ NIR, 5, data = yarn, validation = "CV")
yarn_cppls <- cppls(density ~ NIR, 6, data = yarn, validation = "CV")

data(oliveoil)
sens_pcr <- pcr(sensory ~ chemical, ncomp = 4, scale = TRUE, data = oliveoil)
sens_pls <- plsr(sensory ~ chemical, ncomp = 4, scale = TRUE, data = oliveoil)

test_that("mvr tidier arguments", {
  check_arguments(tidy.mvr, strict = FALSE)
  check_arguments(augment.mvr, strict = FALSE)
  check_arguments(glance.mvr, strict = FALSE)
})

test_that("tidy.mvr", {
  tidy_yarn_pcr <- tidy(yarn_pcr)
  tidy_yarn_pls <- tidy(yarn_pls)
  tidy_yarn_cppls <- tidy(yarn_cppls)
  tidy_sens_pcr <- tidy(sens_pcr)
  tidy_sens_pls <- tidy(sens_pls)

  check_tidy_output(tidy_yarn_pcr)
  check_tidy_output(tidy_yarn_pls)
  check_tidy_output(tidy_yarn_cppls)
  check_tidy_output(tidy_sens_pcr)
  check_tidy_output(tidy_sens_pls)
})

test_that("augment.mvr", {
  check_augment_function(
    aug = augment.mvr,
    model = yarn_pls,
    data = yarn,
    newdata = yarn,
    strict = FALSE
  )

  au <- augment(yarn_pls)
  expect_true(all(c(".resid", ".fitted", ".t.squared", ".scores") 
                  %in% names(au)))
})

test_that("glance.mvr", {
  gl <- glance(yarn_pls)
  gl2 <- glance(sens_pls)

  check_glance_outputs(gl, strict = FALSE)
  check_glance_outputs(gl2, strict = FALSE)
})
