
test_that("hurdle", {
  library(pscl)
  data("bioChemists", package = "pscl")
  hurd <- hurdle(art ~ fem | ment, data = bioChemists)
  summ <- summary(hurd)

  expect_error(counts <- tidy(hurd), regexp = NA)
  expect_error(zeros <- tidy(hurd, "zero"), regexp = NA)
  expect_error(both <- tidy(hurd, "all"), regexp = NA)

  expect_equal(
    unname(summ$coefficients$count[, "Estimate"]),
    counts$estimate
  )
  expect_equal(
    unname(summ$coefficients$zero[, "Estimate"]),
    zeros$estimate
  )
  expect_equal(
    c(
      unname(summ$coefficients$count[, "Estimate"]),
      unname(summ$coefficients$zero[, "Estimate"])
    ),
    both$estimate
  )
})
