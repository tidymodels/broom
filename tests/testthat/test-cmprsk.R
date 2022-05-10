context("cmprsk")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("cmprsk")
library(cmprsk)
set.seed(2)

# simulate data
lrf_time <- rexp(100) # time to loco-regional failure (lrf)
lrf_event <- sample(0:2, 100, replace = TRUE) 
trt <- sample(0:1, 100, replace = TRUE)
strt <- sample(1:2, 100, replace = TRUE)

# fit model
fit <- cmprsk::crr(lrf_time, lrf_event, cbind(trt, strt))

test_that("cmprsk tidier arguments", {
  check_arguments(tidy.crr)
  check_arguments(glance.crr)
})

test_that("tidy.cmprsk", {
  td1 <- tidy(fit)
  td2 <- tidy(fit, conf.int = TRUE)
  td3 <- tidy(fit, conf.int = TRUE, conf.level = 0.99)

  check_tidy_output(td1)
  check_tidy_output(td2)
  check_tidy_output(td3)

  check_dims(td1, 2, 5)
  check_dims(td2, 2, 7)
  check_dims(td3, 2, 7)
  
  # check the `conf.level=` argument matches the result in `summary(conf.int=)`
  expect_equal(
    summary(fit, conf.int = 0.99)$conf.int %>% 
      log() %>%
      unname() %>%
      as.data.frame() %>% 
      dplyr::select(., tail(names(.), 2)) %>%
      unclass() %>%
      unname(),
    td3 %>% 
      dplyr::select(conf.low, conf.high)  %>%
      unclass() %>%
      unname(),
  )
})
