context("survival-pyears")

skip_if_not_installed("survival")

test_that("pyears tidiers work", {
  temp.yr <- tcut(mgus$dxyr, 55:92, labels = as.character(55:91))
  temp.age <- tcut(mgus$age, 34:101, labels = as.character(34:100))
  ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
  pstat <- ifelse(is.na(mgus$pctime), 0, 1)
  pfit <- pyears(Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus,
                 data.frame = TRUE
  )
  td <- tidy(pfit)
  check_tidy(td, exp.col = 6)
  
  gl <- glance(pfit)
  check_tidy(gl, exp.col = 2)
  
  pfit2 <- pyears(Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus,
                  data.frame = FALSE
  )
  td2 <- tidy(pfit2)
  expect_is(td2, "data.frame")
  
  gl2 <- glance(pfit2)
  check_tidy(gl2, exp.col = 2)
})
