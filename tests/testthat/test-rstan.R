if (suppressPackageStartupMessages(require(rstan, quietly = TRUE))) {
  context("nlme models")

  infile <- system.file("extdata", "rstan_example.rda", package = "broom")
  load(infile)

  test_that("Correct columns are returned on default and with conf.int call", {
           
    t_default <- tidy(rstan_example)
    expect_match(t_default$term, "eta\\[\\d\\]|mu|tau")
    expect_equal(names(t_default), c("term", "estimate", "std.error"))

    t_cf = tidy(rstan_example, conf.int = TRUE, pars = "theta")
    
    expect_match(t_cf$term, "theta\\[\\d\\]")
    expect_equal(names(t_cf), c("term", "estimate", "std.error", "conf.low", "conf.high"))
    
  })        

  test_that("Index columns are extracted when requested", {
      
      estimate.method = "mean"
      conf.int = FALSE
      conf.level = 0.95
      conf.method = "quantile"
      droppars = "lp__"
      rhat = FALSE
      ess = FALSE
      index = TRUE
      pars = c("eta", "theta")

      t_index <- tidy(rstan_example, index = TRUE)
      expect_match(t_index$term, "(eta|mu|tau)")
      expect_equal(names(t_index), c("term", "term0", "index", "estimate", "std.error"))
  })        
}
