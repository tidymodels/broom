# test tidy, augment, glance methods from lme4-tidiers.R

if (require(lme4, quietly = TRUE)) {
    context("lme4 models")
    
    d <- as.data.frame(ChickWeight)
    colnames(d) <- c("y", "x", "subj", "tx")
    fit <- lmer(y ~ tx*x + (x | subj), data=d)
    
    test_that("tidy works on lme4 fits", {
        td <- tidy(fit)
    })
    
    test_that("augment works on lme4 fits with or without data", {
        au <- augment(fit)
        au <- augment(fit, d)
    })

    dNAs <- d
    dNAs$y[c(1, 3, 5)] <- NA
    
    test_that("augment works on lme4 fits with NAs", {
        fitNAs <- lmer(y ~ tx*x + (x | subj), data = dNAs)
        au <- augment(fitNAs)
        expect_equal(nrow(au), sum(complete.cases(dNAs)))
    })
    
    test_that("augment works on lme4 fits with na.exclude", {
        fitNAs <- lmer(y ~ tx*x + (x | subj), data = dNAs, na.action = "na.exclude")
        
        #expect_error(suppressWarnings(augment(fitNAs)))
        au <- augment(fitNAs, dNAs)
        
        # with na.exclude, should have NAs in the output where there were NAs in input
        expect_equal(nrow(au), nrow(dNAs))
        expect_equal(complete.cases(au), complete.cases(dNAs))
    })

    test_that("glance works on lme4 fits", {
        g <- glance(fit)
    })
}
