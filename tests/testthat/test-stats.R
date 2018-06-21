context("stats tidiers")

test_that("tidy.aovlist", {
  check_arguments("tidy.aovlist")
  
  aovlist <- aov(mpg ~ wt + disp + Error(drat), mtcars)
  aovlist2 <- aov(mpg ~ wt + qsec + Error(cyl / (wt * qsec)), data = mtcars)
  
  td <- tidy(aovlist)
  td2 <- tidy(aovlist2)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  
  check_dims(td, 4, 7)
  check_dims(td2, 7, 7)
  
  expect_true("Residuals" %in% td$term)
  expect_true("Residuals" %in% td2$term)
  expect_true(length(unique(td2$stratum)) == 5)
})


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
  check_tidy(td, exp.row = 8, exp.col = 7)
})

test_that("tidy.ts works", {
  ts1 <- ts(1:10, frequency = 4, start = c(1959, 2))
  td <- tidy(ts1)
  check_tidy(td, exp.row = 10, exp.col = 2)
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




context("htest augment")

test_that("augment.htest works on chi squared tests", {
  # 2 dimensions table
  chit <- chisq.test(xtabs(Freq ~ Sex + Class, data = as.data.frame(Titanic)))
  expect_is(augment(chit), "data.frame")
  expect_true(all(
    c(".observed", ".prop", ".expected", ".residuals", ".stdres")
    %in% names(augment(chit))
  ))
  expect_true(all(c(".row.prop", ".col.prop") %in% names(augment(chit))))
  
  # 1 dimension table
  chit <- chisq.test(c(A = 20, B = 15, C = 25))
  expect_is(augment(chit), "data.frame")
  expect_true(all(
    c(".observed", ".prop", ".expected", ".residuals", ".stdres")
    %in% names(augment(chit))
  ))
  expect_true(!any(c(".row.prop", ".col.prop") %in% names(augment(chit))))
})

test_that("augment.htest not defined for other types of htest", {
  tt <- t.test(rnorm(10))
  expect_error(augment(tt))
  
  wt <- wilcox.test(mpg ~ am, data = mtcars, conf.int = TRUE, exact = FALSE)
  expect_error(augment(wt))
  
  ct <- cor.test(mtcars$wt, mtcars$mpg)
  expect_error(augment(ct))
})

context("decompose tidiers")

test_that("augment.decompose works", {
  d1a <- stats::decompose(nottem, type = "additive")
  d1b <- stats::decompose(nottem, type = "multiplicative")
  d2 <- stats::stl(nottem, s.window = "periodic", robust = TRUE)
  
  a1a <- augment(d1a)
  check_tidy(a1a, exp.row = 240, exp.col = 4)
  
  a1b <- augment(d1b)
  check_tidy(a1b, exp.row = 240, exp.col = 4)
  
  a2 <- augment(d2)
  check_tidy(a2, exp.row = 240, 5)
})


