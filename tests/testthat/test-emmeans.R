context("emmeans")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("lsmeans")
library(lsmeans)

fit <- lm(sales1 ~ price1 + price2 + day + store, data = oranges)
rg <- ref.grid(fit)

marginal <- lsmeans(rg, "day")

marginal_summary <- summary(marginal)

joint_tests_summary <- joint_tests(fit)

# generate dataset with dashes
marginal_dashes <- tibble(
  y = rnorm(100),
  x = rep(c("Single", "Double-Barrelled"), 50)
) %>%
  lm(y ~ x, data = .) %>%
  lsmeans::lsmeans(., ~ x) %>%
  lsmeans::contrast(., "pairwise")

test_that("lsmeans tidier arguments", {
  check_arguments(tidy.lsmobj, strict = FALSE)
  check_arguments(tidy.ref.grid)
  check_arguments(tidy.emmGrid)
})

test_that("tidy.lsmobj", {
  tdm <- tidy(marginal)
  tdmd <- tidy(marginal_dashes)
  tdc <- tidy(contrast(marginal, method = "pairwise"))

  check_tidy_output(tdm, strict = FALSE)
  check_tidy_output(tdmd, strict = FALSE)
  check_tidy_output(tdc, strict = FALSE)
  
  check_dims(tdm, 6, 6)
  check_dims(tdmd, 1, 7)
  check_dims(tdc, 15, 7)
})

test_that("ref.grid tidiers work", {
  td <- tidy(rg)
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 36, 7)
})

test_that("summary_emm tidiers work", {
  tdm <- tidy(marginal)
  tdms <- tidy(marginal_summary)
  
  expect_identical(tdm, tdms)
  
  tdjt <- tidy(joint_tests_summary)
  check_tidy_output(tdjt)
  check_dims(tdjt, 2, 5)
})
