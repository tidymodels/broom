context("survival-survexp")

skip_if_not_installed("survival")
library(survival)

test_that("survexp tidiers work", {
  sexpfit <- suppressWarnings(
    survexp(futime ~ 1,
            rmap = list(
              sex = "male", year = accept.dt,
              age = accept.dt - birth.dt
            ),
            method = "conditional", data = jasa
    )
  )
  td <- tidy(sexpfit)
  check_tidy(td, exp.col = 3)
  
  gl <- glance(sexpfit)
  check_tidy(gl, exp.col = 3)
})
