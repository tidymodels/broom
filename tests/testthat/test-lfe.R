context("lfe")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("lfe")

set.seed(27)
n <- 100
df <- data.frame(
  id = sample(5, n, TRUE),
  v1 = sample(5, n, TRUE),
  v2 = sample(1e6, n, TRUE),
  v3 = sample(round(runif(100, max = 100), 4), n, TRUE),
  v4 = sample(round(runif(100, max = 100), 4), n, TRUE)
)

fit <- lfe::felm(v2 ~ v3, df)
fit2 <- lfe::felm(v2 ~ v3 | id + v1, df, na.action = na.exclude)
fit_multi <- lfe::felm(v1 + v2 ~ v3 , df)


form <- v2 ~ v4
fit_form <- lfe::felm(form, df)  # part of a regression test

test_that("felm tidier arguments", {
  check_arguments(tidy.felm)
  check_arguments(glance.felm)
  check_arguments(augment.felm)
})

test_that("tidy.felm", {
  td1 <- tidy(fit)
  td2 <- tidy(fit2, conf.int = TRUE, fe = TRUE, fe.error = FALSE)
  td3 <- tidy(fit2, conf.int = TRUE, fe = TRUE)
  td4 <- tidy(fit_form)
  td5 <- tidy(fit, robust = TRUE)
  td6 <- tidy(fit2, robust = TRUE)
  td7 <- tidy(fit2, robust = TRUE, fe = TRUE)
  
  td_multi <- tidy(fit_multi)

  check_tidy_output(td1)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td4)
  check_tidy_output(td5)
  check_tidy_output(td6)
  check_tidy_output(td7)
  check_tidy_output(td_multi)

  check_dims(td1, 2, 5)
  
  expect_equal(tidy(fit_multi)[3:4, -1], tidy(fit))
  expect_equal(dplyr::pull(td5, std.error), 
               as.numeric(lfe:::summary.felm(fit, robust = TRUE)$coef[, "Robust s.e"]))
  expect_equal(dplyr::pull(td6, std.error), 
               as.numeric(lfe:::summary.felm(fit2, robust = TRUE)$coef[, "Robust s.e"]))
})

test_that("glance.felm", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  
  check_glance_outputs(gl, gl2)
  check_dims(gl, expected_cols = 8)
  
  expect_error(glance(fit_multi), "Glance does not support linear models with multiple responses.")
})

test_that("augment.felm", {
  
  check_augment_function(
    aug = augment.felm,
    model = fit,
    data = df
  )
  
  check_augment_function(
    aug = augment.felm,
    model = fit2,
    data = df
  )
  
  check_augment_function(
    aug = augment.felm,
    model = fit_form,
    data = df
  )
  expect_error(augment(fit_multi), "Augment does not support linear models with multiple responses.")
})
