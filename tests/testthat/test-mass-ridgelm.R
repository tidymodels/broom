context("mass-ridgelm")

skip_if_not_installed("MASS")

names(longley)[1] <- "y"
fit2 <- MASS::lm.ridge(y ~ ., longley)
fit3 <- MASS::lm.ridge(y ~ ., longley, lambda = seq(0.001, .05, .001))

test_that("MASS::lm.ridge tidier arguments", {
  check_arguments(tidy.ridgelm)
  check_arguments(glance.ridgelm)
})

test_that("tidy.ridgelm", {
  
  td2 <- tidy(fit2)
  td3 <- tidy(fit3)
  
  check_tidy_output(td2)
  check_tidy_output(td3)
})

test_that("glance.ridgelm", {
  gl2 <- glance(fit2)
  gl3 <- glance(fit3)
  check_glance_outputs(gl2, gl3)
})
