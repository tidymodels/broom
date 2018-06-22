context("caret")

skip_if_not_installed("caret")

test_that("tidy.confusionMatrix", {
  check_arguments(tidy.confusionMatrix)
  
  set.seed(28)
  
  two_class_sample1 <- factor(rbinom(100, 1, .5))
  two_class_sample2 <- factor(rbinom(100, 1, .5))
  
  multi_class_sample1 <- factor(rbinom(100, 4, .5))
  multi_class_sample2 <- factor(rbinom(100, 4, .5))
  
  two_class_cm <- caret::confusionMatrix(
    two_class_sample1,
    two_class_sample2
  )
  
  multi_class_cm <- caret::confusionMatrix(
    multi_class_sample1,
    multi_class_sample2
  )
  
  td_2c_by_class <- tidy(two_class_cm)
  td_2c <- tidy(two_class_cm, by_class = FALSE)
  
  check_tidy_output(td_2c_by_class)
  check_tidy_output(td_2c)
  
  td_mc_by_class <- tidy(multi_class_cm)
  td_mc <- tidy(multi_class_cm, by_class = FALSE)
  
  check_tidy_output(td_mc_by_class)
  check_tidy_output(td_mc)
})
