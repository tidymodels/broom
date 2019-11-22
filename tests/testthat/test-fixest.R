context("fixest")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("fixest")

set.seed(27)
n <- 100
df <- data.frame(
  id = sample(5, n, TRUE),
  v1 = sample(5, n, TRUE),
  v2 = sample(1e6, n, TRUE),
  v3 = sample(round(runif(100, max = 100), 4), n, TRUE),
  v4 = sample(round(runif(100, max = 100), 4), n, TRUE)
)

fit <- fixest::feols(v2 ~ v3, df)
fit2 <- fixest::feols(v2 ~ v3 | id + v1, df)

form <- v2 ~ v4
fit_form <- fixest::feols(form, df)  # part of a regression test

test_that("fixest tidier arguments", {
  check_arguments(tidy.fixest)
  check_arguments(glance.fixest)
  check_arguments(augment.fixest)
})

test_that("tidy.fixest", {
  td <- tidy(fit)
  td2 <- tidy(fit2, conf.int = TRUE)
  td3 <- tidy(fit2, conf.int = TRUE, se="white")
  td4 <- tidy(fit_form)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td3)
  check_tidy_output(td4)

  check_dims(td, 2, 5)
})

test_that("glance.fixest", {
  gl <- glance(fit)
  gl2 <- glance(fit2)

  check_glance_outputs(gl, gl2)
  check_dims(gl, expected_cols = 8)
})

test_that("augment.fixest", {

  check_augment_function(
    aug = augment.fixest,
    model = fit,
    data = df,
    newdata = df
  )

  check_augment_function(
    aug = augment.fixest,
    model = fit2,
    data = df,
    newdata = df
  )

  check_augment_function(
    aug = augment.fixest,
    model = fit_form,
    data = df,
    newdata = df
  )
})

test_that("all other fixest estimators run", {
  form <- v2 ~ v4 | v1^id
  res_feglm    <- fixest::feglm(form,    data=df)
  res_fenegbin <- fixest::fenegbin(form, data=df)
  res_feNmlm   <- fixest::feNmlm(form,   data=df)
  res_femlm    <- fixest::femlm(form,    data=df)
  res_fepois   <- fixest::fepois(form,   data=df)

  # Tidy
  check_tidy_output(tidy(res_feglm))
  check_tidy_output(tidy(res_fenegbin))
  check_tidy_output(tidy(res_feNmlm))
  check_tidy_output(tidy(res_femlm))
  check_tidy_output(tidy(res_fepois))

  # Glance
  check_glance_outputs(
    glance(res_feglm),
    glance(res_fenegbin),
    glance(res_feNmlm),
    glance(res_femlm),
    glance(res_fepois)
  )

  # Augment
  check_augment_function(aug = augment.fixest, model = res_feglm,    data = df, newdata = df)
  check_augment_function(aug = augment.fixest, model = res_fenegbin, data = df, newdata = df)
  check_augment_function(aug = augment.fixest, model = res_feNmlm,   data = df, newdata = df)
  check_augment_function(aug = augment.fixest, model = res_femlm,    data = df, newdata = df)
  check_augment_function(aug = augment.fixest, model = res_fepois,   data = df, newdata = df)
})
