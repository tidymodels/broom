context("survey")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("survey")
library(survey)

skip_if_not_installed("MASS")

data("housing", package = "MASS")
design <- svydesign(ids = ~ 1, weights = ~ Freq, data = housing)
fit <- svyolr(Sat ~ Infl + Type + Cont, design = design)

test_that("survey tidier arguments", {
  check_arguments(tidy.svyolr)
  check_arguments(glance.svyolr)
})

test_that("tidy.svyolr", {
  td2 <- tidy(fit, conf.int = TRUE, exponentiate = TRUE)
  check_tidy_output(td2)
})

test_that("glance.svyolr", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 3)
})

test_that("conf.int merging regression test (#804)", {
  
  data(api)
  
  dstrat <- svydesign(
    id = ~1,
    strata = ~stype,
    weights = ~pw,
    data = apistrat,
    fpc = ~fpc
  )
  
  mod <- svyglm(
    formula = sch.wide ~ ell + meals + mobility,
    design = dstrat,
    family = quasibinomial()
  )
  
  expect_error(
    tidy(mod, conf.int = TRUE),
    NA
  )
})
