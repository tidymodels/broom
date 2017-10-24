# test tidy and glance methods from rstanarm_tidiers.R

context("rstanarm tidiers")
suppressPackageStartupMessages(library(rstanarm))

if (require(rstanarm, quietly = TRUE)) {
    set.seed(2016)
    capture.output(
        fit <- stan_glmer(mpg ~ wt + (1|cyl) + (1+wt|gear), data = mtcars,
                               iter = 200, chains = 2)
    )
    
    context("rstanarm models")
    test_that("tidy works on rstanarm fits", {
        td1 <- tidy(fit)
        td2 <- tidy(fit, parameters = "varying")
        td3 <- tidy(fit, parameters = "hierarchical")
        td4 <- tidy(fit, parameters = "auxiliary")
        expect_equal(colnames(td1), c("term", "estimate", "std.error"))
    })
    
    test_that("tidy with multiple 'parameters' selections works on rstanarm fits", {
      td1 <- tidy(fit, parameters = c("varying", "auxiliary"))
      expect_true(all(c("sigma", "mean_PPD") %in% td1$term))
      expect_equal(colnames(td1), c("term", "estimate", "std.error", "level", "group"))
    })
    
    test_that("intervals works on rstanarm fits", {
        td1 <- tidy(fit, intervals = TRUE, prob = 0.8)
        td2 <- tidy(fit, parameters = "varying", intervals = TRUE, prob = 0.5)
        nms <- c("level", "group", "term", "estimate", "std.error", "lower", "upper")
        expect_equal(colnames(td2), nms)
    })
    
    test_that("glance works on rstanarm fits", {
        g1 <- glance(fit)
        g2 <- glance(fit, looic = TRUE, cores = 1)
        expect_equal(colnames(g1), c("algorithm", "pss", "nobs", "sigma"))
        expect_equal(colnames(g2), c(colnames(g1), "looic", "elpd_loo", "p_loo"))
    })
}
