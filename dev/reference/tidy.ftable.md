# (Deprecated) Tidy ftable objects

This function is deprecated. Please use
[`tibble::as_tibble()`](https://tibble.tidyverse.org/reference/as_tibble.html)
instead.

## Usage

``` r
# S3 method for class 'ftable'
tidy(x, ...)
```

## Arguments

- x:

  An `ftable` object returned from
  [`stats::ftable()`](https://rdrr.io/r/stats/ftable.html).

- ...:

  Additional arguments. Not used. Needed to match generic signature
  only. **Cautionary note:** Misspelled arguments will be absorbed in
  `...`, where they will be ignored. If the misspelled argument has a
  default value, the default value will be used. For example, if you
  pass `conf.lvel = 0.9`, all computation will proceed using
  `conf.level = 0.95`. Two exceptions here are:

  - [`tidy()`](https://generics.r-lib.org/reference/tidy.html) methods
    will warn when supplied an `exponentiate` argument if it will be
    ignored.

  - [`augment()`](https://generics.r-lib.org/reference/augment.html)
    methods will warn when supplied a `newdata` argument if it will be
    ignored.

## Value

An ftable contains a "flat" contingency table. This melts it into a
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with one column for each variable, then a `Freq` column.

## See also

Other deprecated:
[`bootstrap()`](https://broom.tidymodels.org/dev/reference/bootstrap.md),
[`confint_tidy()`](https://broom.tidymodels.org/dev/reference/confint_tidy.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`finish_glance()`](https://broom.tidymodels.org/dev/reference/finish_glance.md),
[`fix_data_frame()`](https://broom.tidymodels.org/dev/reference/fix_data_frame.md),
[`summary_tidiers`](https://broom.tidymodels.org/dev/reference/summary_tidiers.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.dist()`](https://broom.tidymodels.org/dev/reference/tidy.dist.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)
