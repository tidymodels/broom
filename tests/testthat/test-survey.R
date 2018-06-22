context("survey")

skip_if_not_installed("survey")
skip_if_not_installed("MASS")

data("housing", package = "MASS")
design <- survey::svydesign(ids = ~ 1, weights = ~ Freq, data = housing)
fit <- survey::svyolr(Sat ~ Infl + Type + Cont, design = design)

test_that("survey tidier arguments", {
  check_arguments(tidy.svyolr)
  check_arguments(glance.svyolr)
})

test_that("tidy.svyolr", {
  td <- tidy(fit, quick = TRUE)
  td2 <- tidy(fit, conf.int = TRUE, exponentiate = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(td2)
})

test_that("glance.svyolr", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, 1, 3)
})
