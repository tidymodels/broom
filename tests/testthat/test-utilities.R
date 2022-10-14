context("utilities")

skip_if_not_installed("modeltests")
library(modeltests)

test_that("ellipsis checking works", {
  expect_warning(
    check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE),
    "\\`exponentiate\\` argument is not supported in the \\`tidy\\(\\)\\` method for \\`boop\\` objects"
  )
  
  expect_warning(
    check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE, quick = FALSE),
    "\\`exponentiate\\` argument is not supported in the \\`tidy\\(\\)\\` method for \\`boop\\` objects"
  )
  
  expect_silent(check_ellipses("exponentiate", "tidy", "boop", hi = "pal"))
})

test_that("ellipsis checking works (whole game, tidy)", {
  mod <- nls(mpg ~ k * e^wt, data = mtcars, start = list(k = 1, e = 2))
  
  expect_warning(
    tidy(mod, exponentiate = TRUE),
    "\\`exponentiate\\` argument is not supported in the \\`tidy\\(\\)\\` method for \\`nls\\` objects"
  )
})

test_that("ellipsis checking works (whole game, augment)", {
  mod <- kmeans(mtcars, centers = 4)
  
  expect_warning(
    augment(mod, data = mtcars, newdata = mtcars),
    "\\`newdata\\` argument is not supported in the \\`augment\\(\\)\\` method for \\`kmeans\\` objects"
  )
})

test_that("as_glance_tibble", {
  df1 <- as_glance_tibble(x = 1, y = 1, na_types = "rr")
  df2 <- as_glance_tibble(x = 1, y = NULL, na_types = "rc")
  df3 <- as_glance_tibble(x = 1, y = NULL, na_types = "rr")
  
  expect_equal(purrr::map(df1, class),
               purrr::map(df3, class))
  
  expect_true(class(df1$y) == class(df3$y))
  
  expect_false(class(df1$y) == class(df2$y))
  
  expect_error(
    as_glance_tibble(x = 1, y = 1, na_types = "rrr")
  )
})

test_that("appropriate warning on (g)lm-subclassed models", {
  x <- 1
  class(x) <- c("boop", "glm")
  
  expect_warning(
    warn_on_subclass(x, "tidy"),
    "class \\`boop\\`.*only supported through the \\`glm\\` tidier method."
  )
  
  # only displayed once per session, per unique dispatch
  expect_silent(
    warn_on_subclass(x, "tidy")
  )
  
  class(x) <- c("bop", "glm", "lm")
  
  expect_warning(
    warn_on_subclass(x, "tidy"),
    "class \\`bop\\`.*only supported through the `glm` tidier method."
  )
  
  # only displayed once per session, per unique dispatch
  expect_silent(
    warn_on_subclass(x, "tidy")
  )
})
