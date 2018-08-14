context("deprecating")

skip("deprecating soon")

skip_if_not_installed("modeltests")
library(modeltests)

# test tidy, augment, glance methods from lme4-tidiers.R

if (require(lme4, quietly = TRUE)) {
  context("lme4 models")
  
  d <- as.data.frame(ChickWeight)
  colnames(d) <- c("y", "x", "subj", "tx")
  fit <- lmer(y ~ tx * x + (x | subj), data = d)
  
  test_that("tidy works on lme4 fits", {
    td <- tidy(fit)
    check_tidy(td, exp.row = 12, exp.col = 5)
  })
  
  test_that("scales works", {
    t1 <- tidy(fit, effects = "ran_pars")
    t2 <- tidy(fit, effects = "ran_pars", scales = "sdcor")
    expect_equal(t1$estimate, t2$estimate)
    expect_error(
      tidy(fit, effects = "ran_pars", scales = "varcov"),
      "unrecognized ran_pars scale"
    )
    t3 <- tidy(fit, effects = "ran_pars", scales = "vcov")
    expect_equal(
      t3$estimate[c(1, 2, 4)],
      t2$estimate[c(1, 2, 4)]^2
    )
    expect_error(
      tidy(fit, scales = "vcov"),
      "must be provided for each effect"
    )
  })
  
  test_that("tidy works with more than one RE grouping variable", {
    dd <- expand.grid(
      f = factor(1:10),
      g = factor(1:5),
      rep = 1:3
    )
    dd$y <- suppressMessages(
      lme4:::simulate.formula(
        ~ (1 | f) + (1 | g),
        newdata = dd,
        newparams = list(beta = 1, theta = c(1, 1)),
        family = poisson,
        seed = 101
      )
    )[[1]]
    gfit <- glmer(y ~ (1 | f) + (1 | g), data = dd, family = poisson)
    expect_equal(
      as.character(tidy(gfit, effects = "ran_pars")$term),
      paste("sd_(Intercept)", c("f", "g"), sep = ".")
    )
  })
  
  test_that("tidy works for different effects and conf ints", {
    lmm1 <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
    td <- tidy(lmm1, effects = "ran_modes", conf.int = TRUE)
    check_tidy(td, exp.col = 7)
    
    td <- tidy(lmm1, effects = "fixed", conf.int = TRUE)
    check_tidy(td, exp.col = 6)
  })
  
  test_that("augment works on lme4 fits with or without data", {
    au <- augment(fit)
    aud <- augment(fit, d)
    expect_equal(dim(au), dim(aud))
  })
  
  dNAs <- d
  dNAs$y[c(1, 3, 5)] <- NA
  
  test_that("augment works on lme4 fits with NAs", {
    fitNAs <- lmer(y ~ tx * x + (x | subj), data = dNAs)
    au <- augment(fitNAs)
    expect_equal(nrow(au), sum(complete.cases(dNAs)))
  })
  
  test_that("augment works on lme4 fits with na.exclude", {
    fitNAs <- lmer(y ~ tx * x + (x | subj), data = dNAs, na.action = "na.exclude")
    
    # expect_error(suppressWarnings(augment(fitNAs)))
    au <- augment(fitNAs, dNAs)
    
    # with na.exclude, should have NAs in the output where there were NAs in input
    expect_equal(nrow(au), nrow(dNAs))
    expect_equal(complete.cases(au), complete.cases(dNAs))
  })
  
  test_that("glance works on lme4 fits", {
    g <- glance(fit)
    check_tidy(g, exp.col = 6)
  })
}

context("mcmc tidiers")

infile <- system.file("extdata", "rstan_example.rda", package = "broom")
load(infile)

test_that("tidy.stanfit works", {
  td <- tidy(rstan_example, conf.int = TRUE, rhat = TRUE, ess = TRUE)
  check_tidy(td, exp.row = 18, exp.col = 7)
})

# test tidy, augment, glance methods from nlme-tidiers.R

if (suppressPackageStartupMessages(require(nlme, quietly = TRUE))) {
  skip("Skipping nlme tidying tests")
  context("nlme models")
  
  d <- as.data.frame(ChickWeight)
  colnames(d) <- c("y", "x", "subj", "tx")
  fit <- lme(y ~ tx * x, random = ~ x | subj, data = d)
  
  test_that("tidy works on nlme/lme fits", {
    td <- tidy(fit)
    check_tidy(td, exp.col = 4)
  })
  
  test_that("augment works on lme4 fits with or without data", {
    au <- augment(fit)
    aud <- augment(fit, d)
    expect_equal(dim(au), dim(aud))
  })
  dNAs <- d
  dNAs$y[c(1, 3, 5)] <- NA
  
  test_that("augment works on lme fits with NAs and na.omit", {
    fitNAs <- lme(y ~ tx * x,
                  random = ~ x | subj, data = dNAs,
                  na.action = "na.omit"
    )
    au <- augment(fitNAs)
    expect_equal(nrow(au), sum(complete.cases(dNAs)))
  })
  
  
  test_that("augment works on lme fits with na.omit", {
    fitNAs <- lme(y ~ tx * x,
                  random = ~ x | subj, data = dNAs,
                  na.action = "na.exclude"
    )
    
    au <- augment(fitNAs, dNAs)
    
    # with na.exclude, should have NAs in the output where there were NAs in input
    expect_equal(nrow(au), nrow(dNAs))
    expect_equal(complete.cases(au), complete.cases(dNAs))
  })
  
  test_that("glance works on nlme fits", {
    g <- suppressWarnings(glance(fit))
    check_tidy(g, exp.col = 5)
  })
  
  
  testFit <- function(fit, data = NULL) {
    test_that("Pinheiro/Bates fit works", {
      tidy(fit, "fixed")
      tidy(fit)
      g <- suppressWarnings(glance(fit))
      check_tidy(g, exp.col = 5)
      if (is.null(data)) {
        au <- augment(fit)
        check_tidiness(au)
      } else {
        au <- augment(fit, data)
        check_tidiness(au)
      }
    })
  }
  
  testFit(lme(score ~ Machine, data = Machines, random = ~ 1 | Worker))
  testFit(lme(score ~ Machine, data = Machines, random = ~ 1 | Worker))
  testFit(lme(score ~ Machine, data = Machines, random = ~ 1 | Worker / Machine))
  testFit(lme(pixel ~ day + day^2, data = Pixel, random = list(Dog = ~ day, Side = ~ 1)))
  testFit(lme(pixel ~ day + day^2 + Side,
              data = Pixel,
              random = list(Dog = ~ day, Side = ~ 1)
  ))
  
  testFit(lme(yield ~ ordered(nitro) * Variety,
              data = Oats,
              random = ~ 1 / Block / Variety
  ))
  # There are cases where no data set is returned in the result
  # We can do nothing about this inconsitency but give a useful error message in augment
  fit <- nlme(conc ~ SSfol(Dose, Time, lKe, lKa, lCl),
              data = Theoph,
              random = pdDiag(lKe + lKa + lCl ~ 1)
  )
  # Fit without data in returned structure works when data are given
  testFit(fit, Theoph)
  
  # When no data are passed, a meaningful message is issued
  expect_error(augment(fit), "explicit")
}

# test tidy and glance methods from rstanarm_tidiers.R

context("rstanarm tidiers")
skip_if_not_installed("rstanarm")

if (require(rstanarm, quietly = TRUE)) {
  set.seed(2016)
  capture.output(
    fit <- stan_glmer(mpg ~ wt + (1 | cyl) + (1 + wt | gear),
                      data = mtcars,
                      iter = 200, chains = 2
    )
  )
  
  context("rstanarm models")
  test_that("tidy works on rstanarm fits", {
    td1 <- tidy(fit)
    td2 <- tidy(fit, parameters = "varying")
    td3 <- tidy(fit, parameters = "hierarchical")
    td4 <- tidy(fit, parameters = "auxiliary")
    expect_equal(colnames(td1), c("term", "estimate", "std.error"))
  })
  
  test_that("tidy with multiple 'parameters' selections works on rstanarm fits", {
    td1 <- tidy(fit, parameters = c("varying", "auxiliary"))
    expect_true(all(c("sigma", "mean_PPD") %in% td1$term))
    expect_equal(colnames(td1), c("term", "estimate", "std.error", "level", "group"))
  })
  
  test_that("intervals works on rstanarm fits", {
    td1 <- tidy(fit, intervals = TRUE, prob = 0.8)
    td2 <- tidy(fit, parameters = "varying", intervals = TRUE, prob = 0.5)
    nms <- c("level", "group", "term", "estimate", "std.error", "lower", "upper")
    expect_equal(colnames(td2), nms)
  })
  
  test_that("glance works on rstanarm fits", {
    g1 <- glance(fit)
    g2 <- suppressWarnings(glance(fit, looic = TRUE, cores = 1))
    expect_equal(colnames(g1), c("algorithm", "pss", "nobs", "sigma"))
    expect_equal(colnames(g2), c(colnames(g1), "looic", "elpd_loo", "p_loo"))
  })
}

test_that("tidy.table", {
  tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))
  td <- tidy(tab)
  check_tidy_output(td)
  check_dims(td, 20, 3)
})


test_that("tidy.summary", {
  
  df <- tibble(
    group = c(rep("M", 6), "F", "F", "M", "M", "F", "F"),
    val = c(6, 5, NA, NA, 6, 13, NA, 8, 10, 7, 14, 6)
  )
  
  summ <- summary(df$val)
  td <- tidy(summ)
  
  expected <- tibble(
    minimum = 5,
    q1 = 6,
    median = 7,
    mean = mean(df$val, na.rm = TRUE),
    q3 = 10,
    maximum = 14,
    na = 3
  )
  
  expect_equivalent(td, expected)
  
  td <- tidy(summary(df$val))
  
  gl <- glance(summary(df$val))
  expect_identical(td, gl)
})


test_that("tidy.ftable", {
  ftab <- ftable(Titanic, row.vars = 1:3)
  td <- tidy(ftab)
  
  check_arguments(tidy.ftable)
  check_tidy_output(td)
  check_dims(td, 32, 5)
})




