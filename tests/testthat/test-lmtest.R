context("lmtest")

skip_if_not_installed("lmtest")
library(lmtest)

fit <- lm(length ~ age, data = Mandible, subset = (age <= 28))
ct <- lmtest::coeftest(fit)

test_that("tidy.coeftest", {
  
  check_arguments(tidy.coeftest)
  
  td <- tidy(ct)
  check_tidy_output(td)
  check_dims(td, 2, 5)
})
