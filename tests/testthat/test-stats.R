context("stats")

test_that("tidy.density", {
  den <- density(faithful$eruptions, bw = "sj")
  td <- tidy(den)
  
  check_arguments(tidy.density)
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 512, 2)
})

test_that("tidy.dist", {
  iris_dist <- dist(t(iris[, 1:4]))
  td <- tidy(iris_dist)
  
  check_arguments(tidy.dist)
  check_tidy_output(td)
  check_dims(td, 6, 3)
})
