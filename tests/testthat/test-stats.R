context("stats tidiers")

test_that("tidy.table works", {
    tab <- with(airquality, table(cut(Temp, quantile(Temp)), Month))
    td <- tidy(tab)
    check_tidy(td, exp.row = 20, exp.col = 3)
})

test_that("tidy.ftable works", {
    ftab <- ftable(Titanic, row.vars = 1:3)
    td <- tidy(ftab)
    check_tidy(td, exp.row = 32, exp.col = 5)
})

test_that("tidy.density works", {
    den <- density(faithful$eruptions, bw = "sj")
    td <- tidy(den)
    check_tidy(td, exp.row = 512, exp.col = 2)
})

test_that("tidy.dist works", {
    iris_dist <- dist(t(iris[, 1:4]))
    td <- tidy(iris_dist)
    check_tidy(td, exp.row = 6, exp.col = 3)
})

test_that("tidy.specworks", {
    spc <- spectrum(lh, plot = FALSE)
    td <- tidy(spc)
    check_tidy(td, exp.row = 24, exp.col = 2)
})

test_that("tidy.TukeyHSD works", {
    fm1 <- aov(breaks ~ wool + tension, data = warpbreaks)
    thsd <- TukeyHSD(fm1, "tension", ordered = TRUE)
    td <- tidy(thsd)
    check_tidy(td, exp.row = 3, exp.col = 6)
    td <- tidy(thsd, separate.levels = TRUE)
    check_tidy(td, exp.row = 3, exp.col = 7)
})

test_that("test.manova works", {
    npk2 <- within(npk, foo <- rnorm(24))
    npk2.aov <- manova(cbind(yield, foo) ~ block + N * P * K, npk2)
    td <- tidy(npk2.aov)
    check_tidy(td, exp.row = 7, exp.col = 7)
})

test_that("tidy.ts works", {
    ts1 <- ts(1:10, frequency = 4, start = c(1959, 2))
    td <- tidy(ts1)
    check_tidy(td, exp.row = 10, exp.col = 1)
})

test_that("tidy.pairwise.htest works", {
    pht <- with(iris, pairwise.t.test(Petal.Length, Species))
    td <- tidy(pht)
    check_tidy(td, exp.row = 3, exp.col = 3)
})

test_that("tidy.power.htest works", {
    ptt <- power.t.test(n = 2:30, delta = 1)
    td <- tidy(ptt)
    check_tidy(td, exp.row = 29, exp.col = 5)
})

test_that("tidy.acf works", {
    result <- acf(lh, plot = FALSE)
    td <- tidy(result)
    check_tidy(td, exp.row = 17, exp.col = 2)
})
