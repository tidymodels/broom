context("stats-tests")

test_that("tidy.htest same as glance.htest", {
  tt <- t.test(rnorm(10))
  expect_identical(tidy(tt), glance(tt))
})

test_that("oneway.test works", {
  ot <- oneway.test(extra ~ group, data = sleep)
  expect_message(td <- tidy(ot))
  check_tidy(td, exp.col = 5)
})

test_that("tidy.htest works on correlation tests", {
  pco <- cor.test(mtcars$mpg, mtcars$wt)
  td <- tidy(pco)
  n <- c("estimate", "p.value", "statistic", "conf.high", "conf.low")
  check_tidy(td, exp.row = 1, exp.names = n)
  
  # suppress warning about ties
  sco <- suppressWarnings(cor.test(mtcars$mpg, mtcars$wt, method = "spearman"))
  td <- tidy(sco)
  check_tidy(td, exp.row = 1, exp.names = c("estimate", "p.value"))
})

test_that("tidy.htest works on t-tests", {
  tt <- t.test(mpg ~ am, mtcars)
  td <- tidy(tt)
  n <- c("estimate1", "estimate2", "p.value", "statistic", "conf.high", "conf.low")
  check_tidy(td, exp.row = 1, exp.names = n)
})

test_that("tidy.htest works on wilcoxon tests", {
  # suppress warning about ties
  wt <- suppressWarnings(wilcox.test(mpg ~ am, mtcars))
  td <- tidy(wt)
  n <- c("p.value", "statistic")
  check_tidy(td, exp.row = 1, exp.names = n)
})


test_that("tidy.pairwise.htest works", {
  pht <- with(iris, pairwise.t.test(Petal.Length, Species))
  td <- tidy(pht)
  check_tidy(td, exp.row = 3, exp.col = 3)
})

test_that("tidy.power.htest works", {
  ptt <- power.t.test(n = 2:30, delta = 1)
  td <- tidy(ptt)
  check_tidy(td, exp.row = 29, exp.col = 5)
})

