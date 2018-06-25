context("survival-survreg")

skip_if_not_installed("survival")

test_that("survreg tidiers work", {
  sr <- survreg(Surv(futime, fustat) ~ ecog.ps + rx, ovarian,
                dist = "exponential"
  )
  
  td <- tidy(sr)
  check_tidy(td, exp.row = 3, exp.col = 7)
  expect_equal(td$term, c("(Intercept)", "ecog.ps", "rx"))
  
  gl <- glance(sr)
  check_tidy(gl, exp.col = 9)
  
  skip("known error, temporarily ignore")
  
  ag <- augment(sr)
  check_tidy(ag, exp.col = 6)
})
