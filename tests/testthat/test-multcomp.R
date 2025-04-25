skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("multcomp")
suppressPackageStartupMessages(library(multcomp))

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
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 3, 7)
})

test_that("tidy.confint.glht", {
  td <- tidy(confint(wht))
  check_tidy_output(td)
  check_dims(td, 3, 5)
})

test_that("tidy.summary.glht works", {
  td <- tidy(summary(wht, test = adjusted("bonferroni")))
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 3, 7)

  expect_true("adj.p.value" %in% colnames(td))
  expect_identical(td, tidy(wht, test = adjusted("bonferroni")))

  td <- tidy(summary(wht, test = adjusted("none")))
  expect_true("p.value" %in% colnames(td))
})

test_that("tidy.cld works", {
  td <- tidy(multcomp::cld(wht))
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 3, 2)
})

test_that("tidy.glht consistency with tidy.TukeyHSD", {
  set.seed(13986)
  td_hsd <- tidy(TukeyHSD(amod, "tension"))
  td_glht <- tidy(wht, conf.int = TRUE) |>
    dplyr::select(-statistic) |>
    mutate(contrast = gsub(" ", "", contrast))

  expect_equal(
    as.data.frame(td_hsd),
    as.data.frame(td_glht),
    ignore_attr = TRUE,
    tolerance = 0.001
  )
})
