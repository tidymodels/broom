context("survival-coxph")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("survival")
library(survival)

fit <- coxph(Surv(time, status) ~ age + sex, lung)
fit2 <- coxph(Surv(time, status) ~ age + sex, lung, robust = TRUE)
fit3 <- coxph(Surv(time, status) ~ age + sex + frailty(inst), lung)

bladder1 <- bladder[bladder$enum < 5, ] 
fit4 <- coxph(Surv(stop, event) ~ (rx + size + number) * strata(enum) + 
                cluster(id), bladder1)

# this model does not have summary(x)$used.robust
fit5 <- coxph(Surv(time, status) ~ age + pspline(nodes), data = colon)

test_that("coxph tidier arguments", {
  check_arguments(tidy.coxph)
  check_arguments(glance.coxph)
  check_arguments(augment.coxph)
})

test_that("tidy.coxph", {
  td <- tidy(fit)
  td2 <- tidy(fit, exponentiate = TRUE)
  td3 <- tidy(fit2)
  td4 <- tidy(fit3)
  td5 <- tidy(fit3, exponentiate = TRUE)
  td6 <- tidy(fit3, conf.int = TRUE)
  td7 <- tidy(fit4)
  td8 <- tidy(fit4, exponentiate = TRUE)
  td9 <- tidy(fit4, conf.int = TRUE)
  td10 <- tidy(fit5)
  td11 <- tidy(fit5, conf.int = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td4)
  check_tidy_output(td5)
  check_tidy_output(td6)
  check_tidy_output(td7)
  check_tidy_output(td8)
  check_tidy_output(td9)
  check_tidy_output(td10)
  check_tidy_output(td11)
})

test_that("glance.coxph", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  gl3 <- glance(fit3)
  gl4 <- glance(fit4)

  check_glance_outputs(gl, gl2, gl3, gl4, strict = FALSE)
})

test_that("augment.coxph", {
  expect_error(
    augment(fit),
    regexp = "Must specify either `data` or `newdata` argument."
  )

  check_augment_function(
    aug = augment.coxph,
    model = fit,
    data = lung,
    newdata = lung
  )

  check_augment_function(
    aug = augment.coxph,
    model = fit2,
    data = lung,
    newdata = lung
  )
})
