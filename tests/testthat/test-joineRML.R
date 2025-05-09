skip_on_cran()

# Matrix ABI version may differ (#1204)
skip_if_not_r_version("4.4.0")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("joineRML")
suppressPackageStartupMessages(library(joineRML))

# NOTE: the models used in these tests are created in
# `data-raw/fit_and_save_long_running_models.R`, and then are saved to
# `R/sysdata.rda`

hvd <- heart.valve |>
  dplyr::filter(!is.na(log.grad), !is.na(log.lvmi), num <= 50)

test_that("mjoint tidier arguments", {
  check_arguments(tidy.mjoint)
  check_arguments(glance.mjoint)
  check_arguments(augment.mjoint)
})

test_that("tidy.mjoint", {
  td <- tidy(mjoint_fit)
  tds <- tidy(mjoint_fit, component = "survival")
  tdl <- tidy(mjoint_fit, component = "longitudinal")

  tdsbs <- tidy(
    mjoint_fit,
    component = "survival",
    boot_se = mjoint_fit_bs_se
  )

  tdlbs <- tidy(
    mjoint_fit,
    component = "longitudinal",
    boot_se = mjoint_fit_bs_se
  )

  check_tidy_output(td)
  check_tidy_output(tds)
  check_tidy_output(tdl)
  check_tidy_output(tdsbs)
  check_tidy_output(tdlbs)

  td2 <- tidy(mjoint_fit2)
  td2s <- tidy(mjoint_fit2, component = "survival")
  td2l <- tidy(mjoint_fit2, component = "longitudinal")

  td2sbs <- tidy(
    mjoint_fit2,
    component = "survival",
    boot_se = mjoint_fit2_bs_se,
    conf.int = TRUE
  )

  td2lbs <- tidy(
    mjoint_fit2,
    component = "longitudinal",
    boot_se = mjoint_fit2_bs_se,
    conf.int = TRUE
  )

  check_tidy_output(td2)
  check_tidy_output(td2s)
  check_tidy_output(td2l)
  check_tidy_output(td2sbs)
  check_tidy_output(td2lbs)

  expect_snapshot(error = TRUE, tidy(mjoint_fit, boot_se = "cat"))
})


test_that("glance.mjoint", {
  gl <- glance(mjoint_fit)
  gl2 <- glance(mjoint_fit2)

  check_glance_outputs(gl, strict = FALSE)
  check_glance_outputs(gl2, strict = FALSE)
})


test_that("augment.mjoint", {
  au <- augment(mjoint_fit)
  au2 <- augment(mjoint_fit2)

  expect_snapshot(error = TRUE, augment(mjoint_fit, data = NULL))

  check_tibble(au, method = "augment", strict = FALSE)
  check_tibble(au, method = "augment", strict = FALSE)
})
