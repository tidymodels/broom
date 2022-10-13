context("utilities")

skip_if_not_installed("modeltests")
library(modeltests)

test_that("ellipsis checking works", {
  expect_warning(
    check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE),
    "\\`exponentiate\\` argument is not supported in the \\`tidy\\(\\)\\` method for \\`boop\\` objects"
  )
  
  expect_warning(
    check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE, quick = FALSE),
    "\\`exponentiate\\` argument is not supported in the \\`tidy\\(\\)\\` method for \\`boop\\` objects"
  )
  
  expect_silent(check_ellipses("exponentiate", "tidy", "boop", hi = "pal"))
})

test_that("ellipsis checking works (whole game, tidy)", {
  mod <- nls(mpg ~ k * e^wt, data = mtcars, start = list(k = 1, e = 2))
  
  expect_warning(
    tidy(mod, exponentiate = TRUE),
    "\\`exponentiate\\` argument is not supported in the \\`tidy\\(\\)\\` method for \\`nls\\` objects"
  )
})

test_that("ellipsis checking works (whole game, augment)", {
  mod <- kmeans(mtcars, centers = 4)
  
  expect_warning(
    augment(mod, data = mtcars, newdata = mtcars),
    "\\`newdata\\` argument is not supported in the \\`augment\\(\\)\\` method for \\`kmeans\\` objects"
  )
})

test_that("augment_newdata can handle function calls in response term (lm)", {
  mt_lm <- lm(data = mtcars, mpg ~ hp)
  mt_lm_log <- lm(data = mtcars, log(mpg) ~ hp)

  aug_mt_lm_none <- augment(mt_lm)
  aug_mt_lm_data <- augment(mt_lm, data = mtcars)
  aug_mt_lm_newdata <- augment(mt_lm, newdata = mtcars[1:20,])
  aug_mt_lm_no_resp <- augment(mt_lm, newdata = mtcars[1:20, 2:ncol(mtcars)])
  
  aug_mt_lm_log_none <- augment(mt_lm_log)
  aug_mt_lm_log_data <- augment(mt_lm_log, data = mtcars)
  aug_mt_lm_log_newdata <- augment(mt_lm_log, newdata = mtcars[1:20,])
  aug_mt_lm_log_no_resp <- augment(mt_lm_log, newdata = mtcars[1:20, 2:ncol(mtcars)])
  
  expect_true(inherits(aug_mt_lm_log_none, "tbl_df"))
  expect_true(inherits(aug_mt_lm_log_data, "tbl_df"))
  expect_true(inherits(aug_mt_lm_log_newdata, "tbl_df"))
  expect_true(inherits(aug_mt_lm_log_no_resp, "tbl_df"))
  
  expect_equal(".resid" %in% colnames(aug_mt_lm_log_none), ".resid" %in% colnames(aug_mt_lm_none))
  expect_equal(".resid" %in% colnames(aug_mt_lm_log_data), ".resid" %in% colnames(aug_mt_lm_data))
  expect_equal(".resid" %in% colnames(aug_mt_lm_log_newdata), ".resid" %in% colnames(aug_mt_lm_newdata))
  expect_equal(".resid" %in% colnames(aug_mt_lm_log_no_resp), ".resid" %in% colnames(aug_mt_lm_no_resp))

  expect_equal(aug_mt_lm_log_none$.resid, log(mtcars$mpg) - unname(fitted(mt_lm_log, mtcars)))
  expect_equal(aug_mt_lm_log_data$.resid, log(mtcars$mpg) - unname(fitted(mt_lm_log, mtcars)))
  expect_equal(aug_mt_lm_log_newdata$.resid, log(mtcars$mpg[1:20]) - unname(predict(mt_lm_log, mtcars[1:20,])))
})

test_that("augment_newdata can handle function calls in response term (glm)", {
  mt_glm <- glm(data = mtcars, mpg ~ .)
  mt_glm_log <- glm(data = mtcars, log(mpg) ~ .)

  aug_mt_glm_none <- augment(mt_glm)
  aug_mt_glm_data <- augment(mt_glm, data = mtcars)
  aug_mt_glm_newdata <- augment(mt_glm, newdata = mtcars[1:20,])
  aug_mt_glm_no_resp <- augment(mt_glm, newdata = mtcars[1:20, 2:ncol(mtcars)])
    
  aug_mt_glm_log_none <- augment(mt_glm_log)
  aug_mt_glm_log_data <- augment(mt_glm_log, data = mtcars)
  aug_mt_glm_log_newdata <- augment(mt_glm_log, newdata = mtcars[1:20,])
  aug_mt_glm_log_no_resp <- augment(mt_glm_log, newdata = mtcars[1:20, 2:ncol(mtcars)])
  
  expect_true(inherits(aug_mt_glm_log_none, "tbl_df"))
  expect_true(inherits(aug_mt_glm_log_data, "tbl_df"))
  expect_true(inherits(aug_mt_glm_log_newdata, "tbl_df"))
  expect_true(inherits(aug_mt_glm_log_no_resp, "tbl_df"))
  
  expect_equal(".resid" %in% colnames(aug_mt_glm_log_none), ".resid" %in% colnames(aug_mt_glm_none))
  expect_equal(".resid" %in% colnames(aug_mt_glm_log_data), ".resid" %in% colnames(aug_mt_glm_data))
  expect_equal(".resid" %in% colnames(aug_mt_glm_log_newdata), ".resid" %in% colnames(aug_mt_glm_newdata))
  expect_equal(".resid" %in% colnames(aug_mt_glm_log_no_resp), ".resid" %in% colnames(aug_mt_glm_no_resp))
  
  expect_equal(aug_mt_glm_log_none$.resid, log(mtcars$mpg) - unname(fitted(mt_glm_log, mtcars)))
  expect_equal(aug_mt_glm_log_data$.resid, log(mtcars$mpg) - unname(fitted(mt_glm_log, mtcars)))
})

test_that("augment_newdata can handle function calls in response term (loess)", {
  mt_loess <- loess(data = mtcars, mpg ~ hp + disp)
  mt_loess_log <- loess(data = mtcars, log(mpg) ~ hp + disp)
  
  aug_mt_loess_none <- augment(mt_loess)
  aug_mt_loess_data <- augment(mt_loess, data = mtcars)
  aug_mt_loess_newdata <- augment(mt_loess, newdata = mtcars[1:20,])
  aug_mt_loess_no_resp <- augment(mt_loess, newdata = mtcars[1:20, 2:ncol(mtcars)])
  
  aug_mt_loess_log_none <- augment(mt_loess_log)
  aug_mt_loess_log_data <- augment(mt_loess_log, data = mtcars)
  aug_mt_loess_log_newdata <- augment(mt_loess_log, newdata = mtcars[1:20,])
  aug_mt_loess_log_no_resp <- augment(mt_loess_log, newdata = mtcars[1:20, 2:ncol(mtcars)])
  
  expect_true(inherits(aug_mt_loess_log_none, "tbl_df"))
  expect_true(inherits(aug_mt_loess_log_data, "tbl_df"))
  expect_true(inherits(aug_mt_loess_log_newdata, "tbl_df"))
  expect_true(inherits(aug_mt_loess_log_no_resp, "tbl_df"))
  
  expect_equal(".resid" %in% colnames(aug_mt_loess_log_none), ".resid" %in% colnames(aug_mt_loess_none))
  expect_equal(".resid" %in% colnames(aug_mt_loess_log_data), ".resid" %in% colnames(aug_mt_loess_data))
  expect_equal(".resid" %in% colnames(aug_mt_loess_log_newdata), ".resid" %in% colnames(aug_mt_loess_newdata))
  expect_equal(".resid" %in% colnames(aug_mt_loess_log_no_resp), ".resid" %in% colnames(aug_mt_loess_no_resp))
  
  expect_equal(aug_mt_loess_log_none$.resid, log(mtcars$mpg) - unname(fitted(mt_loess_log, mtcars)))
  expect_equal(aug_mt_loess_log_data$.resid, log(mtcars$mpg) - unname(fitted(mt_loess_log, mtcars)))
  expect_equal(aug_mt_loess_log_newdata$.resid, log(mtcars$mpg[1:20]) - unname(predict(mt_loess_log, mtcars[1:20,])))
})

skip("specification not yet complete")

skip_if_not_installed("betareg")
library(betareg)

test_that("validate_augment_input", {
  data(GasolineYield)

  model <- lm(hp ~ ., mtcars)
  poly_m <- lm(hp ~ poly(mpg, 2), mtcars) # augment(poly_m) works

  # augment(m3) breaks. it's possible that it wouldn't with a better
  # implementation, in which case we'd want something here
  # where it's imperative to specify either data or newdata to
  # prevent an explosion

  m3 <- betareg(yield ~ poly(temp, 2), GasolineYield)

  expect_warning(
    validate_augment_input(model, data = mtcars, newdata = mtcars),
    regexp = "Both `data` and `newdata` have been specified. Ignoring `data`."
  )

  expect_warning(
    validate_augment_input(poly_m, mtcars[, 1:3]),
    "`data` might not contain columns present in original data."
  )

  extra_rows <- bind_rows(mtcars, head(mtcars))

  expect_warning(
    validate_augment_input(model, extra_rows),
    regexp = paste(
      "`data` must contain all rows passed to the original modelling",
      "function with no extras rows."
    )
  )

  expect_message(
    validate_augment_input(m3),
    regexp = paste0(
      "Neither `data` nor `newdata` has been specified.\n",
      "Attempting to reconstruct original data."
    )
  )

  expect_error(
    validate_augment_input(m3, model.frame(m3)),
    regexp = paste0(
      "`data` is malformed: must be coercable to a tibble.\n",
      "Did you pass `data` the data originally used to fit your model?"
    )
  )

  expect_error(
    validate_augment_input(model, 1L),
    regexp = "`data` argument must be a tibble or dataframe."
  )

  expect_error(
    validate_augment_input(model, newdata = 1L),
    regexp = "`newdata` argument must be a tibble or dataframe."
  )
})


test_that("as_glance_tibble", {

  df1 <- as_glance_tibble(x = 1, y = 1, na_types = "rr")
  df2 <- as_glance_tibble(x = 1, y = NULL, na_types = "rc")
  df3 <- as_glance_tibble(x = 1, y = NULL, na_types = "rr")
  
  expect_equal(purrr::map(df1, class),
               purrr::map(df2, class))
  
  expect_true(class(df1$y) == class(df2$y))
  
  expect_false(class(df2$y) == class(df3$y))
  
  expect_error(
    as_glance_tibble(x = 1, y = 1, na_types = "rrr")
  )
  
})

test_that("appropriate warning on (g)lm-subclassed models", {
  x <- 1
  class(x) <- c("boop", "glm")
  
  expect_warning(
    warn_on_subclass(x, "tidy"),
    "class \\`boop\\`.*only supported through the \\`glm\\` tidier method."
  )
  
  # only displayed once per session, per unique dispatch
  expect_silent(
    warn_on_subclass(x, "tidy")
  )
  
  class(x) <- c("bop", "glm", "lm")
  
  expect_warning(
    warn_on_subclass(x, "tidy"),
    "class \\`bop\\`.*only supported through the `glm` tidier method."
  )
  
  # only displayed once per session, per unique dispatch
  expect_silent(
    warn_on_subclass(x, "tidy")
  )
})
