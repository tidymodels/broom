context("robust tidiers")

library(robust)

m <- lmRob(mpg ~ wt, data = mtcars)
gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")

test_that("tidy.lmRob, augment.lmRob, tidy.glmRob, augment.glmRob use lm", {
    expect_identical(tidy(m), tidy.lm(m))
    expect_identical(augment(m), augment.lm(m))
    expect_identical(tidy(gm), tidy.lm(gm))
    expect_identical(augment(gm), augment.lm(gm))
    
    td <- tidy(m)
    check_tidy(td, exp.row = 2, exp.col = 5)
    
    td <- tidy(gm)
    check_tidy(td, exp.row = 2, exp.col = 5)
})

test_that("glance.lmRob and glance.glmRob work", {
    gl <- glance(m)
    check_tidy(gl, exp.col = 4)
    
    gl <- glance(gm)
    check_tidy(gl, exp.col = 3)
})
