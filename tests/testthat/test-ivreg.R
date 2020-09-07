context("aer")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("AER")
library(AER)
library(dplyr)
library(modeltests)

data("CigarettesSW")
df <- CigarettesSW %>%
  mutate(
    rprice = price / cpi,
    rincome = income / population / cpi,
    tdiff = (taxs - tax) / cpi
  )

fit <- ivreg(
  log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff + I(tax / cpi),
  data = df, subset = year == "1995"
)

ivfit1 <- ivreg(mpg ~ hp | qsec + am, data = mtcars)
ivfit2 <- ivreg(mpg ~ cyl + wt | qsec + am, data = mtcars)

test_that("ivreg tidier arguments", {
  check_arguments(tidy.ivreg)
  check_arguments(glance.ivreg)
  check_arguments(augment.ivreg, strict = FALSE)
})

test_that("tidy.ivreg", {
  td <- tidy(fit)
  td2 <- tidy(fit, conf.int = TRUE)

  tdiv1 <- tidy(ivfit1, instruments = FALSE)
  tdiv1_fstat <- tidy(ivfit1, instruments = TRUE)
  tdiv2 <- tidy(ivfit2, instruments = FALSE)
  tdiv2_fstat <- tidy(ivfit2, instruments = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(tdiv1)
  check_tidy_output(tdiv1_fstat)
  check_tidy_output(tdiv2)
  check_tidy_output(tdiv2_fstat)
})

test_that("glance.ivreg", {
  gl <- glance(fit)
  gl2 <- glance(fit, diagnostics = TRUE)

  check_glance_outputs(gl) # separately because diagnostics = TRUE adds cols
  check_glance_outputs(gl2)
})

test_that("augment.ivreg", {
  check_augment_function(
    aug = augment.ivreg,
    model = fit,
    data = df,
    newdata = df,
    strict = FALSE
  )

  au <- augment(fit)
  expect_true(all(c(".resid", ".fitted") %in% names(au)))
})
