context("drc")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("drc")
library(drc)

mod <- drm(dead/total~conc, type,
  weights = total, data = selenium, fct = LL.2(), type = "binomial")

mod2 <- drm(rootl ~ conc, data = ryegrass, fct = W2.4())

test_that("drc tidier arguments", {
  check_arguments(tidy.drc)
  check_arguments(glance.drc)
  check_arguments(augment.drc, strict = FALSE) 
})

test_that("tidy.drc", {

  td1 <- tidy(mod)
  td3 <- tidy(mod, conf.int = TRUE)

  check_tidy_output(td1, strict = FALSE)
  check_tidy_output(td3, strict = FALSE)
  
  td1 <- tidy(mod2)
  td3 <- tidy(mod2, conf.int = TRUE)
  
  check_tidy_output(td1, strict = FALSE)
  check_tidy_output(td3, strict = FALSE)
})

test_that("glance.drc", {

  gl1 <- glance(mod)
  gl2 <- glance(mod2)

  check_glance_outputs(gl1, gl2)
})

test_that("augment.drc", {

  expect_error(
    augment(mod),
    regexp = "Must specify either `data` or `newdata` argument."
  )

  check_augment_function(
    augment.drc,
    mod,
    data = selenium,
    newdata = selenium
  )
  
  expect_error(
    augment(mod2),
    regexp = "Must specify either `data` or `newdata` argument."
  )

  check_augment_function(
    augment.drc,
    mod2,
    data = ryegrass,
    newdata = ryegrass
  )
})

test_that("confidence merge issue regression test (#798)", {
  
  td <- tidy(mod, conf.int = TRUE)
  
  expect_false(any(is.na(td$conf.low)))
  expect_false(any(is.na(td$conf.high)))
})
