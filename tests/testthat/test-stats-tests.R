context("stats-tests")

test_that("htest tidier arguments", {
  check_arguments(tidy.htest)
  check_arguments(glance.htest)
})

test_that("tidy.htest same as glance.htest", {
  tt <- t.test(rnorm(10))
  expect_identical(tidy(tt), glance(tt))
})

test_that("tidy.htest/oneway.test", {
  ot <- oneway.test(extra ~ group, data = sleep)
  expect_message(td <- tidy(ot))
  gl <- glance(ot)
  
  check_tidy_output(td)
  check_dims(td, expected_cols = 5)
  check_glance_outputs(gl)
})

test_that("tidy.htest/cor.test", {
  pco <- cor.test(mtcars$mpg, mtcars$wt)
  td <- tidy(pco)
  gl <- glance(pco)
  
  check_tidy_output(td)
  check_glance_outputs(gl)
  
  
  sco <- suppressWarnings(cor.test(mtcars$mpg, mtcars$wt, method = "spearman"))
  td2 <- tidy(sco)
  gl2 <- glance(sco)
  
  check_tidy_output(td2)
  check_glance_outputs(gl2)
})

test_that("tidy.htest/t.test", {
  tt <- t.test(mpg ~ am, mtcars)
  td <- tidy(tt)
  gl <- glance(tt)
  
  check_tidy_output(td)
  check_glance_outputs(gl)
})

test_that("tidy.htest/wilcox.test", {
  wt <- suppressWarnings(wilcox.test(mpg ~ am, mtcars))
  td <- tidy(wt)
  gl <- glance(wt)
  
  
  check_tidy_output(td)
  check_glance_outputs(gl)
})

test_that("tidy.pairwise.htest", {
  pht <- with(iris, pairwise.t.test(Petal.Length, Species))
  td <- tidy(pht)
  gl <- glance(pht)
  
  check_arguments(tidy.pairwise.htest)
  check_tidy_output(td)
  check_glance_outputs(gl)
})

test_that("tidy.power.htest", {
  ptt <- power.t.test(n = 2:30, delta = 1)
  td <- tidy(ptt)
  gl <- glance(ptt)
  
  check_arguments(tidy.power.htest)
  check_tidy_output(td)
  check_glance_outputs(gl)
})

