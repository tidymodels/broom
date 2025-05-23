skip_on_cran()

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

# no FE or clus
fit <- lfe::felm(v2 ~ v3, df)
# with FE
fit2 <- lfe::felm(v2 ~ v3 | id + v1, df, na.action = na.exclude)

# with clus
fit3 <- lfe::felm(v2 ~ v3 | 0 | 0 | id + v1, df, na.action = na.exclude)

# with multiple outcomes
fit_multi <- lfe::felm(v1 + v2 ~ v3, df)
fit_Y2 <- lfe::felm(v1 ~ v3, df)

form <- v2 ~ v4
fit_form <- lfe::felm(form, df) # part of a regression test

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
  td5 <- tidy(fit, se = "robust")
  td6 <- tidy(fit2, se = "robust")
  td7 <- tidy(fit2, se = "robust", fe = TRUE)
  td8 <- tidy(fit3)
  td9 <- tidy(fit3, se = "iid")

  td_multi <- tidy(fit_multi)
  td_multi_CI <- tidy(fit_multi, conf.int = TRUE)

  check_tidy_output(td1)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td4)
  check_tidy_output(td5)
  check_tidy_output(td6)
  check_tidy_output(td7)
  check_tidy_output(td8)
  check_tidy_output(td9)
  check_tidy_output(td_multi)
  check_tidy_output(td_multi_CI)

  check_dims(td1, 2, 5)
  check_dims(td_multi_CI, 4, 8)

  expect_equal(
    tidy(fit_multi)[3:4, -1],
    tidy(fit)
  )
  expect_equal(
    tidy(fit_multi, conf.int = TRUE)[3:4, -1],
    tidy(fit, conf.int = TRUE)
  )
  expect_equal(
    tidy(fit_multi, conf.int = TRUE)[1:2, -1],
    tidy(fit_Y2, conf.int = TRUE)
  )

  expect_equal(
    dplyr::pull(td5, std.error),
    as.numeric(lfe:::summary.felm(fit, robust = TRUE)$coef[, "Robust s.e"])
  )
  expect_equal(
    dplyr::pull(td6, std.error),
    as.numeric(lfe:::summary.felm(fit2, robust = TRUE)$coef[, "Robust s.e"])
  )
  expect_equal(
    dplyr::pull(td8, std.error),
    as.numeric(lfe:::summary.felm(fit3)$coef[, "Cluster s.e."])
  )
  expect_equal(
    dplyr::pull(td9, std.error),
    as.numeric(lfe:::summary.felm(fit3, robust = FALSE)$coef[, "Std. Error"])
  )

  # check for deprecation warning from 0.7.0.9001
  expect_snapshot(.res <- tidy(fit, robust = TRUE))
})

test_that("glance.felm", {
  gl <- glance(fit)
  gl2 <- glance(fit2)

  check_glance_outputs(gl, gl2)
  check_dims(gl, expected_cols = 8)

  expect_snapshot(error = TRUE, glance(fit_multi))
})

test_that("augment.felm", {
  suppressWarnings(
    check_augment_function(
      aug = augment.felm,
      model = fit,
      data = df
    )
  )

  suppressWarnings(
    check_augment_function(
      aug = augment.felm,
      model = fit2,
      data = df
    )
  )

  suppressWarnings(
    check_augment_function(
      aug = augment.felm,
      model = fit_form,
      data = df
    )
  )

  expect_snapshot(error = TRUE, augment(fit_multi))

  # Ensure that the .resid and .fitted columns are basic columns, not matrix
  aug <- augment(fit)
  expect_false(inherits(aug$.resid, "matrix"))
  expect_false(inherits(aug$.fitted, "matrix"))
  expect_null(c(colnames(aug$.resid), colnames(aug$.fitted)))
})

test_that("tidy.felm errors informatively", {
  fit <- lfe::felm(v2 ~ v3, df)

  expect_snapshot(
    .res <- tidy.felm(fit, se.type = "cluster")
  )
})
