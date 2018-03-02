context("geeglm")

library(geepack)
data(state)
ds <- data.frame(state.region, state.x77)
geefit <- geeglm(Income ~ Frost + Murder, id = state.region,
                 data = ds, family = gaussian,
                 corstr = 'exchangeable')

test_that("tidy.geeglm works with conf.int", {
    td <- tidy(geefit, conf.int = TRUE)
    check_tidy(td, exp.row = 3, exp.col = 7)
})

test_that("tidy.geeglm throws warning when exponentiating non log/logit link", {
    expect_warning(td <- tidy(geefit, conf.int = FALSE, exponentiate = TRUE))
    check_tidy(td, exp.row = 3, exp.col = 5)
})

test_that("tidy.geeglm quick works", {
    td <- tidy(geefit, quick = TRUE)
    check_tidy(td, exp.row = 3, exp.col = 2)
})
