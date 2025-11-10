# Tidy a(n) lavaan object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'lavaan'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `lavaan` object, such as those returned from
  [`lavaan::cfa()`](https://rdrr.io/pkg/lavaan/man/cfa.html), and
  [`lavaan::sem()`](https://rdrr.io/pkg/lavaan/man/sem.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- ...:

  Additional arguments passed to
  [`lavaan::parameterEstimates()`](https://rdrr.io/pkg/lavaan/man/parameterEstimates.html).
  **Cautionary note**: Misspecified arguments may be silently ignored.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with one row for each estimated parameter and columns:

- term:

  The result of paste(lhs, op, rhs)

- op:

  The operator in the model syntax (e.g. `~~` for covariances, or `~`
  for regression parameters)

- group:

  The group (if specified) in the lavaan model

- estimate:

  The parameter estimate (may be standardized)

- std.error:

- statistic:

  The z value returned by
  [`lavaan::parameterEstimates()`](https://rdrr.io/pkg/lavaan/man/parameterEstimates.html)

- p.value:

- conf.low:

- conf.high:

- std.lv:

  Standardized estimates based on the variances of the (continuous)
  latent variables only

- std.all:

  Standardized estimates based on both the variances of both
  (continuous) observed and latent variables.

- std.nox:

  Standardized estimates based on both the variances of both
  (continuous) observed and latent variables, but not the variances of
  exogenous covariates.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`lavaan::cfa()`](https://rdrr.io/pkg/lavaan/man/cfa.html),
[`lavaan::sem()`](https://rdrr.io/pkg/lavaan/man/sem.html),
[`lavaan::parameterEstimates()`](https://rdrr.io/pkg/lavaan/man/parameterEstimates.html)

Other lavaan tidiers:
[`glance.lavaan()`](https://broom.tidymodels.org/dev/reference/glance.lavaan.md)

## Examples

``` r
# load libraries for models and data
library(lavaan)

cfa.fit <- cfa("F =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9",
  data = HolzingerSwineford1939, group = "school"
)

tidy(cfa.fit)
#> # A tibble: 58 × 10
#>    term  op    block group estimate std.error statistic  p.value std.lv
#>    <chr> <chr> <int> <int>    <dbl>     <dbl>     <dbl>    <dbl>  <dbl>
#>  1 F =~… =~        1     1    1         0         NA    NA        0.567
#>  2 F =~… =~        1     1    0.333     0.190      1.76  7.89e-2  0.189
#>  3 F =~… =~        1     1    0.400     0.182      2.20  2.80e-2  0.227
#>  4 F =~… =~        1     1    1.66      0.280      5.92  3.28e-9  0.941
#>  5 F =~… =~        1     1    1.92      0.323      5.95  2.60e-9  1.09 
#>  6 F =~… =~        1     1    1.48      0.247      5.98  2.23e-9  0.837
#>  7 F =~… =~        1     1    0.453     0.173      2.61  8.96e-3  0.257
#>  8 F =~… =~        1     1    0.376     0.155      2.43  1.51e-2  0.213
#>  9 F =~… =~        1     1    0.422     0.159      2.66  7.80e-3  0.240
#> 10 x1 ~… ~~        1     1    1.07      0.127      8.47  0        1.07 
#> # ℹ 48 more rows
#> # ℹ 1 more variable: std.all <dbl>
```
