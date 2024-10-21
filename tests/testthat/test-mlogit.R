skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("mlogit")
skip_if_not_installed("AER")
suppressPackageStartupMessages(library(mlogit))
suppressPackageStartupMessages(library(AER))
library(dplyr)

data("Fishing", package = "mlogit")
Fish <- dfidx(Fishing, varying = 2:9, shape = "wide", choice = "mode")
fit1 <- mlogit(mode ~ price + catch, data = Fish)

data("TravelMode", package = "AER")
fit2 <- mlogit(choice ~ wait + travel + vcost, TravelMode, heterosc = TRUE)

test_that("mlogit tidier arguments", {
  check_arguments(tidy.mlogit)
  check_arguments(glance.mlogit)
  check_arguments(augment.mlogit, strict = FALSE)
})

test_that("tidy.mlogit", {
  td1 <- tidy(fit1)
  td2 <- tidy(fit1, conf.int = TRUE)
  td3 <- tidy(fit2)
  td4 <- tidy(fit2, conf.int = TRUE)
  
  check_tidy_output(td1)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td4)
})

test_that("glance.mlogit", {
  gl1 <- glance(fit1)
  gl2 <- glance(fit2)
  
  check_glance_outputs(gl1)
  check_glance_outputs(gl2)
})

test_that("augment.mlogit", {
  check_augment_function(
    aug = augment.mlogit,
    model = fit1,
    data = Fish,
    newdata = Fish,
    strict = FALSE
  )
  
  au1 <- augment(fit1)
  au2 <- augment(fit2)
  
  expect_true(all(c("id", "alternative", "chosen", ".resid", ".fitted") %in% names(au1)))
  expect_true(all(c("id", "alternative", "chosen", ".resid", ".fitted") %in% names(au2)))
})
