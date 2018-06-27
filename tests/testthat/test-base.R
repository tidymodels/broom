context("base")

test_that("tidy.summary", {
  
  df <- tibble(
    group = c(rep("M", 6), "F", "F", "M", "M", "F", "F"),
    val = c(6, 5, NA, NA, 6, 13, NA, 8, 10, 7, 14, 6)
  )
  
  summ <- summary(df$val)
  td <- tidy(summ)
  
  expected <- tibble(
    minimum = 5,
    q1 = 6,
    median = 7,
    mean = mean(df$val, na.rm = TRUE),
    q3 = 10,
    maximum = 14,
    na = 3
  )
  
  expect_equivalent(td, expected)
  
  td <- tidy(summary(df$val))
  
  gl <- glance(summary(df$val)) # same as td. TODO: does this make sense?
  expect_identical(td, gl)
})


test_that("tidy.table", {
  tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))
  td <- tidy(tab)
  check_tidy_output(td)
  check_dims(td, 20, 3)
})
