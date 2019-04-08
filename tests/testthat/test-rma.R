context("rma")

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
res.RE <- rma(yi, vi, data = dat, method = "EB")


test_that(("returns tibble for RR"), {
  check_tidy_output(tidy(res.RE))
  # check_augment_outputs(glance(res.RE)
  check_glance_outputs(glance(res.RE))
})


# mixed effects ----------------------------------------------------------
res.ME <-
  rma(
    yi,
    vi,
    mods = ~ I(ablat - 33.46),
    data = dat,
    method = "EB"
  )

test_that(("returns tibble for ME"), {
  check_tidy_output(tidy(res.ME))
  # check_augment_outputs(glance(res.ME))
  check_glance_outputs(glance(res.ME))
})


# fixed effects ----------------------------------------------------------
res.FE <-
  rma(
    yi,
    vi,
    mods = ~ I(ablat - 33.46),
    data = dat,
    method = "FE"
  )

test_that(("returns tibble for FE"), {
  check_tidy_output(tidy(res.FE))
  # check_augment_outputs(glance(res.FE))
  check_glance_outputs(glance(res.FE))
})


# Weighted Regression Analysis ---------------------------------------------

dat2 <- data.frame(
  id = c(100, 308, 1596, 2479, 9021, 9028, 161, 172, 537, 7049),
  yi = c(-0.33, 0.32, 0.39, 0.31, 0.17, 0.64, -0.33, 0.15, -0.02, 0.00),
  vi = c(0.084, 0.035, 0.017, 0.034, 0.072, 0.117, 0.102, 0.093, 0.012, 0.067),
  random = c(0, 0, 0, 0, 0, 0, 1, 1, 1, 1),
  intensity = c(7, 3, 7, 5, 7, 7, 4, 4, 5, 6)
)

res.WFE <- rma(yi, vi, mods = ~random + intensity, data = dat2, method = "FE")

test_that(("returns tibble for weighted FE"), {
  check_tidy_output(tidy(res.WFE))
  # check_augment_outputs(glance(res.WFE))
  check_glance_outputs(glance(res.WFE))
})


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

test_that(("returns tibble for MV"), {
  check_tidy_output(tidy(res.MV))
  # check_augment_outputs(glance(res.MV))
  check_glance_outputs(glance(res.MV))
})


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

test_that(("returns tibble for GLMM"), {
  check_tidy_output(tidy(res.GLMM))
  # check_augment_outputs(glance(res.GLMM))
  check_glance_outputs(glance(res.GLMM))
})


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

test_that(("returns tibble for peto"), {
  check_tidy_output(tidy(res.peto))
  # check_augment_outputs(glance(res.peto))
  check_glance_outputs(glance(res.peto))
})

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

test_that(("returns tibble for MH"), {
  check_tidy_output(tidy(res.MH))
  # check_augment_outputs(glance(res.MH))
  check_glance_outputs(glance(res.MH))
})

