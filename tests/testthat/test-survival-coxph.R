context("survival-coxph")

skip_if_not_installed("survival")
library(survival)

test_that("coxph tidiers work", {
  cfit <- coxph(Surv(time, status) ~ age + sex, lung)
  td <- tidy(cfit)
  check_tidy(td, exp.row = 2, exp.col = 7)
  td_exp <- tidy(cfit, exponentiate = TRUE)
  check_tidy(td_exp, exp.row = 2, exp.col = 7)
  
  cfit_rob <- coxph(Surv(time, status) ~ age + sex, lung, robust = TRUE)
  td_rob <- tidy(cfit_rob)
  check_tidy(td_rob, exp.row = 2, exp.col = 8)
  
  gl <- glance(cfit)
  check_tidy(gl, exp.col = 15)
  
  gl_rob <- glance(cfit_rob)
  check_tidy(gl_rob, exp.col = 17)
  
  skip("augment")
  
  ag <- augment(cfit)
  check_tidy(ag, exp.col = 6)
})
