context("orcutt")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("orcutt")

fit <- lm(mpg ~ wt + qsec + disp, mtcars)
co <- orcutt::cochrane.orcutt(fit)

test_that("orcutt tidier arguments", {
  check_arguments(tidy.orcutt)
  check_arguments(glance.orcutt)
})

test_that("tidy.orcutt", {
  td <- tidy(co)
  check_tidy_output(td)
  check_dims(td, 4, 5)
})

test_that("glance.orcutt", {
  gl <- glance(co)
  check_glance_outputs(gl)
  check_dims(gl, 1, 9)
})

test_that("no effect from additional parameters", { # from issue 734

  expect_equal(
    tidy(co, conf.int = TRUE, exponentiate = FALSE),
    tidy(co)
  )

  expect_equal(
    tidy(co, exponentiate = TRUE),
    tidy(co)
  )

  expect_equal(
    tidy(co, conf.int = TRUE, exponentiate = TRUE),
    tidy(co)
  )
})
