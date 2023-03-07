context("lmtest")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("lmtest")
library(lmtest)

skip_if_not_installed("sandwich")
library(sandwich)

m <- lm(dist ~ speed, data = cars)
ct <- lmtest::coeftest(m)
ct2 <- lmtest::coeftest(m, save = TRUE)
ct3 <- lmtest::coeftest(m, vcov = sandwich::vcovHC)

test_that("tidy.coeftest", {
  # skip_on_os("linux")

  check_arguments(tidy.coeftest)

  td <- tidy(ct)
  td2 <- tidy(ct2)
  td3 <- tidy(ct3)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td3)

  check_dims(td, 2, 5)

  # conf int
  td_ci <- tidy(ct, conf.int = TRUE, conf.level = 0.9) %>%
    tibble::remove_rownames()
  check_tidy_output(td_ci)
  check_dims(td_ci, 2, 7)

  # should be like lm!
  td_lm_ci <- tidy(m, conf.int = TRUE, conf.level = 0.9) %>%
    tibble::remove_rownames()
  expect_equal(td_lm_ci, td_ci)
})

test_that("glance.coeftest", {
  gl <- glance(ct)
  gl2 <- glance(ct2)
  gl3 <- glance(ct3)

  check_glance_outputs(gl, gl3)
  check_glance_outputs(gl2) # separately because save = TRUE adds cols
})
