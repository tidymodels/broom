context("plm tidiers")

skip_if_not_installed("plm")
library(plm)

data(Produc, package = "plm")
fit <- plm(
  log(gsp) ~ log(pcap) + log(pc) + log(emp) + unemp,
  data = Produc,
  index = c("state", "year")
)

test_that("plm tidier arguments", {
  check_arguments(tidy.plm)
  check_arguments(glance.plm)
  check_arguments(augment.plm)
})

test_that("tidy.plm", {
  td <- tidy(fit, conf.int = TRUE)
  tdq <- tidy(fit, conf.int = TRUE, quick = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(tdq)
  check_dims(td, 4, 7)
})

test_that("glance.plm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 6)
})

test_that("augment.plm", {
  
  check_augment_function(
    aug = augment.plm,
    model = fit,
    data = Produc,
    newdata = Produc
  )
})

