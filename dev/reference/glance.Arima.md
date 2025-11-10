# Glance at a(n) Arima object

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
# S3 method for class 'Arima'
glance(x, ...)
```

## Arguments

- x:

  An object of class `Arima` created by
  [`stats::arima()`](https://rdrr.io/r/stats/arima.html).

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

[`stats::arima()`](https://rdrr.io/r/stats/arima.html)

Other Arima tidiers:
[`tidy.Arima()`](https://broom.tidymodels.org/dev/reference/tidy.Arima.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- sigma:

  Estimated standard error of the residuals.

## Examples

``` r
# fit model
fit <- arima(lh, order = c(1, 0, 0))

# summarize model fit with tidiers
tidy(fit)
#> # A tibble: 2 × 3
#>   term      estimate std.error
#>   <chr>        <dbl>     <dbl>
#> 1 ar1          0.574     0.116
#> 2 intercept    2.41      0.147
glance(fit)
#> # A tibble: 1 × 5
#>   sigma logLik   AIC   BIC  nobs
#>   <dbl>  <dbl> <dbl> <dbl> <int>
#> 1 0.444  -29.4  64.8  70.4    48
```
