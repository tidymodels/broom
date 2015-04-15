# test tidy, augment, glance methods from nlme-tidiers.R

if (require(nlme, quietly = TRUE)) {
    context("nlme models")
    
    d <- as.data.frame(ChickWeight)
    colnames(d) <- c("y", "x", "subj", "tx")
    fit <- lme(y ~ tx*x, random = ~x|subj, data=d)
    
    test_that("tidy works on nlme/lme fits", {
        td <- tidy(fit)
    })

    test_that("augment works on lme4 fits with or without data", {
        au <- augment(fit)
        au <- augment(fit, d)
    })
    dNAs <- d
    dNAs$y[c(1, 3, 5)] <- NA
    
    test_that("augment works on lme fits with NAs and na.omit", {
        fitNAs <- lme(y ~ tx*x, random = ~x | subj, data = dNAs, 
                      na.action = "na.omit")
        au <- augment(fitNAs)
        expect_equal(nrow(au), sum(complete.cases(dNAs)))
    })
    
        
        test_that("augment works on lme fits with na.omit", {
        fitNAs <- lme(y ~ tx*x, random = ~x | subj, data = dNAs, 
                      na.action = "na.exclude")
        
        au <- augment(fitNAs, dNAs)
        
        # with na.exclude, should have NAs in the output where there were NAs in input
        expect_equal(nrow(au), nrow(dNAs))
        expect_equal(complete.cases(au), complete.cases(dNAs))
    })

    test_that("glance works on nlme fits", {
        g <- glance(fit)
    })

}
