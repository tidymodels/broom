# Tidy a(n) lmRob object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'lmRob'
tidy(x, ...)
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

## Details

For tidiers for robust models from the MASS package see
[`tidy.rlm()`](https://broom.tidymodels.org/dev/reference/tidy.rlm.md).

## See also

[`robust::lmRob()`](https://rdrr.io/pkg/robust/man/lmRob.html)

Other robust tidiers:
[`augment.lmRob()`](https://broom.tidymodels.org/dev/reference/augment.lmRob.md),
[`glance.glmRob()`](https://broom.tidymodels.org/dev/reference/glance.glmRob.md),
[`glance.lmRob()`](https://broom.tidymodels.org/dev/reference/glance.lmRob.md),
[`tidy.glmRob()`](https://broom.tidymodels.org/dev/reference/tidy.glmRob.md)

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
