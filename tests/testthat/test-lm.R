# test tidy, augment, glance from lm objects

context("lm tidiers")

test_that("tidy.lm works", {
    lmfit <- lm(mpg ~ wt, mtcars)
    td = tidy(lmfit)
    check_tidy(td, exp.row=2)
    expect_equal(td$term, c("(Intercept)", "wt"))
    
    lmfit2 <- lm(mpg ~ wt + disp, mtcars)
    td2 = tidy(lmfit2)
    check_tidy(td2, exp.row=3)
    expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
})

test_that("tidy.glm works", {
    glmfit <- glm(am ~ wt, mtcars, family="binomial")
    td = tidy(glmfit)
    check_tidy(td, exp.row=2, exp.col=5)
    expect_equal(td$term, c("(Intercept)", "wt"))
    
    glmfit2 <- glm(cyl ~ wt + disp, mtcars, family="poisson")
    td2 = tidy(glmfit2)
    check_tidy(td2, exp.row=3, exp.col=5)
    expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
})

test_that("augment works on lm fits", {
    fit <- lm(wt ~ disp, mtcars)
    au <- augment(fit)

    expect_equal(nrow(mtcars), nrow(au))
})

test_that("augment works on lm fits with NAs", {
    dNAs <- mtcars
    dNAs$mpg[c(1, 3, 5)] <- NA
    
    for (action in c("na.exclude", "na.omit")) {
        fitNAs <- lm(mpg ~ wt, data = dNAs, na.action = action)
        au <- augment(fitNAs)
        expect_equal(nrow(au), sum(complete.cases(dNAs)))
    
        au <- augment(fitNAs, dNAs)
        check_augment(au, dNAs)
    }
})

glmfit <- glm(am ~ wt, mtcars, family="binomial")

test_that("augment works on glm fits", {
    au <- augment(glmfit)    
    check_augment(au, mtcars, exp.names = c(".fitted.response",
                                            ".se.fit.response"))
})

test_that("augment works on glm fits with new data", {
    newdata <- head(mtcars)
    newdata$wt <- newdata$wt + 1

    au <- augment(glmfit, newdata = newdata)
    check_augment(au, newdata, exp.names = c(".fitted.response", ".se.fit.response"))
})
