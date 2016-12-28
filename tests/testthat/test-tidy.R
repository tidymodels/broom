# test individual tidy.ZZZ methods from stats package

context("tidying models")

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

test_that("tidy.anova and tidy.aov work", {
    anovafit = anova(lm(mpg ~ wt + disp, mtcars))
    td = tidy(anovafit)
    check_tidy(td, exp.row=3, exp.col=6)
    expect_true("Residuals" %in% td$term)
    
    aovfit = aov(mpg ~ wt + disp, mtcars)
    td = tidy(anovafit)
    check_tidy(td, exp.row=3, exp.col=6)
    expect_true("Residuals" %in% td$term)
})

test_that("tidy.nls works", {
    nlsfit = nls(wt ~ a + b * mpg + c / disp, data=mtcars, start=list(a=1, b=2, c=3))
    td = tidy(nlsfit)
    check_tidy(td, exp.row=3, exp.col=5)
    expect_equal(td$term, c("a", "b", "c"))
})


context("tidying hypothesis tests")

test_that("tidy.htest works on correlation tests", {
    pco = cor.test(mtcars$mpg, mtcars$wt)
    td = tidy(pco)
    n = c("estimate", "p.value", "statistic", "conf.high", "conf.low")
    check_tidy(td, exp.row=1, exp.names=n)
    
    # suppress warning about ties
    sco = suppressWarnings(cor.test(mtcars$mpg, mtcars$wt, method="spearman"))
    td = tidy(sco)
    check_tidy(td, exp.row=1, exp.names=c("estimate", "p.value"))
})

test_that("tidy.htest works on t-tests", {
    tt = t.test(mpg ~ am, mtcars)
    td = tidy(tt)
    n = c("estimate1", "estimate2", "p.value", "statistic", "conf.high", "conf.low")
    check_tidy(td, exp.row=1, exp.names=n)
})

test_that("tidy.htest works on wilcoxon tests", {
    # suppress warning about ties
    wt = suppressWarnings(wilcox.test(mpg ~ am, mtcars))
    td = tidy(wt)
    n = c("p.value", "statistic")
    check_tidy(td, exp.row=1, exp.names=n)
})

test_that("tidy.summary works (even with NAs)", {
    df <- data.frame(group = c(rep('M', 6), 'F', 'F', 'M', 'M', 'F', 'F'),
                 val = c(6, 5, NA, NA, 6, 13, NA, 8, 10, 7, 14, 6))
    
    td <- tidy(summary(df$val))
    expect_is(td, "data.frame")
    expect_equal(nrow(td), 1)
    expect_equal(td$minimum, 5)
    expect_equal(td$q1, 6)
    expect_equal(td$median, 7)
    expect_lt(abs(td$mean - 25 / 3), .001)
    expect_equal(td$q3, 10)
    expect_equal(td$maximum, 14)
    expect_equal(td$na, 3)
})
