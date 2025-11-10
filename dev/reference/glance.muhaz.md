# Glance at a(n) muhaz object

Glance accepts a model object and returns a
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row of model summaries. The summaries are typically
goodness of fit measures, p-values for hypothesis tests on residuals, or
model convergence information.

Glance never returns information from the original call to the modeling
function. This includes the name of the modeling function or any
arguments passed to the modeling function.

Glance does not calculate summary measures. Rather, it farms out these
computations to appropriate methods and gathers the results together.
Sometimes a goodness of fit measure will be undefined. In these cases
the measure will be reported as `NA`.

Glance returns the same number of columns regardless of whether the
model matrix is rank-deficient or not. If so, entries in columns that no
longer have a well-defined value are filled in with an `NA` of the
appropriate type.

## Usage

``` r
# S3 method for class 'muhaz'
glance(x, ...)
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

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`muhaz::muhaz()`](https://rdrr.io/pkg/muhaz/man/muhaz.html)

Other muhaz tidiers:
[`tidy.muhaz()`](https://broom.tidymodels.org/dev/reference/tidy.muhaz.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- max.hazard:

  Maximal estimated hazard.

- max.time:

  The maximum observed event or censoring time.

- min.hazard:

  Minimal estimated hazard.

- min.time:

  The minimum observed event or censoring time.

- nobs:

  Number of observations used.

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
