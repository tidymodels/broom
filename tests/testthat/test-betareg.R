context("betareg")

skip_if_not_installed("betareg")

library(betareg)
data("GasolineYield")

fit1 <- betareg(yield ~ batch + temp, data = GasolineYield)
fit2 <- betareg(yield ~ batch + temp | temp, data = GasolineYield)

test_that("betareg tidier arguments", {
  check_arguments(tidy.betareg)
  check_arguments(glance.betareg)
  check_arguments(augment.betareg)
})

test_that("tidy.betareg", {
  
  td1 <- tidy(fit1, conf.int = TRUE, conf.level = .99)
  td2 <- tidy(fit2, conf.int = TRUE)
  
  check_tidy_output(td1)
  check_tidy_output(td2)
  
  check_dims(td1, 12, 8)
})

test_that("glance.betareg", {
  
  gl1 <- glance(fit1)
  gl2 <- glance(fit2)
  
  check_glance_outputs(gl1, gl2)
})

test_that("augment.betareg", {
  check_augment_function(
    augment.betareg,
    fit1,
    data = GasolineYield,
    newdata = GasolineYield
  )
  
  check_augment_function(
    augment.betareg,
    fit2,
    data = GasolineYield,
    newdata = GasolineYield
  )
})
