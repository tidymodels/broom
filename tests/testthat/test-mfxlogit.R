context("mfxlogit")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("mfx")
library(mfx)

set.seed(12345)
n = 1000
x = rnorm(n)
y = ifelse(pnorm(1 + 0.5*x + rnorm(n))>0.5, 1, 0)
df = data.frame(y,x)
fit1 <- logitmfx(formula=y~x, data=df)
fit2 <- logitmfx(formula=y~x, atmean=T, data=df)
fit3 <- logitmfx(formula=y~x, atmean=F, data=df)

test_that("mfx::logitmfx tidier arguments", {
  check_arguments(tidy.logitmfx)
  check_arguments(glance.logitmfx)
  check_arguments(augment.logitmfx)
})

test_that("tidy.logitmfx", {
  td1 <- tidy(fit1, conf.int = TRUE)
  check_tidy_output(td1)
  check_dims(td1, 1, 8)
  td2 <- tidy(fit2, conf.int = TRUE)
  check_tidy_output(td2)
  check_dims(td2, 1, 8)
  td3 <- tidy(fit3, conf.int = TRUE)
  check_tidy_output(td3)
  check_dims(td3, 1, 8)
})

test_that("glance.logitmfx", {
  gl1 <- glance(fit1)
  check_glance_outputs(gl1)
  check_dims(gl1, expected_cols = 7)
  gl2 <- glance(fit2)
  check_glance_outputs(gl2)
  check_dims(gl2, expected_cols = 7)
  gl3 <- glance(fit3)
  check_glance_outputs(gl3)
  check_dims(gl3, expected_cols = 7)
})

test_that("augment.logitmfx", {
  check_augment_function(
    aug = augment.logitmfx,
    model = fit1,
    data = df,
    newdata = df
  )
  check_augment_function(
    aug = augment.logitmfx,
    model = fit2,
    data = df,
    newdata = df
  )
  check_augment_function(
    aug = augment.logitmfx,
    model = fit3,
    data = df,
    newdata = df
  )
})
