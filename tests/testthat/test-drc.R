context("drc")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("drc")
library(drc)

mod <- drm(dead/total~conc, type,
  weights = total, data = selenium, fct = LL.2(), type = "binomial")

test_that("drc tidier arguments", {
  check_arguments(tidy.drc)
  check_arguments(glance.drc)
  check_arguments(augment.drc, strict = FALSE)
})

test_that("tidy.drc", {

  td1 <- tidy(mod)
  td2 <- tidy(mod, quick = TRUE)
  td3 <- tidy(mod, robust = TRUE)

  check_tidy_output(td1, strict = FALSE)
  check_tidy_output(td2, strict = FALSE)
  check_tidy_output(td3, strict = FALSE)
})

test_that("glance.drc", {

  gl1 <- glance(mod)

  check_glance_outputs(gl1, strict = FALSE)
})

# test_that("augment.drc", {

#   check_augment_function(
#     augment.drc,
#     mod,
#     data = selenium,
#     newdata = selenium)
# })