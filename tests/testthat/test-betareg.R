context("betareg tidiers")

skip_if_not_installed("betareg")

library(betareg)
data("GasolineYield")

fit1 <- betareg(yield ~ batch + temp, data = GasolineYield)
fit2 <- betareg(yield ~ batch + temp | temp, data = GasolineYield)

test_that("tidy.betareg", {
  check_tidy_arguments(tidy.betareg)
  
  td1 <- tidy(fit1, conf.int = TRUE, conf.level = .99)
  
  check_tidy_output(td1)
  check_dims(td1, 12, 8)
  
  td2 <- tidy(fit2, conf.int = TRUE)
  
  check_tidy_output(td2)
})

test_that("glance.betareg", {
  check_glance_arguments(glance.betareg)
  
  gl1 <- glance(fit1)
  
  check_glance_output(gl1)
  check_dims(gl1, expected_cols = 6)
  
  gl2 <- glance(fit2)  # another bug
  
  check_glance_output(gl2)
  
  check_glance_multiple_outputs(gl1, gl2)
})

test_that("augment.betareg", {
  check_augment_arguments(augment.betareg)
  
  check_augment_function(
    augment.betareg,
    fit1,
    data = GasolineYield,
    newdata = GasolineYield
  )
})
