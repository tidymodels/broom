context("stats-decompose")

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
