context("lavaan")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("lavaan")
library(lavaan)

fit <- sem("mpg ~ wt", data = mtcars)
form <- paste("F =~", paste0("x", 1:9, collapse = " + "))
fit2 <- cfa(form, data = HolzingerSwineford1939)

test_that("lavaan tidier arguments", {
  check_arguments(tidy.lavaan)
  check_arguments(glance.lavaan)
})

test_that("tidy.lavaan", {
  td <- tidy(fit, conf.int = TRUE)
  td2 <- tidy(fit2, conf.int = TRUE)
  tdc <- tidy(fit2, conf.int = TRUE, conf.level = .999)
  tdr <- tidy(fit2, rsquare = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(tdc)
  check_tidy_output(tdr)

  check_dims(td, 3, 11)
  # std.nox not available without fixed exogenous predictors (#1217)
  check_dims(td2, 19, 10)

  expect_equal(td$term, c("mpg ~ wt", "mpg ~~ mpg", "wt ~~ wt"))

  op_counts <- dplyr::count(td2, op)$n
  expect_true((all(9:10 %in% op_counts)))

  # check conf level
  expect_true(all(td2$conf.high <= tdc$conf.high))

  # passing arguments via ...
  check_dims(filter(tdr, op == "r2"), expected_rows = 9)
})


test_that("glance.lavaan", {
  gl <- glance(fit)
  check_glance_outputs(gl)

  gl2 <- glance(fit2)
  check_glance_outputs(gl2)
})
