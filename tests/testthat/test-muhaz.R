context("muhaz")

skip_if_not_installed("muhaz")
skip_if_not_installed("survival")  # does this skip with base R?

library(muhaz)
data(ovarian, package = "survival")

fit <- muhaz(ovarian$futime, ovarian$fustat)

test_that("muhaz tidier arguments", {
  check_arguments(tidy.muhaz)
  check_arguments(glance.muhaz)
})

test_that("tidy.muhaz", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, expected_cols = 2)
})

test_that("glance.muhaz", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 5)
})

