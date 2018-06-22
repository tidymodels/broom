context("multcomp")

skip_if_not_installed("multcomp")
library(multcomp)

amod <- aov(breaks ~ wool + tension, data = warpbreaks)
wht <- glht(amod, linfct = mcp(tension = "Tukey"))

test_that("multcomp tidier arguments", {
  check_arguments(tidy.glht)
  check_arguments(tidy.confint.glht)
  check_arguments(tidy.summary.glht)
  check_arguments(tidy.cld)
})

test_that("tidy.glht", {
  td <- tidy(wht)
  check_tidy_output(td)
  check_dims(td, 3, 3)
})

test_that("tidy.confint.glht", {
  td <- tidy(confint(wht))
  check_tidy_output(td)
  check_dims(td, 3, 5)
})

test_that("tidy.summary.glht works", {
  td <- tidy(summary(wht))
  check_tidy_output(td)
  check_dims(td, 3, 6)
})

test_that("tidy.cld works", {
  td <- tidy(cld(wht))
  check_tidy_output(td)
  check_dims(td, 3, 2)
})
