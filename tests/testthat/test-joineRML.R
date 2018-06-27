context("joinerml")

# TODO: think about the tidy interface when bootstrapping standard errors
# should tidy work on two objects are once?

skip_if_not_installed("joineRML")
library(joineRML)

# NOTE: the models used in these tests are created in 
# `tests/fit_and_save_long_running_models.R`, and then are saved to
# `R/sysdata.rda`

hvd <- heart.valve %>% 
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
    bootSE = mjoint_fit_bs_se
  )
  
  tdlbs <- tidy(
    mjoint_fit,
    component = "longitudinal",
    bootSE = mjoint_fit_bs_se
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
    bootSE = mjoint_fit2_bs_se
  )
  
  td2lbs <- tidy(
    mjoint_fit2, 
    component = "longitudinal",
    bootSE = mjoint_fit2_bs_se
  )
  
  check_tidy_output(td2)
  check_tidy_output(td2s)
  check_tidy_output(td2l)
  check_tidy_output(td2sbs)
  check_tidy_output(td2lbs)
})


test_that("glance.mjoint", {
  gl <- glance(mjoint_fit)
  gl2 <- glance(mjoint_fit2)
  
  check_glance_outputs(gl)
  check_glance_outputs(gl2)
})


test_that("augment.mjoint", {
  
  # TODO: check for consistent 0 and 1 indexing in output colum names
  
  au <- augment(mjoint_fit)
  au2 <- augment(mjoint_fit2)
  
  check_tibble(au, method = "augment")
  check_tibble(au, method = "augment")
})
