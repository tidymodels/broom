skip_if_not_installed("mclogit")
library(mclogit)

data(electors)

mod <- mclogit(
  cbind(Freq, interaction(time, class)) ~ econ.left / class + welfare / class + auth / class,
  random = ~ 1 | party.time,
  data = within(electors, party.time <- interaction(party, time)),
  control = mclogit.control(trace = FALSE)
)

test_that("tidy.lm() isn't invoked", {
  expect_error(
    tidy(mod),
    "No tidy method for objects of class mmclogit"
  )
})

test_that("glance.lm() isn't invoked", {
  expect_error(
    glance(mod),
    "No glance method for objects of class mmclogit"
  )
})

test_that("augment.lm() isn't invoked", {
  expect_error(
    augment(mod),
    "No augment method for objects of class mmclogit"
  )
})

rm(mod)
