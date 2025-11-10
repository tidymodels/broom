# Tidy a(n) muhaz object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'muhaz'
tidy(x, ...)
```

## Arguments

- x:

  A `muhaz` object returned by
  [`muhaz::muhaz()`](https://rdrr.io/pkg/muhaz/man/muhaz.html).

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
[`muhaz::muhaz()`](https://rdrr.io/pkg/muhaz/man/muhaz.html)

Other muhaz tidiers:
[`glance.muhaz()`](https://broom.tidymodels.org/dev/reference/glance.muhaz.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- time:

  Point in time.

- estimate:

  Estimated hazard rate.

## Examples

``` r
# load libraries for models and data
library(muhaz)
library(survival)

# fit model
x <- muhaz(ovarian$futime, ovarian$fustat)

# summarize model fit with tidiers
tidy(x)
#> # A tibble: 101 × 2
#>     time estimate
#>    <dbl>    <dbl>
#>  1  0    0.000255
#>  2  7.44 0.000274
#>  3 14.9  0.000293
#>  4 22.3  0.000312
#>  5 29.8  0.000332
#>  6 37.2  0.000352
#>  7 44.6  0.000372
#>  8 52.1  0.000392
#>  9 59.5  0.000411
#> 10 67.0  0.000431
#> # ℹ 91 more rows
glance(x)
#> # A tibble: 1 × 5
#>    nobs min.time max.time min.hazard max.hazard
#>   <int>    <dbl>    <dbl>      <dbl>      <dbl>
#> 1    26        0      744   0.000212    0.00111
```
