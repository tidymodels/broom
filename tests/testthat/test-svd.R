context("svd tidiers")

mat <- scale(as.matrix(USJudgeRatings))
s <- svd(mat)
p <- prcomp(mat)

test_that("svd tidiers work", {
  td <- tidy(s, matrix = "u")
  check_tidy(td, exp.row = 516, exp.col = 3)

  td <- tidy(s, matrix = "d")
  check_tidy(td, exp.row = 12, exp.col = 4)

  td <- tidy(s, matrix = "v")
  check_tidy(td, exp.row = 144, exp.col = 3)
})

if (requireNamespace("irlba")) {
  i <- irlba::irlba(mat)
  
  test_that("irlba tidiers work", {
    td <- tidy(i, matrix = "u")
    check_tidy(td, exp.row = 215, exp.col = 3)
    
    td <- tidy(i, matrix = "d")
    check_tidy(td, exp.row = 5, exp.col = 4)
    
    td <- tidy(i, matrix = "v")
    check_tidy(td, exp.row = 60, exp.col = 3)
  })
  
  test_that("prcomp, svd, irlba tidiers have consistent output", {
    expect_equal(colnames(tidy(i)), colnames(tidy(p)))
    expect_equal(colnames(tidy(i)), colnames(tidy(s)))
    expect_equal(colnames(tidy(s)), colnames(tidy(p)))
    
    expect_equal(colnames(tidy(i, matrix = "d")),
                 colnames(tidy(p, matrix = "d")))
    expect_equal(colnames(tidy(i, matrix = "d")),
                 colnames(tidy(s, matrix = "d")))
    expect_equal(colnames(tidy(s, matrix = "d")),
                 colnames(tidy(p, matrix = "d")))
    
    expect_equal(colnames(tidy(i, matrix = "v")),
                 colnames(tidy(p, matrix = "v")))
    expect_equal(colnames(tidy(i, matrix = "v")),
                 colnames(tidy(s, matrix = "v")))
    expect_equal(colnames(tidy(s, matrix = "v")),
                 colnames(tidy(p, matrix = "v")))
  })
}


