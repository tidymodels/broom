context("tests for deprecated tidiers")

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

