context("rma")

skip_on_cran()

# Matrix ABI version may differ (#1204)
skip_if(paste0(R.Version()[c("major", "minor")], collapse = ".") < "4.4.0")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("metafor")
library(metafor)

skip_if_not_installed("lme4")
library(lme4)

# check arguments ---------------------------------------------------------

test_that("metafor::rma tidier arguments", {
  check_arguments(tidy.rma)
  check_arguments(glance.rma)
  # not checking strictly for `augment.rma()` because
  # it does not need or use a `data` argument
  check_arguments(augment.rma, strict = FALSE)
})


# set up metafor testing models -------------------------------------------
# RR test -----------------------------------------------------------------
# from the metafor homepage
dat <-
  escalc(
    measure = "RR",
    ai = tpos,
    bi = tneg,
    ci = cpos,
    di = cneg,
    data = dat.bcg
  )

# random effects ----------------------------------------------------------
res.RE <- rma(yi, vi, data = dat, method = "EB", level = 95)

# mixed effects ----------------------------------------------------------
res.ME <-
  rma(
    yi,
    vi,
    mods = ~ I(ablat - 33.46),
    data = dat,
    method = "EB"
  )

# fixed effects ----------------------------------------------------------
res.FE <-
  rma(
    yi,
    vi,
    mods = ~ I(ablat - 33.46),
    data = dat,
    method = "FE"
  )

# Weighted Regression Analysis ---------------------------------------------
dat2 <- data.frame(
  id = c(100, 308, 1596, 2479, 9021, 9028, 161, 172, 537, 7049),
  yi = c(-0.33, 0.32, 0.39, 0.31, 0.17, 0.64, -0.33, 0.15, -0.02, 0.00),
  vi = c(0.084, 0.035, 0.017, 0.034, 0.072, 0.117, 0.102, 0.093, 0.012, 0.067),
  random = c(0, 0, 0, 0, 0, 0, 1, 1, 1, 1),
  intensity = c(7, 3, 7, 5, 7, 7, 4, 4, 5, 6)
)

res.WFE <- rma(yi, vi, mods = ~ random + intensity, data = dat2, method = "FE")

# multivariate models -----------------------------------------------------
dat.long <-
  to.long(
    measure = "OR",
    ai = tpos,
    bi = tneg,
    ci = cpos,
    di = cneg,
    data = dat.colditz1994
  )
dat.long <-
  escalc(
    measure = "PLO",
    xi = out1,
    mi = out2,
    data = dat.long
  )
dat.long$tpos <-
  dat.long$tneg <- dat.long$cpos <- dat.long$cneg <- NULL
levels(dat.long$group) <- c("EXP", "CON")
dat.long$group <- relevel(dat.long$group, ref = "CON")

res.MV <-
  rma.mv(
    yi,
    vi,
    mods = ~ group - 1,
    random = ~ group |
      trial,
    struct = "UN",
    data = dat.long,
    method = "ML"
  )

# GLMM --------------------------------------------------------------------
res.GLMM <-
  suppressWarnings(
    rma.glmm(
      measure = "PLO",
      xi = ci,
      ni = n2i,
      data = dat.nielweise2007
    )
  )

# Peto method -------------------------------------------------------------
dat.yusuf1985$grp_ratios <-
  round(dat.yusuf1985$n1i / dat.yusuf1985$n2i, 2)

suppressWarnings(
  res.peto <- rma.peto(
    ai = ai,
    n1i = n1i,
    ci = ci,
    n2i = n2i,
    data = dat.yusuf1985,
    subset = (table == "6")
  )
)

# Mantel-Haenszel Method for the Risk Difference --------------------------
dat <- data.frame(
  age = c("Age <55", "Age 55+"),
  ai = c(8, 22),
  bi = c(98, 76),
  ci = c(5, 16),
  di = c(115, 69)
)

res.MH <-
  rma.mh(
    ai = ai,
    bi = bi,
    ci = ci,
    di = di,
    data = dat,
    measure = "RD",
    digits = 3,
    level = 90
  )

check_augment_rma_output <- function(x) {
  modeltests::check_tibble(x, "augment")
}

# test rma tidiers output -------------------------------------------------

test_that(("tidy.rma"), {
  # Use this object for multiple tests
  re.tidy <- tidy(res.RE, conf.int = TRUE, conf.level = 0.95)

  check_tidy_output(re.tidy)
  check_tidy_output(tidy(res.ME))
  check_tidy_output(tidy(res.FE))
  check_tidy_output(tidy(res.WFE))
  check_tidy_output(tidy(res.MV))
  check_tidy_output(tidy(res.GLMM))
  check_tidy_output(tidy(res.peto))
  check_tidy_output(tidy(res.MH))

  # Check that confidence levels vary if requested
  abs_diff_conf_level <- function(res, conf.level) {
    res.tidy <- tidy(res.RE, conf.int = TRUE, conf.level = conf.level)
    return(abs(res.tidy$conf.high - res.tidy$conf.low))
  }

  expect_true(all(
    # Smaller confidence levels have smaller absolute differences
    abs_diff_conf_level(res.RE, 0.90) < abs_diff_conf_level(res.RE, 0.95),
    abs_diff_conf_level(res.RE, 0.95) < abs_diff_conf_level(res.RE, 0.99)
  ))

  # Check that confidence levels match rma object when level is equivalent
  expect_equal(re.tidy$conf.low, res.RE$ci.lb, tolerance = 0.001)
  expect_equal(re.tidy$conf.high, res.RE$ci.ub, tolerance = 0.001)
})

test_that(("glance.rma"), {
  # save this one for other test
  re.glance <- glance(res.RE)

  check_glance_outputs(re.glance)
  check_glance_outputs(glance(res.ME))
  check_glance_outputs(glance(res.FE))
  check_glance_outputs(glance(res.WFE))
  check_glance_outputs(glance(res.MV))
  check_glance_outputs(glance(res.GLMM))
  check_glance_outputs(glance(res.peto))
  check_glance_outputs(glance(res.MH))

  # check that fit statistics are not being dropped
  fit.stats <- c("logLik", "deviance", "AIC", "BIC", "AICc")
  expect_true(all(fit.stats %in% names(re.glance)))
})

test_that(("augment.rma"), {
  check_augment_rma_output(augment(res.RE))
  check_augment_rma_output(augment(res.ME))
  check_augment_rma_output(augment(res.FE))
  check_augment_rma_output(augment(res.WFE))
  check_augment_rma_output(augment(res.MV))
  check_augment_rma_output(augment(res.GLMM))
  check_augment_rma_output(augment(res.peto))
  check_augment_rma_output(augment(res.MH))
})
