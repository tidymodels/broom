context("gam")

skip_if_not_installed("gam")

data(kyphosis, package = "gam")
fit <- gam::gam(
  Kyphosis ~ gam::s(Age, 4) + Number,
  family = binomial,
  data = kyphosis
)

test_that("gam::gam tidier arguments", {
  check_arguments(tidy.Gam)
  check_arguments(glance.Gam)
})

test_that("tidy.Gam", {
  td <- tidy(fit)
  check_tidy_output(td)
  check_dims(td, 3, 6)
})

test_that("glance.Gam", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

