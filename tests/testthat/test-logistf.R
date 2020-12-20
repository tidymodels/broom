# These tests are commented out even if they pass. There is a weird side-effect
# conflict going on between `logisft` and `stats::oneway.test`. When the
# `logistf` package is loaded and the estimation function executed,
# `oneway.test` gives: "Error: a two-sided formula is required"
# Similar to this: https://stackoverflow.com/questions/65067248/a-two-sided-formula-is-required-for-oneway-test

# context("logistf")


# skip_on_cran()
# skip_if_not_installed("modeltests")
# skip_if_not_installed("logistf")


# library(modeltests)
# library(logistf)


# test_that("logistf tidier arguments", {
#   check_arguments(tidy.logistf)
#   check_arguments(glance.logistf)
# })


# test_that("tidy.logistf", {
#   data(sex2, package = "logistf")
#   fit = logistf::logistf(case ~ age + oc + vic + vicl + vis + dia, data = sex2)
#   t1 <- tidy(fit)
#   t2 <- tidy(fit, conf.int=TRUE)
#   t3 <- expect_warning(tidy(fit, conf.int=TRUE, conf.level=.99))
#   g1 <- glance(fit)

#   check_tidy_output(t1)
#   check_tidy_output(t2)
#   check_tidy_output(t3)
#   check_dims(t1, expected_cols = 4, expected_rows = 7)
#   check_dims(t2, expected_cols = 6, expected_rows = 7)
#   check_dims(t3, expected_cols = 6, expected_rows = 7)

#   check_glance_outputs(g1)
#   check_dims(g1, expected_cols = 2, expected_rows = 1)
# })
