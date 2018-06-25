context("base-tidy")

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
    mean = 8.33,
    q3 = 10,
    maximum = 14,
    na = 3
  )
  
  expect_equivalent(td, expected, tolerance = 0.1)
  
  td <- tidy(summary(df$val))
  
  
  expect_is(td, "data.frame")
  expect_equal(nrow(td), 1)
  expect_equal(td$minimum, 5)
  expect_equal(td$q1, 6)
  expect_equal(td$median, 7)
  expect_lt(abs(td$mean - 25 / 3), .001)
  expect_equal(td$q3, 10)
  expect_equal(td$maximum, 14)
  expect_equal(td$na, 3)
  
  gl <- glance(summary(df$val)) # same as td
  expect_identical(td, gl)
})


test_that("tidy.table", {
  tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))
  td <- tidy(tab)
  check_tidy_output(td)
  check_dims(td, 20, 3)
})
