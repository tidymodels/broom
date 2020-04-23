context("mediate")


skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("mediation")
library(mediation)

data(jobs)
b <- lm(job_seek ~ treat + econ_hard + sex + age, data = jobs)
c <- lm(depress2 ~ treat + job_seek + econ_hard + sex + age, data = jobs)
mod <- mediate(b, c, sims = 50, treat = "treat", mediator = "job_seek")

test_that("mediation tidier arguments", {
  check_arguments(tidy.mediate)
})

test_that("tidy.mediation", {
  
  td1 <- tidy(mod, conf.int = TRUE, conf.level = 0.99)
  td2 <- tidy(mod, conf.int = TRUE)
  
  check_tidy_output(td1)
  check_tidy_output(td2)
  
  check_dims(td1, 4, 6)
})

