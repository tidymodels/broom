context("stats-augment")

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

context("loess tidiers")

test_that("augment.loess", {
  
  check_arguments(augment.loess)
  fit <- loess(mpg ~ wt, mtcars)
  
  check_augment_function(
    aug = augment.loess,
    model = fit, 
    data = mtcars,
    newdata = mtcars
  )
})

