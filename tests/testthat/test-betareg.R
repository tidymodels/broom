context("betareg")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("betareg")

library(betareg)
data("GasolineYield")

fit1 <- betareg(yield ~ batch + temp, data = GasolineYield)
fit2 <- betareg(yield ~ batch + temp | temp, data = GasolineYield)

test_that("betareg tidier arguments", {
  check_arguments(tidy.betareg)
  check_arguments(glance.betareg)
  check_arguments(augment.betareg, strict = FALSE)
})

test_that("tidy.betareg", {
  td1 <- tidy(fit1, conf.int = TRUE, conf.level = .99)
  td2 <- tidy(fit2, conf.int = TRUE)

  check_tidy_output(td1)
  check_tidy_output(td2)
  
  expect_equal(
    unname(confint(fit2)),
    unname(as.matrix(td2[c("conf.low", "conf.high")]))
  )

  check_dims(td1, 12, 8)
  
  #test passing ellipsis to summary
  data_test <- structure(
    list(p = c(0.4238, 0.8248, 0.5927, 0.3208, 0.8317, 
               0.7314, 0.4624, 0.5224, 0.3528, 0.7739, 0.1264, 0.4516, 0.4306, 
               0.5243, 0.5117, 0.149, 0.3342, 0.5069, 0.7101, 0.8019, 0.7569, 
               0.9096, 0.9013, 0.5403, 0.2264, 0.5775, 0.7366, 0.4086, 0.575, 
               0.6623, 0.7758, 0.1517, 0.7587, 0.3247, 0.7463, 0.6325), 
         w = structure(c(1L, 2L, 9L, 4L, 3L, 5L, 1L, 9L, 4L, 3L, 5L, 2L, 4L, 5L, 1L, 2L, 9L, 
                         4L, 3L, 5L, 8L, 7L, 6L, 1L, 2L, 9L, 3L, 5L, 8L, 7L, 1L, 2L, 9L, 
                         4L, 3L, 5L), 
                       levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9"), 
                       class = "factor")), 
    row.names = c(NA, -36L), class = c("tbl_df", "tbl", "data.frame")
  )
  m <- betareg::betareg(p ~ w, data = data_test)
  expect_warning(tidy(m))
  expect_silent(tidy(m, type = "sweighted"))
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
