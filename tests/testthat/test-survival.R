if(require("survival", quietly = TRUE)) {
    context("test survival tidiers")
    surv_fit <- survreg(Surv(futime, fustat) ~ ecog.ps + rx, ovarian, dist = "exponential")  
    coxph_fit <- coxph(Surv(time, status) ~ age + sex, lung)
    
    test_that("tidy.survreg works", {
        tidy_names <- unlist(strsplit("term estimate std.error statistic p.value conf.low conf.high", " "))
        td <- tidy(surv_fit)
        check_tidy(td, exp.row = 3, exp.col = 7, exp.names = tidy_names)
    })
    
    test_that("glance.survreg works", {
        tidy_names <- unlist(strsplit("iter df chi p.value logLik AIC BIC df.residual", " "))
        td <- glance(surv_fit)
        check_tidy(td, exp.row = 1, exp.col = 9, exp.names = tidy_names)
    })
    
    test_that("tidy.coxph works", {
        tidy_names <- unlist(strsplit("term estimate std.error statistic p.value conf.low conf.high", " "))
        td <- tidy(coxph_fit)
        check_tidy(td, exp.row = 2, exp.col = 7, exp.names = tidy_names)
    })
    
    test_that("glance.coxph works", {
        td <- glance(coxph_fit)
        check_tidy(td, exp.row = 1)
    })
}
