context("Kendall tidiers")

test_that("Kendall tidiers work", {
  library(Kendall)
  A <- c(2.5,2.5,2.5,2.5,5,6.5,6.5,10,10,10,10,10,14,14,14,16,17)
  B <- c(1,1,1,1,2,1,1,2,1,1,1,1,1,1,2,2,2)
  
  f_res <- tidy(Kendall(A,B))
  check_tidy(f_res, exp.row = 1, exp.col = 5)
  
  s_res <- tidy(MannKendall(A))
  check_tidy(s_res, exp.row = 1, exp.col = 5)
  
  t_res <- tidy(SeasonalMannKendall(ts(B)))
  check_tidy(t_res, exp.row = 1, exp.col = 5)
})
