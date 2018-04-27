context("ergm tidiers")

library(ergm)
data(florentine)
suppressMessages(gest <- ergm(flomarriage ~ edges + absdiff("wealth")))
suppressMessages(gest2 <- ergm(flomarriage ~ edges + absdiff("wealth"),
                               family = "gaussian"))

test_that("ergm tidiers work with additional parameters set to TRUE", {
    td <- tidy(gest, conf.int = TRUE, exponentiate = TRUE)
    check_tidy(td, exp.row = 2, exp.col = 7)
    
    gl <- glance(gest, deviance = TRUE, mcmc = TRUE)
    check_tidy(gl, exp.col = 12)
})

test_that("quick tidy works for ergm", {
    td <- tidy(gest, quick = TRUE)
    check_tidy(td, exp.row = 2, exp.col = 2)
})

test_that("exponentiating on non-log/logit link throws warning", {
    expect_warning(td2 <- tidy(gest2, conf.int = TRUE, exponentiate = TRUE))
    check_tidy(td2, exp.row = 2, exp.col = 7)
})

