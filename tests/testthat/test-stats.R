context("stats")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("modeldata")
library(modeldata)
data(hpc_data)

hpc <- hpc_data[, 2:5]

test_that("tidy.density", {
  den <- density(faithful$eruptions, bw = "sj")
  td <- tidy(den)

  check_arguments(tidy.density)
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 512, 2)
})

test_that("tidy.dist", {
  hpc_dist <- dist(t(hpc))
  td <- tidy(hpc_dist)
  td_upper <- tidy(hpc_dist, upper = TRUE)
  td_diag <- tidy(hpc_dist, diagonal = TRUE)
  td_all <- tidy(hpc_dist, upper = TRUE, diagonal = TRUE)

  check_arguments(tidy.dist)
  check_tidy_output(td)
  check_dims(td, 12, 3)

  check_tidy_output(td_upper)
  check_dims(td_upper, 12, 3)

  check_tidy_output(td_diag)
  check_dims(td_diag, 16, 3)

  check_tidy_output(td_all)
  check_dims(td_all, 16, 3)
})
