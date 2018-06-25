context("stats-augment")

test_that("augment.decomposed.ts", {
  check_arguments(augment.decomposed.ts)
  
  d1a <- stats::decompose(nottem, type = "additive")
  d1b <- stats::decompose(nottem, type = "multiplicative")
  d2 <- stats::stl(nottem, s.window = "periodic", robust = TRUE)
  
  a1a <- augment(d1a)
  a1b <- augment(d1b)
  a2 <- augment(d2)
  
  # TODO: think about data types and what broom guarantees
  
  check_tibble(a1a, method = "augment")
  check_tibble(a1b, method = "augment")
  check_tibble(a2, method = "augment")
  
  check_dims(a1a, 240, 4)
  check_dims(a1b, 240, 4)
  check_dims(a2, 240, 5)
})


test_that("augment.htest (chi squared test)", {
  check_arguments(augment.htest)
  
  df <- as.data.frame(Titanic)
  tab <- xtabs(Freq ~ Sex + Class, data = df)
  
  chit <- chisq.test(tab) # 2D table
  au <- augment(chit)
  check_tibble(au, method = "augment")
  
  chit2 <- chisq.test(c(A = 20, B = 15, C = 25)) # 1D table
  au2 <- augment(chit2)
  check_tibble(au2, method = "augment")

  tt <- t.test(rnorm(10))
  expect_error(
    augment(tt),
    regexp = "Augment is only defined for chi squared hypothesis tests."
  )
  
  wt <- wilcox.test(mpg ~ am, data = mtcars, conf.int = TRUE, exact = FALSE)
  expect_error(
    augment(wt), 
    regexp = "Augment is only defined for chi squared hypothesis tests."
  )
  
  ct <- cor.test(mtcars$wt, mtcars$mpg)
  expect_error(
    augment(ct),
    regexp = "Augment is only defined for chi squared hypothesis tests."
  )
})

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

