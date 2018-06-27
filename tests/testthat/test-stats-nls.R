context("stats-nls")

fit <- nls(
  wt ~ a + b * mpg + c / disp,
  data = mtcars,
  start = list(a = 1, b = 2, c = 3)
)

fit2 <- nls(wt ~ b * mpg, data = mtcars, start = list(b = 2))

test_that("nls tidier arguments", {
  check_arguments(tidy.nls)
  check_arguments(glance.nls)
  check_arguments(augment.nls)
})

test_that("tidy.nls", {
  
  td <- tidy(fit, conf.int = TRUE)
  tdq <- tidy(fit, conf.int = TRUE, quick = TRUE)
  
  check_tidy_output(td)
  check_tidy_output(tdq)
  check_dims(td, 3, 7)
  
  expect_equal(td$term, c("a", "b", "c"))
})

test_that("glance.nls", {
  gl <- glance(fit)
  check_glance_outputs(gl)
  check_dims(gl, expected_cols = 8)
})

test_that("augment.nls", {
  
  check_augment_function(
    aug = augment.nls,
    model = fit,
    data = mtcars,
    newdata = mtcars
  )
  
  check_augment_function(
    aug = augment.nls,
    model = fit2,
    data = mtcars,
    newdata = mtcars
  )
})
