# Glance at a(n) varest object

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
# S3 method for class 'varest'
glance(x, ...)
```

## Arguments

- x:

  A `varest` object produced by a call to
  [`vars::VAR()`](https://rdrr.io/pkg/vars/man/VAR.html).

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
[`vars::VAR()`](https://rdrr.io/pkg/vars/man/VAR.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- lag.order:

  Lag order.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- n:

  The total number of observations.

- nobs:

  Number of observations used.

## Examples

``` r
# load libraries for models and data
library(vars)
#> Loading required package: strucchange
#> Loading required package: urca

# load data
data("Canada", package = "vars")

# fit models
mod <- VAR(Canada, p = 1, type = "both")

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 24 × 6
#>    group term     estimate std.error statistic  p.value
#>    <chr> <chr>       <dbl>     <dbl>     <dbl>    <dbl>
#>  1 e     e.l1       1.24      0.0863    14.4   1.82e-23
#>  2 e     prod.l1    0.195     0.0361     5.39  7.49e- 7
#>  3 e     rw.l1     -0.0678    0.0283    -2.40  1.90e- 2
#>  4 e     U.l1       0.623     0.169      3.68  4.30e- 4
#>  5 e     const   -279.       75.2       -3.71  3.92e- 4
#>  6 e     trend     -0.0407    0.0197    -2.06  4.24e- 2
#>  7 prod  e.l1       0.0129    0.126      0.103 9.19e- 1
#>  8 prod  prod.l1    0.963     0.0527    18.3   9.43e-30
#>  9 prod  rw.l1     -0.0391    0.0412    -0.948 3.46e- 1
#> 10 prod  U.l1       0.211     0.247      0.855 3.95e- 1
#> # ℹ 14 more rows
glance(mod)
#> # A tibble: 1 × 4
#>   lag.order logLik  nobs     n
#>       <dbl>  <dbl> <dbl> <dbl>
#> 1         1  -208.    83    84
```
