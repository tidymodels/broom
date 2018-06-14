context("metafor tidiers")

test_that("tidy.rma works", {
  skip_if_not_installed("metafor")
  library(metafor)

  dat <- escalc(measure = "RR", ai = tpos, bi = tneg, ci = cpos, di = cneg, data = dat.bcg)
  ### random-effects model (method="REML" is default, so technically not needed)
  fit <- rma(yi, vi, data = dat, method = "REML")

  out <- structure(list(
    b = -0.714532348365101, se = 0.179781531780361,
    zval = -3.97444799412457, pval = 7.05426734852063e-05, ci.lb = -1.06689767574005,
    ci.ub = -0.362167020990149
  ), .Names = c(
    "b", "se", "zval",
    "pval", "ci.lb", "ci.ub"
  ), row.names = "intrcpt", class = "data.frame")

  # dput(tidy(fit))
  expect_equal(tidy(fit), out)

  check_tidy(tidy(fit), exp.row = 1)
})

test_that("glance.rma works", {
  skip_if_not_installed("metafor")
  library(metafor)

  dat <- escalc(measure = "RR", ai = tpos, bi = tneg, ci = cpos, di = cneg, data = dat.bcg)
  ### random-effects model (method="REML" is default, so technically not needed)
  fit <- rma(yi, vi, data = dat, method = "REML")

  out <- structure(list(
    tau2 = 0.313243325980895, se.tau2 = 0.166427570950497,
    k = 13L, p = 1L, m = 1L, QE = 152.233008082373, QEp = 1.99676459084592e-26,
    QM = 15.7962368580009, QMp = 7.05426734852063e-05, I2 = 92.2213860749656,
    H2 = 12.8557608031121, int.only = TRUE
  ), .Names = c(
    "tau2",
    "se.tau2", "k", "p", "m", "QE", "QEp", "QM", "QMp", "I2", "H2",
    "int.only"
  ), row.names = c(NA, -1L), class = "data.frame")
  # dput(glance(fit))
  expect_equal(glance(fit), out)

  check_tidy(glance(fit), exp.row = 1)
})
