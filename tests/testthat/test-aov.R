context("aov")

library(broom)

d <- data.frame(
  y = c(3, 4, 3.5, 4.1, 6, 7),
  group = c("a", "b", "a", "b", "c", "c")
)
m <- aov(y ~ group, data = d)

test_that("glance.aov", {
  glance_df <- glance(m)

  expect_equal(glance_df$logLik, -1.752246, tolerance = 0.001)
  expect_equal(glance_df$AIC, 11.50449, tolerance = 0.001)
  expect_equal(glance_df$BIC, 10.67153, tolerance = 0.001)
  expect_equal(glance_df$deviance, 0.6300, tolerance = 0.001)
  expect_equal(glance_df$nobs, 6L)
})
