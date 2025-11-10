# Tidy a(n) geeglm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'geeglm'
tidy(x, conf.int = FALSE, conf.level = 0.95, exponentiate = FALSE, ...)
```

## Arguments

- x:

  A `geeglm` object returned from a call to
  [`geepack::geeglm()`](https://rdrr.io/pkg/geepack/man/geeglm.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- exponentiate:

  Logical indicating whether or not to exponentiate the the coefficient
  estimates. This is typical for logistic and multinomial regressions,
  but a bad idea if there is no log or logit link. Defaults to `FALSE`.

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

If `conf.int = TRUE`, the confidence interval is computed with the an
internal `confint.geeglm()` function.

If you have missing values in your model data, you may need to refit the
model with `na.action = na.exclude` or deal with the missingness in the
data beforehand.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`geepack::geeglm()`](https://rdrr.io/pkg/geepack/man/geeglm.html)

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

- term:

  The name of the regression term.

## Examples

``` r
# load modeling library
library(geepack)

# load data
data(state)


ds <- data.frame(state.region, state.x77)

# fit model
geefit <- geeglm(Income ~ Frost + Murder,
  id = state.region,
  data = ds,
  corstr = "exchangeable"
)

# summarize model fit with tidiers
tidy(geefit)
#> # A tibble: 3 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)  4406.      407.     117.      0    
#> 2 Frost           1.69      2.25     0.562   0.453
#> 3 Murder        -22.7      31.4      0.522   0.470
tidy(geefit, conf.int = TRUE)
#> # A tibble: 3 × 7
#>   term        estimate std.error statistic p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 (Intercept)  4406.      407.     117.      0      3608.     5205.  
#> 2 Frost           1.69      2.25     0.562   0.453    -2.72      6.10
#> 3 Murder        -22.7      31.4      0.522   0.470   -84.2      38.8 
```
