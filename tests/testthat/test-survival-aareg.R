context("survival-aareg")

skip_if_not_installed("survival")
library(survival)

afit1 <- aareg(
  Surv(time, status) ~ age + sex + ph.ecog,
  data = lung,
  dfbeta = FALSE
)

afit2 <- aareg(
  Surv(time, status) ~ age + sex + ph.ecog,
  data = lung,
  dfbeta = TRUE
)

test_that("aareg tidier arguments", {
  check_arguments(tidy.aareg)
  check_arguments(glance.aareg)
})

test_that("tidy.aareg", {
  
  td <- tidy(afit1)
  td2 <- tidy(afit2)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  
  check_dims(td, 4, 6)
  check_dims(td2, 4, 7)
  
  expect_equal(td$term, c("Intercept", "age", "sex", "ph.ecog"))
  expect_equal(td2$term, c("Intercept", "age", "sex", "ph.ecog"))
})

test_that("glance.aareg", {
  gl <- glance(afit1)
  gl2 <- glance(afit2)
  
  check_glance_outputs(gl, gl2)
})
