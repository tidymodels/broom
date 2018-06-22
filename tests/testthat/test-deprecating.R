context("deprecating")

skip("deprecating soon")

### DPLYR DO BASED WORKFLOW

library(dplyr)

# set up the lahman batting table, and filter to make it faster

data("Batting", package = "Lahman")
batting <- Batting %>% filter(yearID > 1980)

lm0 <- purrr::possibly(lm, NULL, quiet = TRUE)

test_that("can perform regressions with tidying in dplyr", {
  regressions <- batting %>% group_by(yearID) %>% do(tidy(lm0(SB ~ CS, data = .)))
  
  expect_lt(30, nrow(regressions))
  expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                    colnames(regressions)))
})

test_that("tidying methods work with rowwise_df", {
  regressions <- batting %>% group_by(yearID) %>% do(mod = lm0(SB ~ CS, data = .))
  tidied <- regressions %>% tidy(mod)
  augmented <- regressions %>% augment(mod)
  glanced <- regressions %>% glance(mod)
  
  num_years <- length(unique(batting$yearID))
  expect_equal(nrow(tidied), num_years * 2)
  expect_equal(nrow(augmented), sum(!is.na(batting$SB) & !is.na(batting$CS)))
  expect_equal(nrow(glanced), num_years)
})


test_that("can perform correlations with tidying in dplyr", {
  cor.test0 <- purrr::possibly(cor.test, NULL)
  pcors <- batting %>% group_by(yearID) %>% do(tidy(cor.test0(.$SB, .$CS)))
  expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                    colnames(pcors)))
  expect_lt(30, nrow(pcors))
  
  scors <- suppressWarnings(batting %>%
                              group_by(yearID) %>%
                              do(tidy(cor.test0(.$SB, .$CS, method = "spearman"))))
  expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                    colnames(scors)))
  expect_lt(30, nrow(scors))
  expect_false(all(pcors$estimate == scors$estimate))
})


### BOOTSTRAP TIDIERS

test_that("bootstrap works with by_group and grouped tbl", {
  df <- data_frame(
    x = c(rep("a", 3), rep("b", 5)),
    y = rnorm(length(x))
  )
  df_reps <-
    df %>%
    group_by(x) %>%
    bootstrap(20, by_group = TRUE) %>%
    do(tally(group_by(., x)))
  expect_true(all(filter(df_reps, x == "a")$n == 3))
  expect_true(all(filter(df_reps, x == "b")$n == 5))
})

test_that("bootstrap does not sample within groups if by_group = FALSE", {
  set.seed(12334)
  df <- data_frame(
    x = c(rep("a", 3), rep("b", 5)),
    y = rnorm(length(x))
  )
  df_reps <-
    df %>%
    group_by(x) %>%
    bootstrap(20, by_group = FALSE) %>%
    do(tally(group_by(., x)))
  expect_true(!all(filter(df_reps, x == "a")$n == 3))
  expect_true(!all(filter(df_reps, x == "b")$n == 5))
})

test_that("bootstrap does not sample within groups if no groups", {
  set.seed(12334)
  df <- data_frame(
    x = c(rep("a", 3), rep("b", 5)),
    y = rnorm(length(x))
  )
  df_reps <-
    df %>%
    ungroup() %>%
    bootstrap(20, by_group = TRUE) %>%
    do(tally(group_by(., x)))
  expect_true(!all(filter(df_reps, x == "a")$n == 3))
  expect_true(!all(filter(df_reps, x == "b")$n == 5))
})

### ROWWISE DATAFRAME TIDIERS

context("rowwise tidiers")

mods <- mtcars %>%
  group_by(cyl) %>%
  do(mod = lm(mpg ~ wt + qsec, .))

test_that("rowwise tidiers can be applied to sub-models", {
  expect_is(mods, "rowwise_df")
  
  tidied <- mods %>% tidy(mod)
  augmented <- mods %>% augment(mod)
  glanced <- mods %>% glance(mod)
  
  expect_equal(nrow(augmented), nrow(mtcars))
  expect_equal(nrow(glanced), 3)
  expect_true(!("disp" %in% colnames(augmented)))
})

test_that("rowwise tidiers can be given additional arguments", {
  augmented <- mods %>% augment(mod, newdata = head(mtcars, 5))
  expect_equal(nrow(augmented), 3 * 5)
})

test_that("rowwise augment can use a column as the data", {
  mods <- mtcars %>%
    group_by(cyl) %>%
    do(mod = lm(mpg ~ wt + qsec, .), data = (.))
  
  expect_is(mods, "rowwise_df")
  augmented <- mods %>% augment(mod, data = data)
  # order has changed, but original columns should be there
  expect_true(!is.null(augmented$disp))
  expect_equal(sort(mtcars$disp), sort(augmented$disp))
  expect_equal(sort(mtcars$drat), sort(augmented$drat))
  
  expect_true(!is.null(augmented$.fitted))
  
  # column name doesn't have to be data
  mods <- mtcars %>%
    group_by(cyl) %>%
    do(mod = lm(mpg ~ wt + qsec, .), original = (.))
  augmented <- mods %>% augment(mod, data = original)
  expect_true(!is.null(augmented$disp))
  expect_equal(sort(mtcars$disp), sort(augmented$disp))
})

test_that("rowwise tidiers work even when an ungrouped data frame was used", {
  one_row <- mtcars %>% do(model = lm(mpg ~ wt, .))
  
  tidied <- one_row %>% tidy(model)
  expect_equal(nrow(tidied), 2)
  
  augmented <- one_row %>% augment(model)
  expect_equal(nrow(augmented), nrow(mtcars))
  
  glanced <- one_row %>% glance(model)
  expect_equal(nrow(glanced), 1)
})

### DATAFRAME TIDIERS

context("data.frame tidiers")

test_that("tidy.data.frame works", {
  tidy_df <- tidy(mtcars)
  check_tidy(tidy_df, exp.row = 11, exp.col = 13)
  expect_false("var" %in% names(tidy_df))
  expect_equal(names(tidy_df)[1], "column")
})

test_that("augment.data.frame throws an error", {
  expect_error(augment(mtcars))
})

test_that("glance.data.frame works", {
  glance_df <- glance(mtcars)
  check_tidy(glance_df, exp.row = 1, exp.col = 4)
})

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

context("matrix tidiers")

test_that("matrix tidiers work", {
  mat <- as.matrix(mtcars)
  
  td <- tidy(mat)
  check_tidy(td, exp.row = 32, exp.col = 12)
  
  gl <- glance(mat)
  check_tidy(gl, exp.col = 4)
})

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

context("vector tidiers")

test_that("tidying numeric vectors works", {
  skip("deprecating soon")
  vec <- 1:10
  tidy_vec <- tidy(vec)
  check_tidy(tidy_vec, exp.row = 10, exp.col = 1)
  # test with names
  vec2 <- vec
  names(vec2) <- LETTERS[1:10]
  tidy_vec2 <- tidy(vec2)
  check_tidy(tidy_vec2, exp.row = 10, exp.col = 2)
  expect_true(all(c("names", "x") %in% names(tidy_vec2)))
})

test_that("tidying logical vectors works", {
  skip("deprecating soon")
  vec <- rep(c(TRUE, FALSE), 5)
  tidy_vec <- tidy(vec)
  check_tidy(tidy_vec, exp.row = 10, exp.col = 1)
  # test with names
  vec2 <- vec
  names(vec2) <- 1:10
  tidy_vec2 <- tidy(vec2)
  check_tidy(tidy_vec2, exp.row = 10, exp.col = 2)
  expect_true(all(c("names", "x") %in% names(tidy_vec2)))
})

test_that("tidying character vectors works", {
  skip("deprecating soon")
  vec <- LETTERS[1:10]
  tidy_vec <- tidy(vec)
  check_tidy(tidy_vec, exp.row = 10, exp.col = 1)
  # test with names
  vec2 <- vec
  names(vec2) <- 1:10
  tidy_vec2 <- tidy(vec2)
  check_tidy(tidy_vec2, exp.row = 10, exp.col = 2)
  expect_true(all(c("names", "x") %in% names(tidy_vec2)))
})


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


if (require(Matrix)) {
  m <- Matrix(0 + 1:28, nrow = 4)
  m[-3, c(2, 4:5, 7)] <- m[3, 1:4] <- m[1:3, 6] <- 0
  rownames(m) <- letters[1:4]
  colnames(m) <- 1:7
  mT <- as(m, "dgTMatrix")
  mC <- as(m, "dgCMatrix")
  mS <- as(m, "sparseMatrix")
  
  test_that("tidy.dgTMatrix works", {
    td <- tidy(mT)
    check_tidy(td, exp.row = 9, exp.col = 3)
  })
  
  test_that("tidy.dgCMatrix uses tidy.dgTMatrix", {
    expect_identical(tidy(mC), tidy.dgTMatrix(mC))
  })
}


