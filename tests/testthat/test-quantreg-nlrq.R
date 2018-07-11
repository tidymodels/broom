context("quantreg-nlrq")

skip_if_not_installed("quantreg")
library(quantreg)

set.seed(27)

df <- tibble::tibble(
  x = rep(1:25, 20),
  y = SSlogis(x, 10, 12, 2) * rnorm(500, 1, 0.1)
)

fit <- nlrq(
  y ~ SSlogis(x, Asym, mid, scal),
  data = df, 
  tau = 0.5, 
  trace = FALSE
)

test_that("quantreg::nlrq tidier arguments", {
  check_arguments(tidy.nlrq)
  check_arguments(glance.nlrq)
  check_arguments(augment.nlrq)
})

test_that("tidy.nlrq", {
  
  td <- tidy(fit)
  td_iid <- tidy(fit, se.type = "iid")
  tdci <- tidy(fit, conf.int = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(td_iid)
  check_tidy_output(tdci)
})

test_that("glance.nlrq", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.nlrq", {
  
  au <- augment(fit)
  check_tibble(au, method = "augment")
  
  check_augment_function(
    aug = augment.nlrq,
    model = fit,
    data = df,
    newdata = df
  )
})
