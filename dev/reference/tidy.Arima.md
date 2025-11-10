# Tidy a(n) Arima object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'Arima'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  An object of class `Arima` created by
  [`stats::arima()`](https://rdrr.io/r/stats/arima.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

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
[`glance.Arima()`](https://broom.tidymodels.org/dev/reference/glance.Arima.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- estimate:

  The estimated value of the regression term.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

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
