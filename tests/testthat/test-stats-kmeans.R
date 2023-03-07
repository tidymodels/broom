context("stats-kmeans")

skip_if_not_installed("modeltests")
library(modeltests)

set.seed(2)
x <- rbind(
  matrix(rnorm(100, sd = 0.3), ncol = 2),
  matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2)
)

fit <- kmeans(x, 2)

d <- data.frame(x = runif(100), y = runif(100))
fit2 <- kmeans(x = d, centers = 5)

test_that("kmeans tidier arguments", {
  check_arguments(tidy.kmeans)
  check_arguments(glance.kmeans)
  check_arguments(augment.kmeans, strict = FALSE)
})

# tidy.kmeans uses the orginal column names to name columns in output.
# Therefore, strict must be set to FALSE for this test to pass.
test_that("tidy.kmeans", {
  td <- tidy(fit)
  check_tidy_output(td, strict = FALSE)
})

test_that("tidy.kmeans", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})

test_that("augment.kmeans", {
  # data argument cannot be empty
  expect_error(
    augment(fit),
    regexp = "argument \"data\" is missing, with no default"
  )

  check_augment_function(
    aug = augment.kmeans,
    model = fit,
    data = x,
    newdata = x,
    strict = FALSE
  )

  check_augment_function(
    aug = augment.kmeans,
    model = fit2,
    data = d,
    newdata = d,
    strict = FALSE
  )
})
