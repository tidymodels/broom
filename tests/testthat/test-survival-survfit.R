context("survival-survfit")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("survival")
library(survival)

cfit <- coxph(Surv(time, status) ~ age + strata(sex), lung)
sfit <- survfit(cfit)

cfit2 <- coxph(Surv(time, status) ~ age, lung)
sfit2 <- survfit(cfit2)

fit2 <- survfit(
  Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
  data = mgus1,
  subset = (start == 0)
)

##### test cases for #305

no_ci_single_state <- survfit(
  Surv(time, status) ~ strata(x),
  data = aml,
  conf.type = "none"
)

no_ci_multi_state <- survfit(
  Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
  data = mgus1,
  subset = (start == 0),
  conf.type = "none"
)

test_that("survfit tidier arguments", {
  check_arguments(tidy.survfit)
  check_arguments(glance.survfit)
})

test_that("tidy.survfit", {
  td <- tidy(sfit)
  td2 <- tidy(fit2)
  
  nc_ss <- tidy(no_ci_single_state)
  nc_ms <- tidy(no_ci_multi_state)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  
  check_tidy_output(nc_ss)
  check_tidy_output(nc_ms)
})

test_that("glance.survfit", {
  
  expect_error(
    glance(sfit),
    regexp = "No glance method exists for multi-strata survfit objects."
  )
  
  expect_error(
    glance(fit2),
    regexp = "No glance method exists for multi-state survfit objects."
  )
  
  expect_error(
    glance(no_ci_multi_state),
    regexp = "No glance method exists for multi-state survfit objects."
  )
  
  gl <- glance(sfit2)
  check_glance_outputs(gl)
  
  gl2 <- glance(no_ci_single_state)
  check_glance_outputs(gl2)
})

