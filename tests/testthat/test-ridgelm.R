context("ridgelm tidiers")

test_that("ridgelm tidiers work for one or multple lambdas", {
    names(longley)[1] <- "y"
    fit1 <- MASS::lm.ridge(y ~ ., longley)
    td <- tidy(fit1)
    check_tidy(td, exp.row = 6, exp.col = 5)

    gl <- glance(fit1)
    check_tidy(gl, exp.col = 3)

    fit2 <- MASS::lm.ridge(y ~ ., longley, lambda = seq(0.001, .05, .001))
    td2 <- tidy(fit2)
    check_tidy(td2, exp.row = 300, exp.col = 5)
})
