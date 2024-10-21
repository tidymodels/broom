skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("quantreg")
suppressPackageStartupMessages(library(quantreg))

airquality <- na.omit(airquality)

fit <- rq(Ozone ~ ., data = airquality, tau = 1:19 / 20)
fit2 <- rq(Ozone ~ Temp - 1, data = airquality, tau = 1:19 / 20)

test_that("quantreg::rqs tidier arguments", {
  check_arguments(tidy.rqs)
  # glance.rqs only exists for informative error
  check_arguments(augment.rqs, strict = FALSE)
})

test_that("tidy.rqs", {
  td <- tidy(fit)
  td2 <- tidy(fit2)
  td_iid <- tidy(fit, se.type = "iid")

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(td_iid)
})

test_that("glance.rqs", {
  expect_snapshot(error = TRUE, glance(fit))
})

test_that("augment.rqs", {
  check_augment_function(
    aug = augment.rqs,
    model = fit,
    data = airquality,
    newdata = airquality,
    strict = FALSE
  )

  check_augment_function(
    aug = augment.rqs,
    model = fit2,
    data = airquality,
    newdata = airquality,
    strict = FALSE
  )
})
