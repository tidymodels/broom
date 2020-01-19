skip_if_not_installed("gee")
library(gee)

skip_if_not_installed("MASS")
library(MASS)

data(OME)

capture.output( # hack to prevent C level printing that can't be turned off
  mod <- gee(
    cbind(Correct, Trials - Correct) ~ Loud + Age + OME,
    id = ID,
    data = OME,
    family = binomial,
    corstr = "exchangeable",
    silent = TRUE
  )
)

test_that("tidy.glm() isn't invoked", {
  expect_error(
    tidy(mod),
    "No tidy method for objects of class gee"
  )
})

test_that("glance.glm() isn't invoked", {
  expect_error(
    glance(mod),
    "No glance method for objects of class gee"
  )
})

test_that("augment.glm() isn't invoked", {
  expect_error(
    augment(mod),
    "No augment method for objects of class gee"
  )
})

rm(mod)
