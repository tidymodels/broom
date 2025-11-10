# Glance at a(n) lmRob object

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
# S3 method for class 'lmRob'
glance(x, ...)
```

## Arguments

- x:

  A `lmRob` object returned from
  [`robust::lmRob()`](https://rdrr.io/pkg/robust/man/lmRob.html).

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

[`robust::lmRob()`](https://rdrr.io/pkg/robust/man/lmRob.html)

Other robust tidiers:
[`augment.lmRob()`](https://broom.tidymodels.org/dev/reference/augment.lmRob.md),
[`glance.glmRob()`](https://broom.tidymodels.org/dev/reference/glance.glmRob.md),
[`tidy.glmRob()`](https://broom.tidymodels.org/dev/reference/tidy.glmRob.md),
[`tidy.lmRob()`](https://broom.tidymodels.org/dev/reference/tidy.lmRob.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- deviance:

  Deviance of the model.

- df.residual:

  Residual degrees of freedom.

- nobs:

  Number of observations used.

- r.squared:

  R squared statistic, or the percent of variation explained by the
  model. Also known as the coefficient of determination.

- sigma:

  Estimated standard error of the residuals.

## Examples

``` r
# load modeling library
library(robust)

# fit model
m <- lmRob(mpg ~ wt, data = mtcars)

# summarize model fit with tidiers
tidy(m)
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)    35.6       3.58      9.93 5.37e-11
#> 2 wt             -4.91      1.09     -4.49 9.67e- 5
augment(m)
#> # A tibble: 32 × 4
#>    .rownames           mpg    wt .fitted
#>    <chr>             <dbl> <dbl>   <dbl>
#>  1 Mazda RX4          21    2.62    22.7
#>  2 Mazda RX4 Wag      21    2.88    21.4
#>  3 Datsun 710         22.8  2.32    24.2
#>  4 Hornet 4 Drive     21.4  3.22    19.8
#>  5 Hornet Sportabout  18.7  3.44    18.7
#>  6 Valiant            18.1  3.46    18.6
#>  7 Duster 360         14.3  3.57    18.0
#>  8 Merc 240D          24.4  3.19    19.9
#>  9 Merc 230           22.8  3.15    20.1
#> 10 Merc 280           19.2  3.44    18.7
#> # ℹ 22 more rows
glance(m)
#> # A tibble: 1 × 5
#>   r.squared deviance sigma df.residual  nobs
#>       <dbl>    <dbl> <dbl>       <int> <int>
#> 1     0.567     136.  2.95          30    32
```
