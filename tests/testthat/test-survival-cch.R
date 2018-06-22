context("survival-cch")

skip_if_not_installed("survival")

test_that("cch tidiers work", {
  subcoh <- nwtco$in.subcohort
  selccoh <- with(nwtco, rel == 1 | subcoh == 1)
  ccoh.data <- nwtco[selccoh, ]
  ccoh.data$subcohort <- subcoh[selccoh]
  ccoh.data$histol <- factor(ccoh.data$histol, labels = c("FH", "UH"))
  ccoh.data$stage <-
    factor(ccoh.data$stage, labels = c("I", "II", "III", "IV"))
  ccoh.data$age <- ccoh.data$age / 12
  fit.ccP <- cch(Surv(edrel, rel) ~ stage + histol + age,
                 data = ccoh.data,
                 subcoh = ~ subcohort, id = ~ seqno, cohort.size = 4028
  )
  td <- tidy(fit.ccP)
  check_tidy(td, exp.row = 5, exp.col = 7)
  gl <- glance(fit.ccP)
  check_tidy(gl, exp.col = 6)
})
