# (Deprecated) Calculate confidence interval as a tidy data frame

This function is now deprecated and will be removed from a future
release of broom.

## Usage

``` r
confint_tidy(x, conf.level = 0.95, func = stats::confint, ...)
```

## Arguments

- x:

  a model object for which
  [`confint()`](https://rdrr.io/r/stats/confint.html) can be calculated

- conf.level:

  confidence level

- func:

  A function to compute a confidence interval for `x`. Calling
  `func(x, level = conf.level, ...)` must return an object coercible to
  a tibble. This dataframe like object should have to columns
  corresponding the lower and upper bounds on the confidence interval.

- ...:

  extra arguments passed on to `confint`

## Value

A tibble with two columns: `conf.low` and `conf.high`.

## Details

Return a confidence interval as a tidy data frame. This directly wraps
the [`confint()`](https://rdrr.io/r/stats/confint.html) function, but
ensures it follows broom conventions: column names of `conf.low` and
`conf.high`, and no row names.

`confint_tidy`

## See also

Other deprecated:
[`bootstrap()`](https://broom.tidymodels.org/dev/reference/bootstrap.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`finish_glance()`](https://broom.tidymodels.org/dev/reference/finish_glance.md),
[`fix_data_frame()`](https://broom.tidymodels.org/dev/reference/fix_data_frame.md),
[`summary_tidiers`](https://broom.tidymodels.org/dev/reference/summary_tidiers.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.dist()`](https://broom.tidymodels.org/dev/reference/tidy.dist.md),
[`tidy.ftable()`](https://broom.tidymodels.org/dev/reference/tidy.ftable.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)
