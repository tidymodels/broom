context("multcomp tidiers")

library(multcomp)

amod <- aov(breaks ~ wool + tension, data = warpbreaks)
wht <- glht(amod, linfct = mcp(tension = "Tukey"))

test_that("tidy.glht works", {
    td <- tidy(wht)
    check_tidy(td, exp.row = 3, exp.col = 3)
})

test_that("tidy.confint.glht works", {
    CI <- confint(wht)
    td <- tidy(CI)
    check_tidy(td, exp.row = 3, exp.col = 5)
})

test_that("tidy.summary.glht works", {
    ss <- summary(wht)
    td <- tidy(ss)
    check_tidy(td, exp.row = 3, exp.col = 6)    
})

test_that("tidy.clt works", {
    cld <- cld(wht)
    td <- tidy(cld)
    check_tidy(td, exp.row = 3, exp.col = 2)
})
