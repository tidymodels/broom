# test tidy, augment, glance from speedlm objects

if (require("speedglm", quietly = TRUE)) {
    context("speedlm tidiers")
    
    test_that("tidy works on speedlm", {
        speedlmfit <- speedlm(mpg ~ wt, mtcars)
        td = tidy(speedlmfit)
        check_tidy(td, exp.row=2)
        expect_equal(td$term, c("(Intercept)", "wt"))
        
        speedlmfit2 <- lm(mpg ~ wt + disp, mtcars)
        td2 = tidy(speedlmfit2)
        check_tidy(td2, exp.row=3)
        expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
    })
    
    test_that("glance works on speedlm", {
        speedlmfit <- speedlm(mpg ~ wt, mtcars)
        glance <- glance(speedlmfit)
        expect_equal(nrow(glance), 1)
    })
    
    test_that("augment works on speedlm", {
        speedlmfit <- speedlm(mpg ~ wt, mtcars)
        # we don't do check_augment_NAs because speedlm doesn't accept a na.action argument
        au <- augment(speedlmfit)
        check_augment(au, mtcars)
        au2 <- augment(speedlmfit, mtcars)
        check_augment(au2, mtcars, same = colnames(mtcars))
    })
}
