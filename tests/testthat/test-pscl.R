skip_if_not_installed("pscl")

# - If poissonreg isn't installed, register the method (`packageVersion()` will error here)
# - If poissonreg >= 1.0.1.9001 is installed, register the method
should_register_pscl_tidiers <- tryCatch(
  expr = utils::packageVersion("poissonreg") >= "1.0.1.9001",
  error = function(cnd) TRUE
)
skip_if_not(should_register_pscl_tidiers)

test_that("hurdle", {
  data("bioChemists", package = "pscl")
  hurd <- pscl::hurdle(art ~ fem | ment, data = bioChemists)
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
