context("boot")

skip_if_not_installed("boot")
library(boot)

test_that("boot tidier arguments", {
  check_arguments(tidy.boot)
})

test_that("tidy.boot for glms", {
  
  clotting <- data.frame(
    u = c(5, 10, 15, 20, 30, 40, 60, 80, 100),
    lot1 = c(118, 58, 42, 35, 27, 25, 21, 19, 18),
    lot2 = c(69, 35, 26, 21, 18, 16, 13, 12, 12)
  )

  g1 <- glm(lot2 ~ log(u), data = clotting, family = Gamma)

  boot_fun <- function(d, i) {
    coef(update(g1, data = d[i, ]))
  }
  
  bootres <- boot::boot(clotting, boot_fun, R = 100)
  td <- tidy(bootres, conf.int = TRUE)

  bootresw <- boot::boot(clotting, boot_fun, R = 100, weights = rep(1 / 9, 9))
  tdw <- tidy(bootresw, conf.int = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(tdw)
  
  check_dims(td, 2, 6)
  check_dims(tdw, 2, 7)
})

test_that("tidy.boot for time series", {
  
  lynx.fun <- function(tsb) {
    ar.fit <- ar(tsb, order.max = 25)
    c(ar.fit$order, mean(tsb), tsb)
  }
  
  lynx <- boot::tsboot(log(lynx), lynx.fun, R = 99, l = 20, orig.t = FALSE)
  td <- tidy(lynx)
  
  check_tidy_output(td)
  check_dims(td, expected_cols = 2)
})
