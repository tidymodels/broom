skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("speedglm")
suppressPackageStartupMessages(library(speedglm))

clotting <- data.frame(
  u = c(5, 10, 15, 20, 30, 40, 60, 80, 100),
  lot1 = c(118, 58, 42, 35, 27, 25, 21, 19, 18)
)

fit <- speedglm(lot1 ~ log(u), data = clotting, family = Gamma(log))

test_that("speedglm tidiers arguments", {
  check_arguments(tidy.speedglm)
  check_arguments(glance.speedglm)
})

test_that("tidy.speedglm", {
  td <- tidy(fit, conf.int = TRUE, exponentiate = TRUE)
  check_tidy_output(td)

  # watch out for the bizarro factor p-values reported in #660
  expect_type(td$p.value, "double")

  check_dims(td, 2, 7)
})

test_that("glance.speedglm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.speedglm errors", {
  # speedglm sub-classes speedlm, and there's an augment.speedlm()
  # method we want to make sure isn't accidentally invoked
  expect_snapshot(error = TRUE, augment(fit))
})
