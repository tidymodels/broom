# Glance at a(n) mlogit object

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
# S3 method for class 'mlogit'
glance(x, ...)
```

## Arguments

- x:

  an object returned from
  [`mlogit::mlogit()`](https://rdrr.io/pkg/mlogit/man/mlogit.html).

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
[`mlogit::mlogit()`](https://rdrr.io/pkg/mlogit/man/mlogit.html)

Other mlogit tidiers:
[`augment.mlogit()`](https://broom.tidymodels.org/dev/reference/augment.mlogit.md),
[`tidy.mlogit()`](https://broom.tidymodels.org/dev/reference/tidy.mlogit.md)

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

- rho2:

  McFadden's rho squared with respect to a market shares
  (constants-only) model.

- rho20:

  McFadden's rho squared with respect to an equal shares (no
  information) model.

## Examples

``` r
# load libraries for models and data
library(mlogit)

data("Fishing", package = "mlogit")
Fish <- dfidx(Fishing, varying = 2:9, shape = "wide", choice = "mode")

# fit model
m <- mlogit(mode ~ price + catch | income, data = Fish)

# summarize model fit with tidiers
tidy(m)
#> # A tibble: 8 × 5
#>   term                  estimate std.error statistic  p.value
#>   <chr>                    <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept):boat     0.527     0.223         2.37  1.79e- 2
#> 2 (Intercept):charter  1.69      0.224         7.56  3.95e-14
#> 3 (Intercept):pier     0.778     0.220         3.53  4.18e- 4
#> 4 price               -0.0251    0.00173     -14.5   0       
#> 5 catch                0.358     0.110         3.26  1.12e- 3
#> 6 income:boat          0.0000894 0.0000501     1.79  7.40e- 2
#> 7 income:charter      -0.0000333 0.0000503    -0.661 5.08e- 1
#> 8 income:pier         -0.000128  0.0000506    -2.52  1.18e- 2
augment(m)
#> # A tibble: 4,728 × 9
#>       id alternative chosen price  catch income .probability .fitted
#>    <int> <fct>       <lgl>  <dbl>  <dbl>  <dbl>        <dbl>   <dbl>
#>  1     1 beach       FALSE  158.  0.0678  7083.      0.125    -3.94 
#>  2     1 boat        FALSE  158.  0.260   7083.      0.427    -2.71 
#>  3     1 charter     TRUE   183.  0.539   7083.      0.339    -2.94 
#>  4     1 pier        FALSE  158.  0.0503  7083.      0.109    -4.07 
#>  5     2 beach       FALSE   15.1 0.105   1250.      0.116    -0.342
#>  6     2 boat        FALSE   10.5 0.157   1250.      0.251     0.431
#>  7     2 charter     TRUE    34.5 0.467   1250.      0.423     0.952
#>  8     2 pier        FALSE   15.1 0.0451  1250.      0.210     0.255
#>  9     3 beach       FALSE  162.  0.533   3750.      0.00689  -3.87 
#> 10     3 boat        TRUE    24.3 0.241   3750.      0.465     0.338
#> # ℹ 4,718 more rows
#> # ℹ 1 more variable: .resid <dbl>
glance(m)
#> # A tibble: 1 × 6
#>   logLik  rho2 rho20   AIC   BIC  nobs
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <int>
#> 1 -1215. 0.189 0.258 2446.    NA  1182
```
