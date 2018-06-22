context("lmodel2")

skip_if_not_installed("lmodel2")
library(lmodel2)

data("mod2ex2")
fit <- lmodel2(Prey ~ Predators, data = mod2ex2, "relative", "relative", 99)

test_that("lmodel2 tidier arguments", {
  check_arguments(tidy.lmodel2)
  check_arguments(glance.lmodel2)
})

test_that("tidy.lmodel2", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 8, 5)
})

test_that("glance.lmodel2", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})
