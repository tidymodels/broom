# some models take a long time to fit. instead of waiting for these models to
# fit each time tests are run, we fit them once here and save the results
# to `tests/testthat/fixtures/mjoint_fits.rda`.
#
# the fixtures live under tests/ rather than R/sysdata.rda so that they aren't
# subject to R CMD check's "namespace references in data files" check (the
# fitted objects embed nlme classes via $lfit, which would otherwise require
# adding nlme to Imports).

library(joineRML)
library(survival)
library(dplyr)

hvd <- heart.valve |>
  filter(!is.na(log.grad), !is.na(log.lvmi), num <= 50)

mjoint_fit <- mjoint(
  formLongFixed = list("grad" = log.grad ~ time + sex + hs),
  formLongRandom = list("grad" = ~ 1 | num),
  formSurv = survival::Surv(fuyrs, status) ~ age,
  data = hvd,
  inits = list(
    "gamma" = c(0.1, 2.7),
    "beta" = c(2.5, 0.0, 0.1, 0.2)
  ),
  timeVar = "time"
)

mjoint_fit2 <- mjoint(
  formLongFixed = list(
    "grad" = log.grad ~ time + sex + hs,
    "lvmi" = log.lvmi ~ time + sex
  ),
  formLongRandom = list(
    "grad" = ~ 1 | num,
    "lvmi" = ~ time | num
  ),
  formSurv = Surv(fuyrs, status) ~ age,
  data = hvd,
  inits = list(
    "gamma" = c(0.11, 1.51, 0.80),
    "beta" = c(2.52, 0.01, 0.03, 0.08, 4.99, 0.03, -0.20)
  ),
  timeVar = "time"
)

mjoint_fit_bs_se <- bootSE(mjoint_fit, nboot = 5, safe.boot = TRUE)
mjoint_fit2_bs_se <- bootSE(mjoint_fit2, nboot = 5, safe.boot = TRUE)

save(
  mjoint_fit,
  mjoint_fit2,
  mjoint_fit_bs_se,
  mjoint_fit2_bs_se,
  file = "tests/testthat/fixtures/mjoint_fits.rda",
  compress = "xz"
)
