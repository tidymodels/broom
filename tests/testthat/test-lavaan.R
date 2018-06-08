# test tidy, augment, glance from lavaan fit objects

context("lavaan tidiers")
suppressPackageStartupMessages(library(lavaan))

test_that("tidy.lavaan works", {
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
  expect_true(all(td2$conf.hi <= td3$conf.hi))

  # check passing lavaan params with ...
  td4 <- tidy(cfafit, rsquare = T)
  check_tidy(td4 %>% filter(op == "r2"), exp.row = 9)
})



test_that("glance.lavaan works", {
  lav_lmfit <- sem("mpg ~ wt", data = mtcars)
  gl <- glance(lav_lmfit)
  glw <- glance(lav_lmfit, long = F)
  check_tidy(gl, exp.row = 7, exp.col = 2)
  check_tidy(glw, exp.row = 1, exp.col = 7)
  expect_true("npar" %in% gl$term)
  expect_equal(glw$npar[1], 2)

  cfafit <- cfa(paste("F =~", paste0("x", 1:9, collapse = "+")), data = HolzingerSwineford1939)
  gl2 <- glance(cfafit)
  check_tidy(gl2, exp.row = 7, exp.col = 2)

  gl3 <- glance(cfafit, long = F)
  expect_equal(gl3$npar[1], 18)

  # check fit.measures
  gl4 <- glance(cfafit, fit.measures = "CFI")
  check_tidy(gl4, exp.row = 1, exp.col = 2)
})

test_that("glance.lavaan works", {
  lav_lmfit <- sem("mpg ~ wt", data = mtcars)
  expect_warning(augment(lav_lmfit), "Not yet implemented")
})
