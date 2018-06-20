

# NOTE: commenting out old check_augment_NAs in favor of new tests to come

# test the augment method of lm, glm, nls, lmer, coxph, and survreg
# (note that test_that cases contained within the check_augment_NAs
# function)
# 
# context("lm augment")
# lm_func <- function(.data, ...) lm(mpg ~ wt, .data, ...)
# check_augment_NAs(lm_func, mtcars, "mpg", "wt")
# 
# context("glm augment")
# glm_func <- function(.data, ...) glm(am ~ wt, .data, family = "poisson", ...)
# check_augment_NAs(glm_func, mtcars, "am", "wt")
# 
# context("nls augment")
# nls_func <- function(.data, ...) {
#   nls(mpg ~ k * e^wt, data = .data, start = list(k = 50, e = 1), ...)
# }
# check_augment_NAs(nls_func, mtcars, "mpg", "wt")
# 
# if (require("lme4", quietly = TRUE)) {
#   context("lme4 augment")
#   lmer_func <- function(.data, ...) {
#     lmer(Reaction ~ Days + (Days | Subject), .data, ...)
#   }
#   check_augment_NAs(lmer_func, sleepstudy, "Reaction", "Days")
# }
# 
# if (require("survival", quietly = TRUE)) {
#   context("survival augment")
#   coxph_func <- function(.data, ...) {
#     coxph(Surv(time, status) ~ age + sex, .data, ...)
#   }
#   check_augment_NAs(coxph_func, lung, "age", "sex")
# 
#   survreg_func <- function(.data, ...) {
#     survreg(
#       Surv(futime, fustat) ~ ecog.ps + rx,
#       .data,
#       dist = "exponential",
#       ...
#     )
#   }
#   check_augment_NAs(survreg_func, ovarian, "ecog.ps", "rx")
# }

context("htest augment")

test_that("augment.htest works on chi squared tests", {
  # 2 dimensions table
  chit <- chisq.test(xtabs(Freq ~ Sex + Class, data = as.data.frame(Titanic)))
  expect_is(augment(chit), "data.frame")
  expect_true(all(
    c(".observed", ".prop", ".expected", ".residuals", ".stdres")
    %in% names(augment(chit))
  ))
  expect_true(all(c(".row.prop", ".col.prop") %in% names(augment(chit))))

  # 1 dimension table
  chit <- chisq.test(c(A = 20, B = 15, C = 25))
  expect_is(augment(chit), "data.frame")
  expect_true(all(
    c(".observed", ".prop", ".expected", ".residuals", ".stdres")
    %in% names(augment(chit))
  ))
  expect_true(!any(c(".row.prop", ".col.prop") %in% names(augment(chit))))
})

test_that("augment.htest not defined for other types of htest", {
  tt <- t.test(rnorm(10))
  expect_error(augment(tt))

  wt <- wilcox.test(mpg ~ am, data = mtcars, conf.int = TRUE, exact = FALSE)
  expect_error(augment(wt))

  ct <- cor.test(mtcars$wt, mtcars$mpg)
  expect_error(augment(ct))
})

context("NULL and default augment")

test_that("NULL augment returns NULL", {
  expect_length(augment(NULL), 0)
})

test_that("default augment throws error for unimplemented methods", {
  expect_error(augment(TRUE))
  expect_error(augment(1))
  expect_error(augment(1L))
  expect_error(augment("a"))

  x <- 5
  class(x) <- c("foo", "bar")
  expect_error(augment(x), regexp = "foo")
  expect_error(augment(x), regexp = "[^bar]")
})
