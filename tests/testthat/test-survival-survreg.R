context("survival-survreg")

skip_if_not_installed("survival")
library(survival)

sr <- survreg(Surv(futime, fustat) ~ ecog.ps + rx, ovarian,
              dist = "exponential"
)

test_that("survreg tidier arguments", {
  check_arguments(tidy.survreg)
  check_arguments(glance.survreg)
  check_arguments(augment.survreg)
})


test_that("tidy.survreg", {
  td <- tidy(sr)
  check_tidy_output(td)
  check_dims(td, 3, 7)
  expect_equal(td$term, c("(Intercept)", "ecog.ps", "rx"))
})

test_that("glance.survreg", {
  gl <- glance(sr)
  check_glance_outputs(gl)
})

test_that("augment.survreg", {
  
  expect_error(
    augment(sr),
    regexp = "Must specify either `data` or `newdata` argument."
  )
  
  check_augment_function(
    aug = augment.survreg,
    model = sr,
    data = ovarian,
    newdata = ovarian
  )
})
