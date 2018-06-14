context("map tidiers")

test_that("tidy.map works", {
  skip_if_not_installed("maps")
  ca <- maps::map("county", "ca", plot = FALSE, fill = TRUE)
  td <- tidy(ca)
  check_tidy(td, exp.col = 7)
})
