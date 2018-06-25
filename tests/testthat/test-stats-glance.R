context("stats-glance")



context("tidying summaries")

test_that("tidy.summary works (even with NAs)", {
  df <- data.frame(
    group = c(rep("M", 6), "F", "F", "M", "M", "F", "F"),
    val = c(6, 5, NA, NA, 6, 13, NA, 8, 10, 7, 14, 6)
  )
  
  td <- tidy(summary(df$val))
  gl <- glance(summary(df$val)) # same as td
  expect_identical(td, gl)
})

