# ellipsis checking works

    Code
      check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE)
    Condition
      Warning:
      The `exponentiate` argument is not supported in the `tidy()` method for `boop` objects and will be ignored.

---

    Code
      check_ellipses("exponentiate", "tidy", "boop", exponentiate = TRUE, quick = FALSE)
    Condition
      Warning:
      The `exponentiate` argument is not supported in the `tidy()` method for `boop` objects and will be ignored.

# ellipsis checking works (whole game, tidy)

    Code
      tidy(mod, exponentiate = TRUE)
    Condition
      Warning:
      The `exponentiate` argument is not supported in the `tidy()` method for `nls` objects and will be ignored.
    Output
      # A tibble: 2 x 5
        term  estimate std.error statistic  p.value
        <chr>    <dbl>     <dbl>     <dbl>    <dbl>
      1 k       49.7      3.79        13.1 5.96e-14
      2 e        0.746    0.0199      37.5 8.86e-27

# ellipsis checking works (whole game, augment)

    Code
      .res <- augment(mod, data = mtcars, newdata = mtcars)
    Condition
      Warning:
      The `newdata` argument is not supported in the `augment()` method for `kmeans` objects and will be ignored.

# as_glance_tibble

    Code
      as_glance_tibble(x = 1, y = 1, na_types = "rrr")
    Condition
      Error in `as_glance_tibble()`:
      ! The number of columns provided does not match the number of column types provided.

# appropriate warning on (g)lm-subclassed models

    Code
      warn_on_subclass(x, "tidy")
    Condition
      Warning:
      The `tidy()` method for objects of class `boop` is not maintained by the broom team, and is only supported through the `glm` tidier method. Please be cautious in interpreting and reporting broom output.
      
      This warning is displayed once per session.

---

    Code
      warn_on_subclass(x, "tidy")
    Condition
      Warning:
      The `tidy()` method for objects of class `bop` is not maintained by the broom team, and is only supported through the `glm` tidier method. Please be cautious in interpreting and reporting broom output.
      
      This warning is displayed once per session.

