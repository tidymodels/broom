context("mcmc tidiers")

infile <- system.file("extdata", "rstan_example.rda", package = "broom")
load(infile)

test_that("tidy.stanfit works", {
  td <- tidy(rstan_example, conf.int = TRUE, rhat = TRUE, ess = TRUE)
  check_tidy(td, exp.row = 18, exp.col = 7)
})
