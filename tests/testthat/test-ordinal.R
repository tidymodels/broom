context("tidiers for ordinal models")

test_that("tidiers work for clm objects (ordinal)", {
  data(wine, package = "ordinal")
  mod <- ordinal::clm(rating ~ temp * contact, data = wine)
  td <- tidy(mod, quick = TRUE)
  check_tidy(td, exp.row = 7, exp.col = 3)
  td <- tidy(mod, conf.int = TRUE, exponentiate = TRUE)
  check_tidy(td, exp.row = 7, exp.col = 8)

  gl <- glance(mod)
  check_tidy(gl, exp.col = 5)

  ag <- augment(mod, data = wine)
  check_tidy(ag, exp.row = nrow(wine), exp.col = ncol(wine) + 2)
})

test_that("tidiers work for clmm objects (ordinal)", {
  data(wine, package = "ordinal")
  mod <- ordinal::clmm(rating ~ temp + contact + (1 | judge), data = wine)
  td <- tidy(mod, quick = TRUE)
  check_tidy(td, exp.row = 6, exp.col = 3)
  td <- tidy(mod, conf.int = TRUE, exponentiate = TRUE)
  check_tidy(td, exp.row = 6, exp.col = 8)

  gl <- glance(mod)
  check_tidy(gl, exp.col = 4)
})

test_that("tidiers work for polr objects (MASS)", {
  data("housing", package = "MASS")
  mod <- MASS::polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
  td <- tidy(mod, quick = TRUE)
  check_tidy(td, exp.col = 3)
  td <- tidy(mod, conf.int = TRUE, exponentiate = TRUE)
  check_tidy(td, exp.col = 7)

  gl <- glance(mod)
  check_tidy(gl, exp.col = 6)

  ag <- augment(mod, newdata = housing)
  check_tidy(ag)
})

test_that("tidiers work for svyolr objects (survey)", {
  data("housing", package = "MASS")
  design <- survey::svydesign(ids = ~ 1, weights = ~ Freq, data = housing)
  mod <- survey::svyolr(Sat ~ Infl + Type + Cont, design = design)
  td <- tidy(mod, quick = TRUE)
  check_tidy(td, exp.row = 8, exp.col = 3)
  td <- tidy(mod, conf.int = TRUE, exponentiate = TRUE)
  check_tidy(td, exp.row = 8, exp.col = 7)

  gl <- glance(mod)
  check_tidy(gl, exp.col = 3)
})
