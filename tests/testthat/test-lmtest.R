context("lmtest")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("lmtest")
library(lmtest)

fit <- lm(length ~ age, data = Mandible, subset = (age <= 28))
ct <- lmtest::coeftest(fit)

test_that("tidy.coeftest", {
  
  check_arguments(tidy.coeftest)
  
  td <- tidy(ct)
  check_tidy_output(td)
  check_dims(td, 2, 5)
  
  ## conf int
  td_ci <- tidy(ct, conf.int=TRUE, conf.level = 0.9)
  check_tidy_output(td_ci)
  check_dims(td_ci, 2, 7)
  
  ## should be like lm!
  td_lm_ci <- tidy(fit, conf.int=TRUE, conf.level = 0.9)
  expect_equal(td_lm_ci, td_ci)
})
