context("bingroup")

skip_if_not_installed("binGroup")
library(binGroup)

bw <- binWidth(100, .1)
bd <- binDesign(nmax = 300, delta = 0.06, p.hyp = 0.1, power = .8)

test_that("binGroup tidier arguments", {
  check_arguments(tidy.binWidth)
  check_arguments(tidy.binDesign)
  check_arguments(glance.binDesign)
})

test_that("tidy.binWidth", {
  td <- tidy(bw)
  check_tidy_output(td)
  check_dims(td, 1, 4)
})

test_that("tidy.binDesign", {
  td <- tidy(bd)
  check_tidy_output(td)
  check_dims(td, expected_cols = 2)
})

test_that("glance.binDesign", {
  gl <- glance(bd)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 4)
})
