context("quantreg-rqs")

skip_if_not_installed("quantreg")
library(quantreg)

# TODO: this obscures a bug in how augment.rqs deals with NAs, but
# punting on that until after broom 0.5.0
airquality <- na.omit(airquality)

fit <- rq(Ozone ~ ., data = airquality, tau = 1:19 / 20)
fit2 <- rq(Ozone ~ Temp - 1, data = airquality, tau = 1:19 / 20)

test_that("quantreg::rqs tidier arguments", {
  check_arguments(tidy.rqs)
  # glance.rqs only exists for informative error
  check_arguments(augment.rqs)
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
  expect_error(
    glance(fit), 
    regexp = paste(
      "`glance` cannot handle objects of class 'rqs',",
      "i.e. models with more than one tau value. Please",
      "use a purrr `map`-based workflow with 'rq' models instead."
    )
  )
})

test_that("augment.rqs", {
  check_augment_function(
    aug = augment.rqs,
    model = fit,
    data = airquality,
    newdata = airquality
  )
  
  check_augment_function(
    aug = augment.rqs,
    model = fit2,
    data = airquality,
    newdata = airquality
  )
})
