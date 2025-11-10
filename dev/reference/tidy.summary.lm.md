# Tidy a(n) summary.lm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'summary.lm'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `summary.lm` object created by
  [`stats::summary.lm()`](https://rdrr.io/r/stats/summary.lm.html).

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

## Details

The `tidy.summary.lm()` method is a potentially useful alternative to
[`tidy.lm()`](https://broom.tidymodels.org/dev/reference/tidy.lm.md).
For instance, if users have already converted large `lm` objects into
their leaner `summary.lm` equivalents to conserve memory.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`stats::summary.lm()`](https://rdrr.io/r/stats/summary.lm.html)

Other lm tidiers:
[`augment.glm()`](https://broom.tidymodels.org/dev/reference/augment.glm.md),
[`augment.lm()`](https://broom.tidymodels.org/dev/reference/augment.lm.md),
[`glance.glm()`](https://broom.tidymodels.org/dev/reference/glance.glm.md),
[`glance.lm()`](https://broom.tidymodels.org/dev/reference/glance.lm.md),
[`glance.summary.lm()`](https://broom.tidymodels.org/dev/reference/glance.summary.lm.md),
[`glance.svyglm()`](https://broom.tidymodels.org/dev/reference/glance.svyglm.md),
[`tidy.glm()`](https://broom.tidymodels.org/dev/reference/tidy.glm.md),
[`tidy.lm()`](https://broom.tidymodels.org/dev/reference/tidy.lm.md),
[`tidy.lm.beta()`](https://broom.tidymodels.org/dev/reference/tidy.lm.beta.md),
[`tidy.mlm()`](https://broom.tidymodels.org/dev/reference/tidy.mlm.md)

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
# fit model
mod <- lm(mpg ~ wt + qsec, data = mtcars)
modsumm <- summary(mod)

# summarize model fit with tidiers
tidy(mod, conf.int = TRUE)
#> # A tibble: 3 × 7
#>   term        estimate std.error statistic  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept)   19.7       5.25       3.76 7.65e- 4    9.00      30.5 
#> 2 wt            -5.05      0.484    -10.4  2.52e-11   -6.04      -4.06
#> 3 qsec           0.929     0.265      3.51 1.50e- 3    0.387      1.47

# equivalent to the above
tidy(modsumm, conf.int = TRUE)
#> # A tibble: 3 × 7
#>   term        estimate std.error statistic  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept)   19.7       5.25       3.76 7.65e- 4    9.00      30.5 
#> 2 wt            -5.05      0.484    -10.4  2.52e-11   -6.04      -4.06
#> 3 qsec           0.929     0.265      3.51 1.50e- 3    0.387      1.47

glance(mod)
#> # A tibble: 1 × 12
#>   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl>
#> 1     0.826         0.814  2.60      69.0 9.39e-12     2  -74.4  157.
#> # ℹ 4 more variables: BIC <dbl>, deviance <dbl>, df.residual <int>,
#> #   nobs <int>

# mostly the same, except for a few missing columns
glance(modsumm)
#> # A tibble: 1 × 8
#>   r.squared adj.r.squared sigma statistic  p.value    df df.residual
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>       <int>
#> 1     0.826         0.814  2.60      69.0 9.39e-12     2          29
#> # ℹ 1 more variable: nobs <dbl>
```
