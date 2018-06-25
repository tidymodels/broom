context("gmm")

skip_if_not_installed("gmm")
library(gmm)

data(Finance)

r <- Finance[1:300, 1:10]
rm <- Finance[1:300, "rm"]
rf <- Finance[1:300, "rf"]

z <- as.matrix(r - rf)
t <- nrow(z)
zm <- rm - rf
h <- matrix(zm, t, 1)

fit <- gmm(z ~ zm, x = h)

test_that("gmm tidier arguments", {
  check_arguments(tidy.gmm)
  check_arguments(glance.gmm)
})

test_that("tidy.gmm", {
  td <- tidy(fit)
  td2 <- tidy(fit, conf.int = TRUE)
  tdq <- tidy(fit, quick = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(tdq)
})

test_that("glance.gmm", {
  gl <- glance(fit)
  check_glance_outputs(gl)
})
