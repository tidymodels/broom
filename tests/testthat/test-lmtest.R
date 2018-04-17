context("lmtest tidiers")

library(lmtest)

test_that("tidy.coeftest works", {
    data(Mandible)
    fm <- lm(length ~ age, data = Mandible, subset = (age <= 28))
    ct <- coeftest(fm)
    td <- tidy(ct)
    check_tidy(td, exp.row = 2, exp.col = 5)
})
