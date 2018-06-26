context("survival-survexp")

skip_if_not_installed("survival")
library(survival)

fit <- suppressWarnings(
  survexp(
    futime ~ 1,
    rmap = list(
      sex = "male", year = accept.dt,
      age = accept.dt - birth.dt
    ),
    method = "conditional", data = jasa
  )
)

test_that("survfit tidier arguments", {
  check_arguments(tidy.survexp)
  check_arguments(glance.survexp)
})

test_that("tidy.survexp", {
  td <- tidy(fit)
  check_tidy_output(td)
})

test_that("glance.survexp", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

