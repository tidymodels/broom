context("survival-cch")

skip_if_not_installed("survival")
library(survival)

subcoh <- nwtco$in.subcohort
selccoh <- with(nwtco, rel == 1 | subcoh == 1)
ccoh.data <- nwtco[selccoh, ]
ccoh.data$subcohort <- subcoh[selccoh]
ccoh.data$histol <- factor(ccoh.data$histol, labels = c("FH", "UH"))
ccoh.data$stage <-
  factor(ccoh.data$stage, labels = c("I", "II", "III", "IV"))
ccoh.data$age <- ccoh.data$age / 12

fit <- cch(
  Surv(edrel, rel) ~ stage + histol + age,
  data = ccoh.data,
  subcoh = ~ subcohort, id = ~ seqno, cohort.size = 4028
)

test_that("cch tidier arguments", {
  check_arguments(tidy.cch)
  check_arguments(glance.cch)
})

test_that("tidy.cch", {
  td <- tidy(fit)
  check_tidy_output(td)
})

test_that("glance.cch", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})
