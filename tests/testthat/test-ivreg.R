context("AER::ivreg tidiers")

skip_if_not_installed("AER")
library(AER)
library(dplyr)

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

test_that("ivreg tidier arguments", {
  check_arguments(tidy.ivreg)
  check_arguments(glance.ivreg)
  check_arguments(augment.ivreg)
})

test_that("tidy.ivreg", {
  td <- tidy(fit)
  td2 <- tidy(fit, conf.int = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(td2)
})

test_that("glance.ivreg", {
  gl <- glance(fit)
  gl2 <- glance(fit, diagnostics = TRUE)
  
  check_glance_outputs(gl)  # separately because diagnostics = TRUE adds cols
  check_glance_outputs(gl2)
})

test_that("augment.ivreg", {
  
  check_augment_function(
    aug = augment.ivreg,
    model = fit,
    data = df,
    newdata = df
  )
  
  # TODO: figure out how on earth to test augment methods
  
  au <- augment(fit)
  expect_true(all(c(".resid", ".fitted") %in% names(au)))
  
  au2 <- augment(fit, newdata = filter(df, year == "1985"))
  expect_true(".fitted" %in% names(au2))
})

