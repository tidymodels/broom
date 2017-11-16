context("nls tidiers")

test_that("nls tidiers work", {
    nlsfit <- nls(wt ~ a + b * mpg + c / disp,
                  data = mtcars,
                  start = list(a = 1, b = 2, c = 3))
    td <- tidy(nlsfit, conf.int = TRUE)
    check_tidy(td, exp.row = 3, exp.col = 7)
    expect_equal(td$term, c("a", "b", "c"))
    
    tdq <- tidy(nlsfit, conf.int = TRUE, quick = TRUE)
    check_tidy(tdq, exp.row = 3, exp.col = 2)
    
    au <- augment(nlsfit)
    check_tidy(au, exp.col = 5)
    
    au_full <- augment(nlsfit, newdata = mtcars)
    check_tidy(au_full, exp.col = ncol(mtcars) + 2)
    
    gl <- glance(nlsfit)
    check_tidy(gl, exp.col = 8)
})

test_that("tidying single covariate works", {
    nlsfit2 <- nls(wt ~ b * mpg, data = mtcars, start = list(b = 2))
    td2 <- tidy(nlsfit2, conf.int = TRUE)
    check_tidy(td2, exp.row = 1, exp.col = 7)
})
