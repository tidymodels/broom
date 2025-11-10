# Glance at a(n) rlm object

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
# S3 method for class 'rlm'
glance(x, ...)
```

## Arguments

- x:

  An `rlm` object returned by
  [`MASS::rlm()`](https://rdrr.io/pkg/MASS/man/rlm.html).

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
[`MASS::rlm()`](https://rdrr.io/pkg/MASS/man/rlm.html)

Other rlm tidiers:
[`augment.rlm()`](https://broom.tidymodels.org/dev/reference/augment.rlm.md),
[`tidy.rlm()`](https://broom.tidymodels.org/dev/reference/tidy.rlm.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- converged:

  Logical indicating if the model fitting procedure was succesful and
  converged.

- deviance:

  Deviance of the model.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- sigma:

  Estimated standard error of the residuals.

## Examples

``` r
# load libraries for models and data
library(MASS)

# fit model
r <- rlm(stack.loss ~ ., stackloss)

# summarize model fit with tidiers
tidy(r)
#> # A tibble: 4 × 4
#>   term        estimate std.error statistic
#>   <chr>          <dbl>     <dbl>     <dbl>
#> 1 (Intercept)  -41.0       9.81     -4.18 
#> 2 Air.Flow       0.829     0.111     7.46 
#> 3 Water.Temp     0.926     0.303     3.05 
#> 4 Acid.Conc.    -0.128     0.129    -0.992
augment(r)
#> # A tibble: 21 × 10
#>    stack.loss Air.Flow Water.Temp Acid.Conc. .fitted .resid   .hat
#>         <dbl>    <dbl>      <dbl>      <dbl>   <dbl>  <dbl>  <dbl>
#>  1         42       80         27         89    38.9  3.05  0.327 
#>  2         37       80         27         88    39.1 -2.08  0.343 
#>  3         37       75         25         90    32.8  4.18  0.155 
#>  4         28       62         24         87    21.5  6.50  0.0713
#>  5         18       62         22         87    19.6 -1.65  0.0562
#>  6         18       62         23         87    20.6 -2.57  0.0835
#>  7         19       62         24         93    20.7 -1.73  0.230 
#>  8         20       62         24         93    20.7 -0.731 0.230 
#>  9         15       58         23         87    17.3 -2.25  0.155 
#> 10         14       58         18         80    13.5  0.481 0.213 
#> # ℹ 11 more rows
#> # ℹ 3 more variables: .sigma <dbl>, .cooksd <dbl>, .std.resid <dbl>
glance(r)
#> # A tibble: 1 × 7
#>   sigma converged logLik     AIC   BIC deviance  nobs
#>   <dbl> <lgl>     <logLik> <dbl> <dbl>    <dbl> <int>
#> 1  2.44 TRUE      -52.954   116.  121.     191.    21
```
