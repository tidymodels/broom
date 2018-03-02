context("survival tidiers")

library(survival)

test_that("aareg tidiers work regardless of dfbeta", {
    afit1 <- aareg(Surv(time, status) ~ age + sex + ph.ecog, data = lung,
                  dfbeta = FALSE)
    td <- tidy(afit1)
    check_tidy(td, exp.row = 4, exp.col = 6)
    expect_equal(td$term, c("Intercept", "age", "sex", "ph.ecog"))
    
    afit2 <- aareg(Surv(time, status) ~ age + sex + ph.ecog, data = lung,
                   dfbeta = TRUE)
    td <- tidy(afit2)
    check_tidy(td, exp.row = 4, exp.col = 7)
    expect_equal(td$term, c("Intercept", "age", "sex", "ph.ecog"))
    
    gl <- glance(afit1)
    check_tidy(gl, exp.col = 3)
    
    gl <- glance(afit1)
    check_tidy(gl, exp.col = 3)
})

test_that("cch tidiers work", {
    subcoh <- nwtco$in.subcohort
    selccoh <- with(nwtco, rel == 1 | subcoh == 1)
    ccoh.data <- nwtco[selccoh, ]
    ccoh.data$subcohort <- subcoh[selccoh]
    ccoh.data$histol <- factor(ccoh.data$histol, labels = c("FH", "UH"))
    ccoh.data$stage <-
        factor(ccoh.data$stage, labels = c("I", "II", "III", "IV"))
    ccoh.data$age <- ccoh.data$age / 12
    fit.ccP <- cch(Surv(edrel, rel) ~ stage + histol + age, data = ccoh.data,
                   subcoh = ~subcohort, id = ~seqno, cohort.size = 4028)
    td <- tidy(fit.ccP)
    check_tidy(td, exp.row = 5, exp.col = 7)
    gl <- glance(fit.ccP)
    check_tidy(gl, exp.col = 6)
})

test_that("coxph tidiers work", {
    cfit <- coxph(Surv(time, status) ~ age + sex, lung)
    td <- tidy(cfit)
    check_tidy(td, exp.row = 2, exp.col = 7)
    td_exp <- tidy(cfit, exponentiate = TRUE)
    check_tidy(td_exp, exp.row = 2, exp.col = 7)
    
    cfit_rob <- coxph(Surv(time, status) ~ age + sex, lung, robust = TRUE)
    td_rob <- tidy(cfit_rob)
    check_tidy(td_rob, exp.row = 2, exp.col = 8)
    
    ag <- augment(cfit)
    check_tidy(ag, exp.col = 6)
    
    gl <- glance(cfit)
    check_tidy(gl, exp.col = 15)
    
    gl_rob <- glance(cfit_rob)
    check_tidy(gl_rob, exp.col = 17)
})

test_that("survfit tidiers work", {
    cfit <- coxph(Surv(time, status) ~ age + strata(sex), lung)
    sfit <- survfit(cfit)
    td <- tidy(sfit)
    check_tidy(td, exp.col = 9)
    
    fitCI <- survfit(Surv(stop, status * as.numeric(event), type = "mstate") ~ 1,
                     data = mgus1, subset = (start == 0))
    td_multi <- tidy(fitCI)
    check_tidy(td_multi, exp.col = 9)
    
    expect_error(glance(sfit))
    expect_error(glance(fitCI))
    
    sfit <- survfit(coxph(Surv(time, status) ~ age + sex, lung))
    gl <- glance(sfit)
    check_tidy(gl, exp.col = 9)
})

test_that("survexp tidiers work", {
    sexpfit <- suppressWarnings(
        survexp(futime ~ 1, rmap = list(sex = "male", year = accept.dt,
                                        age = accept.dt - birth.dt),
                method = "conditional", data = jasa)
    )
    td <- tidy(sexpfit)
    check_tidy(td, exp.col = 3)
    
    gl <- glance(sexpfit)
    check_tidy(gl, exp.col = 3)
})

test_that("pyears tidiers work", {
    temp.yr  <- tcut(mgus$dxyr, 55:92, labels = as.character(55:91)) 
    temp.age <- tcut(mgus$age, 34:101, labels = as.character(34:100))
    ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
    pstat <- ifelse(is.na(mgus$pctime), 0, 1)
    pfit <- pyears(Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus,
                   data.frame = TRUE)
    td <- tidy(pfit)
    check_tidy(td, exp.col = 6)
    
    gl <- glance(pfit)
    check_tidy(gl, exp.col = 2)
    
    pfit2 <- pyears(Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus,
                    data.frame = FALSE)
    td2 <- tidy(pfit2)
    expect_is(td2, "data.frame")
    
    gl2 <- glance(pfit2)
    check_tidy(gl2, exp.col = 2)
})

test_that("survreg tidiers work", {
    sr <- survreg(Surv(futime, fustat) ~ ecog.ps + rx, ovarian,
                  dist = "exponential")
    td <- tidy(sr)
    check_tidy(td, exp.row = 3, exp.col = 7)
    expect_equal(td$term, c("(Intercept)", "ecog.ps", "rx"))
    
    ag <- augment(sr)
    check_tidy(ag, exp.col = 6)
    
    gl <- glance(sr)
    check_tidy(gl, exp.col = 9)
})

if (require("survival", quietly = TRUE)) {
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
