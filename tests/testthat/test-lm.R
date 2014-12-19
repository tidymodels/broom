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
    
    expect_warning(tidy(lmfit2, exponentiate = TRUE))
})

test_that("tidy.glm works", {
    glmfit <- glm(am ~ wt, mtcars, family="binomial")
    td = tidy(glmfit)
    check_tidy(td, exp.row=2, exp.col=5)
    expect_equal(td$term, c("(Intercept)", "wt"))
    # check exponentiation works
    check_tidy(tidy(glmfit, exponentiate = TRUE), exp.row=2, exp.col=5)
    
    glmfit2 <- glm(cyl ~ wt + disp, mtcars, family="poisson")
    td2 = tidy(glmfit2)
    check_tidy(td2, exp.row=3, exp.col=5)
    expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
    # check exponentiation works
    check_tidy(tidy(glmfit2, exponentiate = TRUE), exp.row=3, exp.col=5)
})
