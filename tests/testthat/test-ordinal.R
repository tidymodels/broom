context("ordinal")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("ordinal")
library(ordinal)

fit <- clm(rating ~ temp * contact, data = wine)

fit_sc <- clm(rating ~ temp + contact,
  scale = ~ temp + contact,
  data = wine
)

mfit <- clmm(rating ~ temp + contact + (1 | judge), data = wine)

test_that("ordinal tidier arguments", {
  check_arguments(tidy.clm)
  check_arguments(glance.clm)
  check_arguments(augment.clm, strict = FALSE)

  check_arguments(tidy.clmm)
  check_arguments(glance.clmm)
})

test_that("tidy.clm", {
  td <- tidy(fit)
  td2 <- tidy(fit, conf.int = TRUE, exponentiate = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)

  check_dims(td, 7, 6)
  check_dims(td2, 7, 8)

  expect_equal(
    object = td$term,
    expected = td2$term,
    label = "'term' column in tidy output with `conf.int = FALSE`",
    expected.label = "'term' column in tidy output with `conf.int = TRUE`",
    info = "The terms (and their order) should be unaffected by whether `conf.int` = TRUE or `conf.int` = FALSE."
  )
})

test_that("tidy.clm works with scale parameter", {
  tt <- tidy(fit_sc)
  expect_equal(
    tt$coef.type,
    rep(c("intercept", "location", "scale"), c(4, 2, 2))
  )
})

test_that("glance.clm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 6)
})

test_that("augment.clm", {
  check_augment_function(
    aug = augment.clm,
    model = fit,
    data = wine,
    newdata = wine,
    strict = FALSE
  )

  au_c <- augment(fit, type.predict = "class")
  expect_equal(predict(fit, type = "class")$fit, au_c$.fitted)

  au_p <- augment(fit, type.predict = "prob")
  expect_equal(predict(fit, type = "prob")$fit, au_p$.fitted)
})


test_that("tidy.clmm", {
  td <- tidy(mfit)
  td2 <- tidy(mfit, conf.int = TRUE, exponentiate = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)

  check_dims(td, 6, 6)
  check_dims(td2, 6, 8)
})

test_that("glance.clmm", {
  gl <- glance(mfit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 5)
})
