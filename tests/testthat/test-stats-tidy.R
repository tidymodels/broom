context("stats-tidy")

test_that("tidy.ftable works", {
  ftab <- ftable(Titanic, row.vars = 1:3)
  td <- tidy(ftab)
  check_tidy(td, exp.row = 32, exp.col = 5)
})

test_that("tidy.density works", {
  den <- density(faithful$eruptions, bw = "sj")
  td <- tidy(den)
  check_tidy(td, exp.row = 512, exp.col = 2)
})

test_that("tidy.dist works", {
  iris_dist <- dist(t(iris[, 1:4]))
  td <- tidy(iris_dist)
  check_tidy(td, exp.row = 6, exp.col = 3)
})
