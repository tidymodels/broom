# Tidy a(n) cmprsk object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'crr'
tidy(x, exponentiate = FALSE, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `crr` object returned from
  [`cmprsk::crr()`](https://rdrr.io/pkg/cmprsk/man/crr.html).

- exponentiate:

  Logical indicating whether or not to exponentiate the the coefficient
  estimates. This is typical for logistic and multinomial regressions,
  but a bad idea if there is no log or logit link. Defaults to `FALSE`.

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

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`cmprsk::crr()`](https://rdrr.io/pkg/cmprsk/man/crr.html)

Other cmprsk tidiers:
[`glance.crr()`](https://broom.tidymodels.org/dev/reference/glance.crr.md)

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

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- std.error:

  The standard error of the regression term.

## Examples

``` r
library(cmprsk)

# time to loco-regional failure (lrf)
lrf_time <- rexp(100)
lrf_event <- sample(0:2, 100, replace = TRUE)
trt <- sample(0:1, 100, replace = TRUE)
strt <- sample(1:2, 100, replace = TRUE)

# fit model
x <- crr(lrf_time, lrf_event, cbind(trt, strt))

# summarize model fit with tidiers
tidy(x, conf.int = TRUE)
#> # A tibble: 2 × 7
#>   term  estimate std.error statistic p.value conf.low conf.high
#>   <chr>    <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 trt     -0.350     0.371    -0.944    0.35   -1.08      0.377
#> 2 strt     0.258     0.372     0.694    0.49   -0.471     0.986
glance(x)
#> # A tibble: 1 × 5
#>   converged logLik  nobs    df statistic
#>   <lgl>      <dbl> <int> <dbl>     <dbl>
#> 1 TRUE       -116.   100     2      1.30
```
