skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("survival")
suppressPackageStartupMessages(library(survival))

fit <- survdiff(Surv(futime, fustat) ~ rx, data = ovarian)
fit2 <- survdiff(Surv(time, status) ~ pat.karno + strata(inst), data = lung)
fit3 <- survdiff(
  Surv(time, status) ~ pat.karno + ph.ecog + strata(inst) + strata(sex),
  data = lung
)

expect <- survexp(
  futime ~ 1,
  rmap = list(
    age = (accept.dt - birth.dt),
    sex = 1,
    year = accept.dt,
    race = "white"
  ),
  jasa,
  cohort = FALSE,
  ratetable = survexp.usr
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

  # The output from tidy.survdiff uses variable names as column names because
  # the output contains a row for each level of the (statistical) factor.  This
  # output meets the criteria for 'tidy' data.  Therefore, strict may be
  # set to FALSE to allow these tests to pass.
  check_tidy_output(td, strict = FALSE)
  check_tidy_output(td2, strict = FALSE)
  check_tidy_output(td3, strict = FALSE)
  check_tidy_output(td4)
  check_tidy_output(td5, strict = FALSE)
})

test_that("glance.survdiff", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  gl3 <- glance(fit3)
  gl4 <- glance(fit4)
  gl5 <- glance(fit5)

  check_glance_outputs(gl, gl2, gl3, gl4, gl5)
})
