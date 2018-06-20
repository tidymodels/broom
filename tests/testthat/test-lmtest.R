context("lmtest tidiers")
skip_if_not_installed("lmtest")

test_that("tidy.coeftest works", {
  library(lmtest)
  data(Mandible)
  
  fm <- lm(length ~ age, data = Mandible, subset = (age <= 28))
  ct <- lmtest::coeftest(fm)
  
  td <- tidy(ct)
  check_tidy(td, exp.row = 2, exp.col = 5)
})
