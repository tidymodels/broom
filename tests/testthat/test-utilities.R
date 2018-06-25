context("utilities")

skip("specification not yet complete")

skip_if_not_installed("betareg")
library(betareg)

test_that("validate_augment_input", {
  
  data(GasolineYield)
  
  model <- lm(hp ~ ., mtcars)
  poly_m <- lm(hp ~ poly(mpg, 2), mtcars)  # augment(poly_m) works
  
  # augment(m3) breaks. it's possible that it wouldn't with a better
  # implementation, in which case we'd want something here
  # where it's imperative to specify either data or newdata to 
  # prevent an explosion
  
  m3 <- betareg(yield ~ poly(temp, 2), GasolineYield)
  
  expect_warning(
    validate_augment_input(model, data = mtcars, newdata = mtcars),
    regexp = "Both `data` and `newdata` have been specified. Ignoring `data`."
  )
  
  expect_warning(
    validate_augment_input(poly_m, mtcars[, 1:3]),
    "`data` might not contain columns present in original data."
  )
  
  extra_rows <- bind_rows(mtcars, head(mtcars))
  
  expect_warning(
    validate_augment_input(model, extra_rows),
    regexp = paste(
      "`data` must contain all rows passed to the original modelling", 
      "function with no extras rows."
    )
  )
  
  expect_message(
    validate_augment_input(m3),
    regexp = paste0(
      "Neither `data` nor `newdata` has been specified.\n",
      "Attempting to reconstruct original data."
    )
  )
  
  expect_error(
    validate_augment_input(m3, model.frame(m3)),
    regexp = paste0(
      "`data` is malformed: must be coercable to a tibble.\n",
      "Did you pass `data` the data originally used to fit your model?"
    )
  )
  
  expect_error(
    validate_augment_input(model, 1L),
    regexp = "`data` argument must be a tibble or dataframe."
  )
  
  expect_error(
    validate_augment_input(model, newdata = 1L),
    regexp = "`newdata` argument must be a tibble or dataframe."
  )
  
})
