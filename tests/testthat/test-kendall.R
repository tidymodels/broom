context("kendall")

skip_if_not_installed("Kendall")
library(Kendall)

a <- c(2.5, 2.5, 2.5, 2.5, 5, 6.5, 6.5, 10, 10, 10, 10, 10, 14, 14, 14, 16, 17)
b <- c(1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2)

kfit <- Kendall(a, b)
mkfit <- MannKendall(a)
smkfit <- SeasonalMannKendall(ts(b))


test_that("tidy.Kendall", {
  
  check_arguments(tidy.Kendall)
  
  ktd <- tidy(kfit)
  mktd <- tidy(mkfit)
  smkfit <- tidy(smkfit)
  
  check_tidy_output(ktd)
  check_tidy_output(mktd)
  check_tidy_output(smkfit)
})
