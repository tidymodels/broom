# Tidy a(n) gam object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'gam'
tidy(
  x,
  parametric = FALSE,
  conf.int = FALSE,
  conf.level = 0.95,
  exponentiate = FALSE,
  ...
)
```

## Arguments

- x:

  A `gam` object returned from a call to
  [`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html).

- parametric:

  Logical indicating if parametric or smooth terms should be tidied.
  Defaults to `FALSE`, meaning that smooth terms are tidied by default.

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

When `parametric = FALSE` return columns `edf` and `ref.df` rather than
`estimate` and `std.error`.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html)

Other mgcv tidiers:
[`glance.gam()`](https://broom.tidymodels.org/dev/reference/glance.gam.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

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

- edf:

  The effective degrees of freedom. Only reported when \`parametric =
  FALSE\`

- ref.df:

  The reference degrees of freedom. Only reported when \`parametric =
  FALSE\`

## Examples

``` r
# load libraries for models and data
library(mgcv)

# fit model
g <- gam(mpg ~ s(hp) + am + qsec, data = mtcars)

# summarize model fit with tidiers
tidy(g)
#> # A tibble: 1 × 5
#>   term    edf ref.df statistic p.value
#>   <chr> <dbl>  <dbl>     <dbl>   <dbl>
#> 1 s(hp)  2.36   3.02      6.34 0.00218
tidy(g, parametric = TRUE)
#> # A tibble: 3 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)  16.7        9.83      1.70  0.101  
#> 2 am            4.37       1.56      2.81  0.00918
#> 3 qsec          0.0904     0.525     0.172 0.865  
glance(g)
#> # A tibble: 1 × 9
#>      df logLik   AIC   BIC deviance df.residual  nobs adj.r.squared
#>   <dbl>  <dbl> <dbl> <dbl>    <dbl>       <dbl> <int>         <dbl>
#> 1  5.36  -74.4  162.  171.     196.        26.6    32         0.797
#> # ℹ 1 more variable: npar <int>
augment(g)
#> # A tibble: 32 × 11
#>    .rownames        mpg    am  qsec    hp .fitted .se.fit .resid   .hat
#>    <chr>          <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 Mazda RX4       21       1  16.5   110    24.3   1.03  -3.25  0.145 
#>  2 Mazda RX4 Wag   21       1  17.0   110    24.3   0.925 -3.30  0.116 
#>  3 Datsun 710      22.8     1  18.6    93    26.0   0.894 -3.22  0.109 
#>  4 Hornet 4 Drive  21.4     0  19.4   110    20.2   0.827  1.25  0.0930
#>  5 Hornet Sporta…  18.7     0  17.0   175    15.7   0.815  3.02  0.0902
#>  6 Valiant         18.1     0  20.2   105    20.7   0.914 -2.56  0.113 
#>  7 Duster 360      14.3     0  15.8   245    12.7   1.11   1.63  0.167 
#>  8 Merc 240D       24.4     0  20      62    25.0   1.45  -0.618 0.287 
#>  9 Merc 230        22.8     0  22.9    95    21.8   1.81   0.959 0.446 
#> 10 Merc 280        19.2     0  18.3   123    19.0   0.864  0.211 0.102 
#> # ℹ 22 more rows
#> # ℹ 2 more variables: .sigma <lgl>, .cooksd <dbl>
```
