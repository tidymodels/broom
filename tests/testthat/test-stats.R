context("stats")

skip_if_not_installed("modeltests")
library(modeltests)

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
  td_upper <- tidy(iris_dist, upper = TRUE)
  td_diag <- tidy(iris_dist, diagonal = TRUE)
  td_all <- tidy(iris_dist, upper = TRUE, diagonal = TRUE)
  
  check_arguments(tidy.dist)
  check_tidy_output(td)
  check_dims(td, 6, 3)
  
  check_tidy_output(td_upper)
  check_dims(td_upper, 12, 3)
  
  check_tidy_output(td_diag)
  check_dims(td_diag, 10, 3)
  
  check_tidy_output(td_all)
  check_dims(td_all, 16, 3)
  
})
