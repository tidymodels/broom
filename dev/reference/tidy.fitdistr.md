# Tidy a(n) fitdistr object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'fitdistr'
tidy(x, ...)
```

## Arguments

- x:

  A `fitdistr` object returned by
  [`MASS::fitdistr()`](https://rdrr.io/pkg/MASS/man/fitdistr.html).

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
[`MASS::fitdistr()`](https://rdrr.io/pkg/MASS/man/fitdistr.html)

Other fitdistr tidiers:
[`glance.fitdistr()`](https://broom.tidymodels.org/dev/reference/glance.fitdistr.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- estimate:

  The estimated value of the regression term.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

## Examples

``` r
# load libraries for models and data
library(MASS)

# generate data
set.seed(2015)
x <- rnorm(100, 5, 2)

#  fit models
fit <- fitdistr(x, dnorm, list(mean = 3, sd = 1))
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced

# summarize model fit with tidiers
tidy(fit)
#> # A tibble: 2 × 3
#>   term  estimate std.error
#>   <chr>    <dbl>     <dbl>
#> 1 mean      4.90     0.201
#> 2 sd        2.01     0.142
glance(fit)
#> # A tibble: 1 × 4
#>   logLik      AIC   BIC  nobs
#>   <logLik>  <dbl> <dbl> <int>
#> 1 -211.6533  427.  433.   100
```
