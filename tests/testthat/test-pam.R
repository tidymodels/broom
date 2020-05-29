context("pam")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("cluster")
library(cluster)

x <- iris %>% select(-Species)
p <- pam(x, k = 3)

test_that("pam tidier arguments", {
  check_arguments(tidy.pam)
  check_arguments(glance.pam)
  check_arguments(augment.pam)
})

test_that("tidy.pam", {
  td <- tidy(p)
  td2 <- tidy(p, conf.int = TRUE)

  expect_error(check_tidy_output(td))
  expect_error(check_tidy_output(td2))
})

test_that("glance.pam", {
  gl <- glance(p)
  check_glance_outputs(gl)
})

test_that("augment.pam", {
  check_augment_function(
    aug = augment.pam,
    model = p,
    data = iris,
    newdata = iris
  )
})
