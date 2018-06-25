context("survival-survfit")

skip_if_not_installed("survival")
library(survival)

test_that("survfit tidiers work", {
  cfit <- coxph(Surv(time, status) ~ age + strata(sex), lung)
  sfit <- survfit(cfit)
  td <- tidy(sfit)
  check_tidy(td, exp.col = 9)
  
  fitCI <- survfit(Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
                   data = mgus1, subset = (start == 0)
  )
  td_multi <- tidy(fitCI)
  check_tidy(td_multi, exp.col = 9)
  
  expect_error(glance(sfit))
  expect_error(glance(fitCI))
  
  sfit <- survfit(coxph(Surv(time, status) ~ age + sex, lung))
  gl <- glance(sfit)
  check_tidy(gl, exp.col = 9)
})
