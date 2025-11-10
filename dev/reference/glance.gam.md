# Glance at a(n) gam object

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
# S3 method for class 'gam'
glance(x, ...)
```

## Arguments

- x:

  A `gam` object returned from a call to
  [`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html).

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

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html)

Other mgcv tidiers:
[`tidy.gam()`](https://broom.tidymodels.org/dev/reference/tidy.gam.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- adj.r.squared:

  Adjusted R squared statistic, which is like the R squared statistic
  except taking degrees of freedom into account.

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- deviance:

  Deviance of the model.

- df:

  Degrees of freedom used by the model.

- df.residual:

  Residual degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- npar:

  Number of parameters in the model.

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
