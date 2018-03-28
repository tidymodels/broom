# test tidy, augment, glance from lm objects

context("lm tidiers")

test_that("tidy.lm works", {
    lmfit <- lm(mpg ~ wt, mtcars)
    td <- tidy(lmfit)
    check_tidy(td, exp.row = 2)
    expect_equal(td$term, c("(Intercept)", "wt"))
    
    lmfit2 <- lm(mpg ~ wt + disp, mtcars)
    td2 <- tidy(lmfit2)
    check_tidy(td2, exp.row = 3)
    expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
    
    expect_warning(tidy(lmfit2, exponentiate = TRUE))
})

test_that("tidy.lm with confint = TRUE works even if rank-deficient", {
    d <- data.frame(y = rnorm(4), x = letters[seq_len(4)])
    expect_is(tidy(lm(y ~ x, data = d), confint = TRUE),
              "data.frame")
})

test_that("tidy.glm works", {
    glmfit <- glm(am ~ wt, mtcars, family = "binomial")
    td <- tidy(glmfit)
    check_tidy(td, exp.row = 2, exp.col = 5)
    expect_equal(td$term, c("(Intercept)", "wt"))
    # check exponentiation works
    check_tidy(tidy(glmfit, exponentiate = TRUE), exp.row = 2, exp.col = 5)
    
    glmfit2 <- glm(cyl ~ wt + disp, mtcars, family = "poisson")
    td2 <- tidy(glmfit2)
    check_tidy(td2, exp.row = 3, exp.col = 5)
    expect_equal(td2$term, c("(Intercept)", "wt", "disp"))
    # check exponentiation works
    check_tidy(tidy(glmfit2, exponentiate = TRUE), exp.row = 3, exp.col = 5)
})

test_that("glance.glm works", {
    glmfit <- glm(am ~ wt, mtcars, family = "binomial")
    td <- glance(glmfit)
    check_tidy(td, exp.row = 1, exp.col = 7)
    
    glmfit2 <- glm(cyl ~ wt + disp, mtcars, family = "poisson")
    td2 <- glance(glmfit2)
    check_tidy(td2, exp.row = 1, exp.col = 7)
})

test_that("tidy.lm works with quick", {
    lmfit <- lm(mpg ~ wt, mtcars)
    td <- tidy(lmfit, quick = TRUE)
    check_tidy(td, exp.row = 2, exp.col = 2)
    
    lmfit2 <- lm(mpg ~ wt + disp, mtcars)
    td2 <- tidy(lmfit2, quick = TRUE)
    check_tidy(td2, exp.row = 3, exp.col = 2)
})

test_that("augment and glance do not support multiple responses", {
    mlmfit <- lm(cbind(mpg, am) ~ wt + disp, mtcars)
    expect_error(augment(mlmfit))
    expect_error(glance(mlmfit))
})
