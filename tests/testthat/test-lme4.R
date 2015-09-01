# test tidy, augment, glance methods from lme4-tidiers.R

if (require(lme4, quietly = TRUE)) {
    context("lme4 models")
    
    d <- as.data.frame(ChickWeight)
    colnames(d) <- c("y", "x", "subj", "tx")
    fit <- lmer(y ~ tx*x + (x | subj), data=d)
    
    test_that("tidy works on lme4 fits", {
        td <- tidy(fit)
    })

    test_that("scales works", {
        t1 <- tidy(fit,effects="ran_pars")
        t2 <- tidy(fit,effects="ran_pars",scales="sdcor")
        expect_equal(t1$estimate,t2$estimate)
        expect_error(tidy(fit,effects="ran_pars",scales="varcov"),
                     "unrecognized ran_pars scale")
        t3  <- tidy(fit,effects="ran_pars",scales="vcov")
        expect_equal(t3$estimate[c(1,2,4)],
                     t2$estimate[c(1,2,4)]^2)
        expect_error(tidy(fit,scales="vcov"),
                     "must be provided for each effect")
              })
    test_that("tidy works with more than one RE grouping variable", {
       dd <- expand.grid(f=factor(1:10),g=factor(1:5),rep=1:3)
       dd$y <- suppressMessages(simulate(~(1|f)+(1|g),newdata=dd,
                        newparams=list(beta=1,theta=c(1,1)),
                        family=poisson, seed=101))[[1]]
       gfit <- glmer(y~(1|f)+(1|g),data=dd,family=poisson)
       expect_equal(as.character(tidy(gfit,effects="ran_pars")$term),
                                 paste("sd_(Intercept)",c("f","g"),sep="."))
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
