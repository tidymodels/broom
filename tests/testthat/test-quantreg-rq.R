skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("quantreg")
suppressPackageStartupMessages(library(quantreg))

data(stackloss)

df <- as_tibble(stack.x) %>%
  mutate(stack.loss = stack.loss)

dflarge_n <- df %>% slice(rep(row_number(), 500))

fit <- rq(stack.loss ~ ., data = df, tau = .5)
fit2 <- rq(stack.loss ~ 1, data = df, tau = .5)
fitlarge_n <- rq(stack.loss ~ ., data = dflarge_n, tau = .5)

test_that("quantreg::rq tidier arguments", {
  check_arguments(tidy.rq)
  check_arguments(glance.rq)
  check_arguments(augment.rq)
})

test_that("tidy.rq", {
  td <- tidy(fit)
  td2 <- tidy(fit2)
  tdlarge_n <- tidy(fitlarge_n)
  td_iid <- tidy(fit, conf.int = TRUE, se.type = "iid")

  check_tidy_output(td)
  check_tidy_output(td2)
  check_tidy_output(tdlarge_n)
  check_tidy_output(td_iid)

  check_dims(td, 4, 5)
  check_dims(td2, 1, 5)
  check_dims(tdlarge_n, 4, 6)
  check_dims(td_iid, 4, 8)
})

test_that("glance.rq", {
  gl <- glance(fit)
  gl2 <- glance(fit2)
  check_glance_outputs(gl, gl2)
})

test_that("augment.rq", {
  au <- augment(fit, interval = "confidence")
  check_tibble(au, method = "augment", strict = FALSE)
  check_dims(au, 21, 9)

  check_augment_function(
    aug = augment.rq,
    model = fit,
    data = df,
    newdata = df,
    strict = FALSE
  )

  check_augment_function(
    aug = augment.rq,
    model = fit2,
    data = df,
    newdata = df,
    strict = FALSE
  )
})
