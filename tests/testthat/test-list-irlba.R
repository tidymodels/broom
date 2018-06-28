context("list-irlba")

skip_if_not_installed("irlba")

mat <- scale(as.matrix(USJudgeRatings))
s <- svd(mat)
p <- prcomp(mat)
i <- irlba::irlba(mat)

test_that("tidy_irlba", {
  
  check_arguments(tidy_irlba)
  
  tdu <- tidy(i, matrix = "u")
  check_tidy_output(tdu)
  check_dims(tdu, 215, 3)
  
  tdd <- tidy(i, matrix = "d")
  check_tidy_output(tdd)
  check_dims(tdd, 5, 4)
  
  tdv <- tidy(i, matrix = "v")
  check_tidy_output(tdv)
  check_dims(tdv, 60, 3)
})

test_that("prcomp/svd/irlba consistency", {
  expect_equal(colnames(tidy(i)), colnames(tidy(p)))
  expect_equal(colnames(tidy(i)), colnames(tidy(s)))
  expect_equal(colnames(tidy(s)), colnames(tidy(p)))
  
  expect_equal(
    colnames(tidy(i, matrix = "d")),
    colnames(tidy(p, matrix = "d"))
  )
  expect_equal(
    colnames(tidy(i, matrix = "d")),
    colnames(tidy(s, matrix = "d"))
  )
  expect_equal(
    colnames(tidy(s, matrix = "d")),
    colnames(tidy(p, matrix = "d"))
  )
  
  expect_equal(
    colnames(tidy(i, matrix = "v")),
    colnames(tidy(p, matrix = "v"))
  )
  expect_equal(
    colnames(tidy(i, matrix = "v")),
    colnames(tidy(s, matrix = "v"))
  )
  expect_equal(
    colnames(tidy(s, matrix = "v")),
    colnames(tidy(p, matrix = "v"))
  )
})
