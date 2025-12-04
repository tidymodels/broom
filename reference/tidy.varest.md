# Tidy a(n) varest object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'varest'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `varest` object produced by a call to
  [`vars::VAR()`](https://rdrr.io/pkg/vars/man/VAR.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- ...:

  For [`glance()`](https://generics.r-lib.org/reference/glance.html),
  additional arguments passed to
  [`summary()`](https://rdrr.io/pkg/vars/man/summary.html). Otherwise
  ignored.

## Details

The tibble has one row for each term in the regression. The `component`
column indicates whether a particular term was used to model either the
`"mean"` or `"precision"`. Here the precision is the inverse of the
variance, often referred to as `phi`. At least one term will have been
used to model the precision `phi`.

The `vars` package does not include a `confint` method and does not
report confidence intervals for `varest` objects. Setting the `tidy`
argument `conf.int = TRUE` will return a warning.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`vars::VAR()`](https://rdrr.io/pkg/vars/man/VAR.html)

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

- component:

  Whether a particular term was used to model the mean or the precision
  in the regression. See details.

## Examples

``` r
# load libraries for models and data
library(vars)

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
