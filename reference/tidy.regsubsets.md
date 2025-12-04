# Tidy a(n) regsubsets object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'regsubsets'
tidy(x, ...)
```

## Arguments

- x:

  A `regsubsets` object created by
  [`leaps::regsubsets()`](https://rdrr.io/pkg/leaps/man/regsubsets.html).

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

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`leaps::regsubsets()`](https://rdrr.io/pkg/leaps/man/regsubsets.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- r.squared:

  R squared statistic, or the percent of variation explained by the
  model.

- adj.r.squared:

  Adjusted R squared statistic

- BIC:

  Bayesian information criterion for the component.

- mallows_cp:

  Mallow's Cp statistic.

## Examples

``` r
# load libraries for models and data
library(leaps)

# fit model
all_fits <- regsubsets(hp ~ ., mtcars)

# summarize model fit with tidiers
tidy(all_fits)
#> # A tibble: 8 × 15
#>   `(Intercept)` mpg   cyl   disp  drat  wt    qsec  vs    am    gear 
#>   <lgl>         <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl>
#> 1 TRUE          FALSE TRUE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> 2 TRUE          FALSE FALSE TRUE  FALSE FALSE FALSE FALSE FALSE FALSE
#> 3 TRUE          FALSE FALSE TRUE  FALSE TRUE  FALSE FALSE FALSE FALSE
#> 4 TRUE          TRUE  FALSE TRUE  FALSE TRUE  FALSE FALSE FALSE FALSE
#> 5 TRUE          TRUE  FALSE TRUE  FALSE TRUE  FALSE TRUE  FALSE FALSE
#> 6 TRUE          TRUE  TRUE  TRUE  FALSE TRUE  FALSE TRUE  FALSE FALSE
#> 7 TRUE          TRUE  TRUE  TRUE  FALSE TRUE  FALSE TRUE  TRUE  FALSE
#> 8 TRUE          TRUE  TRUE  TRUE  FALSE TRUE  FALSE TRUE  TRUE  TRUE 
#> # ℹ 5 more variables: carb <lgl>, r.squared <dbl>,
#> #   adj.r.squared <dbl>, BIC <dbl>, mallows_cp <dbl>
```
