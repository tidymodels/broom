context("survival-aareg")

skip_if_not_installed("survival")
library(survival)

test_that("aareg tidiers work regardless of dfbeta", {
  afit1 <- aareg(Surv(time, status) ~ age + sex + ph.ecog,
                 data = lung,
                 dfbeta = FALSE
  )
  td <- tidy(afit1)
  check_tidy(td, exp.row = 4, exp.col = 6)
  expect_equal(td$term, c("Intercept", "age", "sex", "ph.ecog"))
  
  afit2 <- aareg(Surv(time, status) ~ age + sex + ph.ecog,
                 data = lung,
                 dfbeta = TRUE
  )
  td <- tidy(afit2)
  check_tidy(td, exp.row = 4, exp.col = 7)
  expect_equal(td$term, c("Intercept", "age", "sex", "ph.ecog"))
  
  gl <- glance(afit1)
  check_tidy(gl, exp.col = 3)
  
  gl <- glance(afit1)
  check_tidy(gl, exp.col = 3)
})
