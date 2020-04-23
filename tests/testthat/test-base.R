context("base")

skip("Deprecated")

test_that("tidy.table", {
  tab <- with(airquality, table(Temp = cut(Temp, quantile(Temp)), Month))
  td <- tidy(tab)
  check_tidy_output(td)
  check_dims(td, 20, 3)
})
