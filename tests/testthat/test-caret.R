context("caret tidiers")

test_that("tidy works for a 2 class confusion matrix", {
  skip_if_not_installed("caret")
  set.seed(28)

  cm2 <- caret::confusionMatrix(factor(rbinom(100, 1, .5)), factor(rbinom(100, 1, .5)))
  td <- tidy(cm2)
  check_tidy(td, exp.row = 13, exp.col = 6)
})

test_that("tidy works for a 2 class confusion matrix with show_class = FALSE", {
  skip_if_not_installed("caret")
  set.seed(28)

  cm2 <- caret::confusionMatrix(factor(rbinom(100, 1, .5)), factor(rbinom(100, 1, .5)))
  td <- tidy(cm2, by_class = FALSE)
  check_tidy(td, exp.row = 2, exp.col = 5)
})

test_that("tidy works for > 2 class confusion matrix", {
  skip_if_not_installed("caret")
  set.seed(28)

  cm2 <- caret::confusionMatrix(factor(rbinom(100, 3, .5)), factor(rbinom(100, 3, .5)))
  td <- tidy(cm2)
  check_tidy(td, exp.row = 46, exp.col = 6)
})

test_that("tidy works for > 2 class confusion matrix with show_class = FALSE", {
  skip_if_not_installed("caret")
  set.seed(28)

  cm2 <- caret::confusionMatrix(factor(rbinom(100, 3, .5)), factor(rbinom(100, 3, .5)))
  td <- tidy(cm2, by_class = FALSE)
  check_tidy(td, exp.row = 2, exp.col = 5)
})
