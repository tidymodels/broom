skip_if_not_installed("modeltests")
library(modeltests)

test_that("ellipsis checking works", {
  expect_snapshot(
    check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE)
  )
  
  expect_snapshot(
    check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE, quick = FALSE)
  )
  
  expect_silent(check_ellipses("exponentiate", "tidy", "boop", hi = "pal"))
})

test_that("ellipsis checking works (whole game, tidy)", {
  mod <- nls(mpg ~ k * e^wt, data = mtcars, start = list(k = 1, e = 2))

  expect_snapshot(tidy(mod, exponentiate = TRUE))
})

test_that("ellipsis checking works (whole game, augment)", {
  mod <- kmeans(mtcars, centers = 4)

  expect_snapshot(
    .res <- augment(mod, data = mtcars, newdata = mtcars)
  )
})

test_that("augment_newdata can handle function calls in response term (lm)", {
  mt_lm <- lm(data = mtcars, mpg ~ hp)
  mt_lm_log <- lm(data = mtcars, log(mpg) ~ hp)

  aug_mt_lm_none <- augment(mt_lm)
  aug_mt_lm_data <- augment(mt_lm, data = mtcars)
  aug_mt_lm_newdata <- augment(mt_lm, newdata = mtcars[1:20, ])
  aug_mt_lm_no_resp <- augment(mt_lm, newdata = mtcars[1:20, 2:ncol(mtcars)])

  aug_mt_lm_log_none <- augment(mt_lm_log)
  aug_mt_lm_log_data <- augment(mt_lm_log, data = mtcars)
  aug_mt_lm_log_newdata <- augment(mt_lm_log, newdata = mtcars[1:20, ])
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
  expect_equal(aug_mt_lm_log_newdata$.resid, log(mtcars$mpg[1:20]) - unname(predict(mt_lm_log, mtcars[1:20, ])))
})

test_that("augment_newdata can handle function calls in response term (glm)", {
  mt_glm <- glm(data = mtcars, mpg ~ .)
  mt_glm_log <- glm(data = mtcars, log(mpg) ~ .)

  aug_mt_glm_none <- augment(mt_glm)
  aug_mt_glm_data <- augment(mt_glm, data = mtcars)
  aug_mt_glm_newdata <- augment(mt_glm, newdata = mtcars[1:20, ])
  aug_mt_glm_no_resp <- augment(mt_glm, newdata = mtcars[1:20, 2:ncol(mtcars)])

  aug_mt_glm_log_none <- augment(mt_glm_log)
  aug_mt_glm_log_data <- augment(mt_glm_log, data = mtcars)
  aug_mt_glm_log_newdata <- augment(mt_glm_log, newdata = mtcars[1:20, ])
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
  aug_mt_loess_newdata <- augment(mt_loess, newdata = mtcars[1:20, ])
  aug_mt_loess_no_resp <- augment(mt_loess, newdata = mtcars[1:20, 2:ncol(mtcars)])

  aug_mt_loess_log_none <- augment(mt_loess_log)
  aug_mt_loess_log_data <- augment(mt_loess_log, data = mtcars)
  aug_mt_loess_log_newdata <- augment(mt_loess_log, newdata = mtcars[1:20, ])
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
  expect_equal(aug_mt_loess_log_newdata$.resid, log(mtcars$mpg[1:20]) - unname(predict(mt_loess_log, mtcars[1:20, ])))
})

test_that("as_glance_tibble", {
  df1 <- as_glance_tibble(x = 1, y = 1, na_types = "rr")
  df2 <- as_glance_tibble(x = 1, y = NULL, na_types = "rc")
  df3 <- as_glance_tibble(x = 1, y = NULL, na_types = "rr")

  expect_equal(
    purrr::map(df1, class),
    purrr::map(df3, class)
  )

  expect_true(class(df1$y) == class(df3$y))

  expect_false(class(df1$y) == class(df2$y))

  expect_snapshot(error = TRUE, as_glance_tibble(x = 1, y = 1, na_types = "rrr"))
})

test_that("appropriate warning on (g)lm-subclassed models", {
  x <- 1
  class(x) <- c("boop", "glm")

  expect_snapshot(warn_on_subclass(x, "tidy"))
  
  # only displayed once per session, per unique dispatch
  expect_silent(warn_on_subclass(x, "tidy"))

  class(x) <- c("bop", "glm", "lm")

  expect_snapshot(warn_on_subclass(x, "tidy"))
  
  # only displayed once per session, per unique dispatch
  expect_silent(
    warn_on_subclass(x, "tidy")
  )
})

test_that("as_augment_tibble errors informatively", {
  m <- matrix(1:4, ncol = 2)
  expect_snapshot(error = TRUE, as_augment_tibble(m))
})
