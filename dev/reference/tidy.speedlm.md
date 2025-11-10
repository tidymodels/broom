# Tidy a(n) speedlm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'speedlm'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `speedlm` object returned from
  [`speedglm::speedlm()`](https://rdrr.io/pkg/speedglm/man/speedlm.html).

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

[`speedglm::speedlm()`](https://rdrr.io/pkg/speedglm/man/speedlm.html),
[`tidy.lm()`](https://broom.tidymodels.org/dev/reference/tidy.lm.md)

Other speedlm tidiers:
[`augment.speedlm()`](https://broom.tidymodels.org/dev/reference/augment.speedlm.md),
[`glance.speedglm()`](https://broom.tidymodels.org/dev/reference/glance.speedglm.md),
[`glance.speedlm()`](https://broom.tidymodels.org/dev/reference/glance.speedlm.md),
[`tidy.speedglm()`](https://broom.tidymodels.org/dev/reference/tidy.speedglm.md)

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
library(speedglm)

# fit model
mod <- speedlm(mpg ~ wt + qsec, data = mtcars, fitted = TRUE)

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 3 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)   19.7       5.25       3.76 7.65e- 4
#> 2 wt            -5.05      0.484    -10.4  2.52e-11
#> 3 qsec           0.929     0.265      3.51 1.50e- 3
glance(mod)
#> # A tibble: 1 × 11
#>   r.squared adj.r.squared statistic  p.value    df logLik   AIC   BIC
#>       <dbl>         <dbl>     <dbl>    <dbl> <int>  <dbl> <dbl> <dbl>
#> 1     0.826         0.814      69.0 9.39e-12     3  -74.4  157.  163.
#> # ℹ 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>
augment(mod)
#> # A tibble: 32 × 6
#>    .rownames           mpg    wt  qsec .fitted  .resid
#>    <chr>             <dbl> <dbl> <dbl>   <dbl>   <dbl>
#>  1 Mazda RX4          21    2.62  16.5    21.8 -0.815 
#>  2 Mazda RX4 Wag      21    2.88  17.0    21.0 -0.0482
#>  3 Datsun 710         22.8  2.32  18.6    25.3 -2.53  
#>  4 Hornet 4 Drive     21.4  3.22  19.4    21.6 -0.181 
#>  5 Hornet Sportabout  18.7  3.44  17.0    18.2  0.504 
#>  6 Valiant            18.1  3.46  20.2    21.1 -2.97  
#>  7 Duster 360         14.3  3.57  15.8    16.4 -2.14  
#>  8 Merc 240D          24.4  3.19  20      22.2  2.17  
#>  9 Merc 230           22.8  3.15  22.9    25.1 -2.32  
#> 10 Merc 280           19.2  3.44  18.3    19.4 -0.185 
#> # ℹ 22 more rows
```
