# test the augment method of lm, glm, nls, lmer, coxph, and survreg
# (note that test_that cases contained within the check_augment_NAs
# function)

context("lm augment")
lm_func <- function(.data, ...) lm(mpg ~ wt, .data, ...)
check_augment_NAs(lm_func, mtcars, "mpg", "wt")

context("glm augment")
glm_func <- function(.data, ...) glm(am ~ wt, .data, family = "poisson", ...)
check_augment_NAs(glm_func, mtcars, "am", "wt")

context("nls augment")
nls_func <- function(.data, ...) {
    nls(mpg ~ k * e ^ wt, data = .data, start = list(k = 50, e = 1), ...)
}
check_augment_NAs(nls_func, mtcars, "mpg", "wt")

if (require("lme4", quietly = TRUE)) {
    context("lme4 augment")
    lmer_func <- function(.data, ...) {
        lmer(Reaction ~ Days + (Days | Subject), .data, ...)
    }
    check_augment_NAs(lmer_func, sleepstudy, "Reaction", "Days")
}

if (require("survival", quietly = TRUE)) {
    context("survival augment")
    coxph_func <- function(.data, ...) {
        coxph(Surv(time, status) ~ age + sex, .data, ...)
    }
    check_augment_NAs(coxph_func, lung, "age", "sex")
    
    survreg_func <- function(.data, ...) {
        survreg(Surv(futime, fustat) ~ ecog.ps + rx, .data, dist = "exponential", ...)
    }
    check_augment_NAs(survreg_func, ovarian, "ecog.ps", "rx")
}