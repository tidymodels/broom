context("survival-pyears")

skip_if_not_installed("survival")
library(survival)

temp.yr <- tcut(mgus$dxyr, 55:92, labels = as.character(55:91))
temp.age <- tcut(mgus$age, 34:101, labels = as.character(34:100))
ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
pstat <- ifelse(is.na(mgus$pctime), 0, 1)

fit <- pyears(
  Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus,
  data.frame = TRUE
)

fit2 <- pyears(
  Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus,
  data.frame = FALSE
)

test_that("pyears tidier arguments", {
  check_arguments(tidy.pyears)
  check_arguments(glance.pyears)
})

test_that("tidy.pyears", {
  td <- tidy(fit)
  td2 <- tidy(fit2)
  
  check_tidy_output(td)
  check_tidy_output(td2)
})

test_that("glance.pyears", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  
  check_glance_outputs(gl, gl2)
})
