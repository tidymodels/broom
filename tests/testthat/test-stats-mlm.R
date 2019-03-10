context("stats-mlm")

fit_mlm <- lm(cbind(mpg, disp) ~ wt, mtcars)
df_tidy <- tidy(fit_mlm, conf.int = TRUE)

test_that("tidy.mlm works", {
  testthat::expect_equal(dim(df_tidy), c(4L, 8L))
  testthat::expect_is(df_tidy, "tbl_df")
})
