skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("mfx")
suppressPackageStartupMessages(library(mfx))

# simulate data
set.seed(12345)
n <- 1000
x <- rnorm(n)
# beta outcome
y_beta <- rbeta(n, shape1 = plogis(1 + 0.5 * x), shape2 = (abs(0.2 * x)))
y_beta <- (y_beta * (n - 1) + 0.5) / n # Smithson and Verkuilen correction
# binary outcome (logit and probit)
y_bin <- ifelse(pnorm(1 + 0.5 * x + rnorm(n)) > 0.5, 1, 0)
# negative binomial outcome (negative binomial and poisson)
y_negbin <- rnegbin(n, mu = exp(1 + 0.5 * x), theta = 0.5)
df <- data.frame(y_beta, y_bin, y_negbin, x)

# fit the different models
fit_betamfx <- betamfx(y_beta ~ x | x, data = df)
fit_logitmfx <- logitmfx(y_bin ~ x, data = df)
fit_negbinmfx <- negbinmfx(y_negbin ~ x, data = df)
fit_poissonmfx <- poissonmfx(y_negbin ~ x, data = df)
fit_probitmfx <- logitmfx(y_bin ~ x, data = df)


# Now run the tests

test_that("mfx tidier arguments", {
  # logit
  check_arguments(tidy.mfx)
  check_arguments(glance.mfx)
  check_arguments(augment.mfx)
})

test_that("tidy.mfx", {
  # beta
  td_betamfx <- tidy(fit_betamfx, conf.int = TRUE)
  check_tidy_output(td_betamfx)
  check_dims(td_betamfx, 1, 8)
  # logit
  td_logitmfx <- tidy(fit_logitmfx, conf.int = TRUE)
  check_tidy_output(td_logitmfx)
  check_dims(td_logitmfx, 1, 8)
  # negbin
  td_negbinmfx <- tidy(fit_negbinmfx, conf.int = TRUE)
  check_tidy_output(td_negbinmfx)
  check_dims(td_negbinmfx, 1, 8)
  # poisson
  td_poissonmfx <- tidy(fit_poissonmfx, conf.int = TRUE)
  check_tidy_output(td_poissonmfx)
  check_dims(td_poissonmfx, 1, 8)
  # probit
  td_probitmfx <- tidy(fit_probitmfx, conf.int = TRUE)
  check_tidy_output(td_probitmfx)
  check_dims(td_probitmfx, 1, 8)
})

test_that("glance.mfx", {
  # beta
  gl_betamfx <- glance(fit_betamfx)
  check_glance_outputs(gl_betamfx)
  # logit
  gl_logitmfx <- glance(fit_logitmfx)
  check_glance_outputs(gl_logitmfx)
  # negbin
  suppressWarnings(
    gl_negbinmfx <- glance(fit_negbinmfx)
  )
  check_glance_outputs(gl_negbinmfx)
  # poisson
  gl_poissonmfx <- glance(fit_poissonmfx)
  check_glance_outputs(gl_poissonmfx)
  # probit
  gl_probitmfx <- glance(fit_probitmfx)
  check_glance_outputs(gl_probitmfx)
})

test_that("augment.mfx", {
  # beta
  check_augment_function(
    aug = augment.betamfx,
    model = fit_betamfx,
    data = df,
    newdata = df
  )
  # logit
  check_augment_function(
    aug = augment.logitmfx,
    model = fit_logitmfx,
    data = df,
    newdata = df
  )
  # negbin
  check_augment_function(
    aug = augment.negbinmfx,
    model = fit_negbinmfx,
    data = df,
    newdata = df
  )
  # poisson
  check_augment_function(
    aug = augment.poissonmfx,
    model = fit_poissonmfx,
    data = df,
    newdata = df
  )
  # probit
  check_augment_function(
    aug = augment.probitmfx,
    model = fit_probitmfx,
    data = df,
    newdata = df
  )
})
