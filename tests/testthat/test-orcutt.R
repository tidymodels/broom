context("orcutt tidiers")

test_that("orcutt tidiers work", {
  skip_if_not_installed("orcutt")
  reg <- lm(mpg ~ wt + qsec + disp, mtcars)
  co <- orcutt::cochrane.orcutt(reg)
  td <- tidy(co)
  check_tidy(td, exp.row = 4, exp.col = 5)

  gl <- glance(co)
  check_tidy(gl, exp.col = 8)
})
