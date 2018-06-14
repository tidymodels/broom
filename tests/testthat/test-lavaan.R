context("lavaan tidiers")

test_that("tidy.lavaan works", {
  skip_if_not_installed("lavaan")
  library(lavaan)

  lav_lmfit <- sem("mpg ~ wt", data = mtcars)
  td <- tidy(lav_lmfit)

  check_tidy(td, exp.row = 3, exp.col = 11)
  expect_equal(td$term, c("mpg ~ wt", "mpg ~~ mpg", "wt ~~ wt"))

  cfafit <- cfa(paste("F =~", paste0("x", 1:9, collapse = "+")), data = HolzingerSwineford1939)
  td2 <- tidy(cfafit)
  check_tidy(td2, exp.row = 19, exp.col = 11)
  check_tidy(td2 %>% filter(op == "=~"), exp.row = 9)
  check_tidy(td2 %>% filter(op == "~~"), exp.row = 10)

  # check conf.level
  td3 <- tidy(cfafit, conf.level = .999)
  expect_true(all(td2$conf.high <= td3$conf.high))

  # check passing lavaan params with ...
  td4 <- tidy(cfafit, rsquare = TRUE)
  check_tidy(td4 %>% filter(op == "r2"), exp.row = 9)
})



test_that("glance.lavaan works", {
  skip_if_not_installed("lavaan")
  library(lavaan)

  lav_lmfit <- sem("mpg ~ wt", data = mtcars)
  gl <- glance(lav_lmfit)

  check_tidy(gl, exp.row = 1, exp.col = 7)

  cfafit <- cfa(paste("F =~", paste0("x", 1:9, collapse = "+")), data = HolzingerSwineford1939)
  gl2 <- glance(cfafit)
  check_tidy(gl2, exp.row = 1, exp.col = 7)
  # TODO: if CFI is an important measure it should be included by
  # default and documented
  # check fit.measures
  # gl4 <- glance(cfafit, fit.measures = "CFI")
  # check_tidy(gl4, exp.row = 1, exp.col = 2)
})
