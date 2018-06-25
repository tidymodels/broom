context("geepack")

skip_if_not_installed("geepack")
library(geepack)

df <- data.frame(state.region, state.x77)

fit <- geeglm(
  Income ~ Frost + Murder,
  id = state.region,
  data = df,
  family = gaussian,
  corstr = "exchangeable"
)

test_that("tidy.geeglm", {
  check_arguments(tidy.geeglm)
  
  td <- tidy(fit, conf.int = TRUE)
  tdq <- tidy(fit, quick = TRUE)
  
  expect_warning(
    td2 <- tidy(fit, conf.int = FALSE, exponentiate = TRUE),
    regexp = paste(
      "Exponentiating coefficients, but model did not use a log",
      "or logit link function"
    )
  )
  
  check_tidy_output(td)
  check_tidy_output(tdq)
  check_tidy_output(td2)
})
