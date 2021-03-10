context("fixest")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("fixest")
fixest::setFixest_nthreads(1) # avoid warnings about requesting more threads

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
  td3 <- tidy(fit2, conf.int = TRUE, se = "hetero")
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
  check_dims(gl, expected_cols = 9)
})

test_that("augment.fixest", {

  check_augment_function(
    aug = augment.fixest,
    model = fit,
    data = df,
    newdata = df,
    strict = FALSE
  )

  check_augment_function(
    aug = augment.fixest,
    model = fit2,
    data = df,
    newdata = df,
    strict = FALSE
  )

  check_augment_function(
    aug = augment.fixest,
    model = fit_form,
    data = df,
    newdata = df,
    strict = FALSE
  )
})

test_that("all other fixest estimators run", {
  form <- v2 ~ v4 | id
  res_feglm    <- fixest::feglm(form,    data = df)
  res_fenegbin <- fixest::fenegbin(form, data = df)
  res_feNmlm   <- fixest::feNmlm(form,   data = df)
  res_femlm    <- fixest::femlm(form,    data = df)
  res_fepois   <- fixest::fepois(form,   data = df)

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
  # Note this this causes warnings with strict=TRUE because
  # modeltests:::acceptable_augment_colnames calls model.frame, which doesn't
  # work for fixest models.
  check_augment_function(
    aug = augment.fixest,
    model = res_feglm,
    data = df,
    newdata = df,
    strict = FALSE
  )
  check_augment_function(
    aug = augment.fixest,
    model = res_femlm,
    data = df,
    newdata = df,
    strict = FALSE
  )

  augment_error <- "augment is only supported for fixest models estimated with feols, feglm, or femlm"
  expect_error(augment(res_fenegbin, df), augment_error)
  expect_error(augment(res_feNmlm, df), augment_error)
  expect_error(augment(res_fepois, df), augment_error)
})


test_that("tidiers work with model results or summary of model results", {
  # Default standard errors are clustered by `id`. Test against non-default
  # independent, heteroskedastic ("hetero") standard errors.
  fit2_summ <- summary(fit2, se = "hetero")
  expect_equal(tidy(fit2, se = "hetero"), tidy(fit2_summ))
  expect_equal(
    tidy(fit2, se = "hetero", conf.int = TRUE),
    tidy(fit2_summ, conf.int = TRUE)
  )
  expect_equal(glance(fit2, se = "hetero"), glance(fit2_summ))
  expect_equal(augment(fit2, df, se = "hetero"), augment(fit2_summ, df))

  # Repeat for feglm
  res_glm <- fixest::feglm(v2 ~ v4 | id, data = df)
  res_glm_summ <- summary(fixest::feglm(v2 ~ v4 | id, data = df), se = "hetero")
  expect_equal(tidy(res_glm, se = "hetero"), tidy(res_glm_summ))
  expect_equal(
    as.data.frame(tidy(res_glm, se = "hetero", conf.int = TRUE)),
    as.data.frame(tidy(res_glm_summ, conf.int = TRUE))
  )
  expect_equal(glance(res_glm, se = "hetero"), glance(res_glm_summ))
  expect_equal(augment(res_glm, df, se = "hetero"), augment(res_glm_summ, df))

  # We rely on behavior from fixest where summary.fixest() doesn't change the
  # `se` or `dof` arguments if they've already been set.
  # Test that claim here. (Calling summary again does change other things, like
  # the `summary_from_fit` flag, so we can't just expect_equal the whole object)
  expect_false(is.null(fit2_summ$coeftable))
  expect_equal(fit2_summ$coeftable, summary(fit2_summ)$coeftable)
  expect_equal(summary(fit)$coeftable, summary(summary(fit))$coeftable)
})
