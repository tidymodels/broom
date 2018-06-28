context("list-svd")

mat <- scale(as.matrix(USJudgeRatings))
s <- svd(mat)
p <- prcomp(mat)

test_that("tidy_svd", {
  
  check_arguments(tidy_svd)
  
  tdu <- tidy(s, matrix = "u")
  tdd <- tidy(s, matrix = "d")
  tdv <- tidy(s, matrix = "v")
  
  check_tidy_output(tdu)
  check_tidy_output(tdd)
  check_tidy_output(tdv)
  
  check_dims(tdu, 516, 3)
  check_dims(tdd, 12, 4)
  check_dims(tdv, 144, 3)
})
