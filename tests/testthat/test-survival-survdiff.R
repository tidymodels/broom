context("survival-survdiff")

skip_if_not_installed("survival")
library(survival)

fit <- survdiff(Surv(futime, fustat) ~ rx, data = ovarian)
fit2 <- survdiff(Surv(time, status) ~ pat.karno + strata(inst), data = lung)
fit3 <- survdiff(
  Surv(time, status) ~ pat.karno + ph.ecog + strata(inst) + strata(sex),
  data = lung
)

expect <- survexp(
  futime ~ ratetable(
    age = (accept.dt - birth.dt),
    sex = 1,
    year = accept.dt,
    race = "white"
  ),
  jasa,
  cohort = FALSE, ratetable = survexp.usr
)

fit4 <- survdiff(Surv(jasa$futime, jasa$fustat) ~ offset(expect))
fit5 <- survdiff(Surv(futime, fustat) ~ rx + ecog.ps, data = ovarian)
rm(expect)

test_that("survdiff tidier arguments", {
  check_arguments(tidy.survdiff)
  check_arguments(glance.survdiff)
})

test_that("tidy.survdiff", {
  td <- tidy(fit)
  td2 <- tidy(fit2)
  td3 <- tidy(fit3)
  td4 <- tidy(fit4)
  td5 <- tidy(fit5)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td4)
  check_tidy_output(td5)
})

test_that("glance.survdiff", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  gl3 <- glance(fit3)
  gl4 <- glance(fit4)
  gl5 <- glance(fit5)
  
  check_glance_outputs(gl, gl2, gl3, gl4, gl5)
})

