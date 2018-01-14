# test tidy, glance methods for mjoint object

if (requireNamespace("joineRML")) {
  context("mjoint models")
  data(heart.valve, package = "joineRML")

  hvd <- heart.valve[!is.na(heart.valve$log.grad) & !is.na(heart.valve$log.lvmi) & heart.valve$num <= 50, ]

  fit1 <- suppressMessages(joineRML::mjoint(
    formLongFixed = log.grad ~ time + sex + hs,
    formLongRandom = ~ 1 | num,
    formSurv = Surv(fuyrs, status) ~ age,
    data = hvd,
    timeVar = "time"
  ))

  fit2 <- suppressMessages(joineRML::mjoint(
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
    inits = list("gamma" = c(0.11, 1.51, 0.80)),
    timeVar = "time"
  ))

  bSE1 <- suppressMessages(joineRML::bootSE(fit1, nboot = 5, safe.boot = TRUE))

  bSE2 <- suppressMessages(joineRML::bootSE(fit2, nboot = 5, safe.boot = TRUE))

  test_that("tidy works on mjoint models with a single longitudinal process", {
    tidy(fit1)
  })

  test_that("tidy works on mjoint models with more than one longitudinal process", {
    tidy(fit2)
  })

  test_that("tidy works asking for survival part", {
    tidy(fit1, component = "survival")
    tidy(fit2, component = "survival")
  })

  test_that("tidy works asking for longitudinal part", {
    tidy(fit1, component = "longitudinal")
    tidy(fit2, component = "longitudinal")
  })

  test_that("tidy works with bootstrapped standard errors", {
    tidy(fit1, component = "survival", bootSE = bSE1)
    tidy(fit2, component = "survival", bootSE = bSE2)
    tidy(fit1, component = "longitudinal", bootSE = bSE1)
    tidy(fit2, component = "longitudinal", bootSE = bSE2)
  })

  test_that("augment works on mjoint models with a single longitudinal process", {
    augment(fit1)
  })

  test_that("augment works on mjoint models with more than one longitudinal process", {
    augment(fit2)
  })

  test_that("augment returns the same output whether we pass 'data' or not", {
    expect_equal(object = augment(fit1), expected = augment(fit1, data = hvd))
    expect_equal(object = augment(fit2), expected = augment(fit2, data = hvd))
  })

  test_that("glance works on mjoint models with a single longitudinal process", {
    glance(fit1)
  })

  test_that("glance works on mjoint models with more than one longitudinal process", {
    glance(fit2)
  })
}
