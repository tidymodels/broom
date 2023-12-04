skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

fit_mlm <- lm(cbind(mpg, disp) ~ wt, mtcars)
df_tidy <- tidy(fit_mlm, conf.int = TRUE)

test_that("tidy.mlm works", {
  check_dims(df_tidy, 4L, 8L)
  expect_s3_class(df_tidy, "tbl_df")
})

#' helper function: replicate each element of x
#' times times.
rep_each <- function(x, times) {
  retv <- outer(rep(1, times), x, function(x, y) y)
  dim(retv) <- c(prod(dim(retv)), 1)
  retv <- switch(class(x),
    character = as.character(retv),
    numeric = as.numeric(retv),
    integer = as.integer(retv),
    retv
  )
  retv
}

test_that("tidy.mlm works", {
  # create data
  nob <- 100
  set.seed(1234)
  datf <-
    data.frame(
      x1 = rnorm(nob),
      x2 = runif(nob),
      z1 = rnorm(nob),
      z2 = rnorm(nob)
    ) %>%
    dplyr::mutate(
      y1 = 0.5 * x1 + x2 + z1 - z2,
      y2 = -2 * x1 + 0.25 * x2 + 3 * z1 + z2
    )

  # fit two mlm objects
  fit <- lm(cbind(y1, y2) ~ x1, data = datf)
  fit2 <- lm(cbind(y1, y2) ~ x1 + x2, data = datf)

  # tidy dataframe
  td <- tidy(fit)
  td2 <- tidy(fit2)

  # hit the confidence interval code
  tdc <- tidy(fit, conf.int = TRUE)
  tdc2 <- tidy(fit2, conf.int = TRUE)

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(tdc)
  check_tidy_output(tdc2)

  check_dims(td, expected_rows = 4)
  check_dims(td2, expected_rows = 6)
  check_dims(tdc, expected_rows = 4)
  check_dims(tdc2, expected_rows = 6)

  check_dims(td, expected_cols = 6)
  check_dims(td2, expected_cols = 6)
  check_dims(tdc, expected_cols = 8)
  check_dims(tdc2, expected_cols = 8)

  expect_equal(td$term, rep(c("(Intercept)", "x1"), 2))
  expect_equal(td2$term, rep(c("(Intercept)", "x1", "x2"), 2))
  expect_equal(td$response, rep_each(c("y1", "y2"), 2))
  expect_equal(td2$response, rep_each(c("y1", "y2"), 3))
})
