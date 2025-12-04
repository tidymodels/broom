# Tidy a(n) garch object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'garch'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `garch` object returned by
  [`tseries::garch()`](https://rdrr.io/pkg/tseries/man/garch.html).

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

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`tseries::garch()`](https://rdrr.io/pkg/tseries/man/garch.html)

Other garch tidiers:
[`glance.garch()`](https://broom.tidymodels.org/dev/reference/glance.garch.md)

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
# load libraries for models and data
library(tseries)

# load data
data(EuStockMarkets)

# fit model
dax <- diff(log(EuStockMarkets))[, "DAX"]
dax.garch <- garch(dax)
#> 
#>  ***** ESTIMATION WITH ANALYTICAL GRADIENT ***** 
#> 
#> 
#>      I     INITIAL X(I)        D(I)
#> 
#>      1     9.549651e-05     1.000e+00
#>      2     5.000000e-02     1.000e+00
#>      3     5.000000e-02     1.000e+00
#> 
#>     IT   NF      F         RELDF    PRELDF    RELDX   STPPAR   D*STEP   NPRELDF
#>      0    1 -7.584e+03
#>      1    8 -7.585e+03  1.45e-05  2.60e-05  1.4e-05  1.0e+11  1.4e-06  1.35e+06
#>      2    9 -7.585e+03  1.88e-07  1.97e-07  1.3e-05  2.0e+00  1.4e-06  1.50e+00
#>      3   18 -7.589e+03  6.22e-04  1.10e-03  3.5e-01  2.0e+00  5.5e-02  1.50e+00
#>      4   21 -7.601e+03  1.58e-03  1.81e-03  6.2e-01  1.9e+00  2.2e-01  3.07e-01
#>      5   23 -7.634e+03  4.22e-03  3.55e-03  4.3e-01  9.6e-01  4.4e-01  3.06e-02
#>      6   25 -7.646e+03  1.61e-03  1.85e-03  2.9e-02  2.0e+00  4.4e-02  5.43e-02
#>      7   27 -7.646e+03  3.82e-05  5.23e-04  1.3e-02  2.0e+00  2.0e-02  1.46e-02
#>      8   28 -7.648e+03  1.86e-04  1.46e-04  6.5e-03  2.0e+00  9.9e-03  1.54e-03
#>      9   29 -7.648e+03  3.12e-05  4.83e-05  6.4e-03  2.0e+00  9.9e-03  3.34e-03
#>     10   30 -7.648e+03  1.39e-05  6.31e-05  6.2e-03  1.9e+00  9.9e-03  1.86e-03
#>     11   31 -7.650e+03  2.70e-04  3.24e-04  6.0e-03  1.9e+00  9.9e-03  4.99e-03
#>     12   34 -7.656e+03  8.42e-04  8.57e-04  2.2e-02  1.7e-01  3.9e-02  2.22e-03
#>     13   36 -7.661e+03  6.12e-04  6.40e-04  1.9e-02  4.2e-01  3.9e-02  2.09e-03
#>     14   38 -7.665e+03  4.87e-04  8.63e-04  4.9e-02  4.1e-01  9.6e-02  9.69e-04
#>     15   48 -7.666e+03  1.02e-04  1.86e-04  1.9e-07  4.5e+00  3.5e-07  3.94e-04
#>     16   49 -7.666e+03  1.12e-07  1.01e-07  1.9e-07  2.0e+00  3.5e-07  6.22e-05
#>     17   57 -7.666e+03  1.60e-05  2.70e-05  2.0e-03  9.3e-01  3.7e-03  6.10e-05
#>     18   59 -7.666e+03  5.23e-06  7.01e-06  3.7e-03  3.9e-01  8.0e-03  7.77e-06
#>     19   60 -7.666e+03  4.08e-08  3.74e-08  1.4e-04  0.0e+00  3.1e-04  3.74e-08
#>     20   61 -7.666e+03  2.31e-09  8.57e-10  8.6e-06  0.0e+00  2.0e-05  8.57e-10
#>     21   62 -7.666e+03  5.35e-11  2.25e-13  7.6e-07  0.0e+00  1.6e-06  2.25e-13
#>     22   63 -7.666e+03  1.81e-12  7.06e-16  1.7e-08  0.0e+00  3.4e-08  7.06e-16
#>     23   64 -7.666e+03  7.00e-14  1.69e-17  1.0e-09  0.0e+00  2.4e-09  1.69e-17
#>     24   65 -7.666e+03 -1.16e-14  1.76e-20  1.9e-10  0.0e+00  4.0e-10  1.76e-20
#> 
#>  ***** X- AND RELATIVE FUNCTION CONVERGENCE *****
#> 
#>  FUNCTION    -7.665775e+03   RELDX        1.874e-10
#>  FUNC. EVALS      65         GRAD. EVALS      24
#>  PRELDF       1.760e-20      NPRELDF      1.760e-20
#> 
#>      I      FINAL X(I)        D(I)          G(I)
#> 
#>      1    4.639289e-06     1.000e+00    -2.337e-02
#>      2    6.832875e-02     1.000e+00    -8.294e-07
#>      3    8.890666e-01     1.000e+00    -2.230e-06
#> 
dax.garch
#> 
#> Call:
#> garch(x = dax)
#> 
#> Coefficient(s):
#>        a0         a1         b1  
#> 4.639e-06  6.833e-02  8.891e-01  
#> 

# summarize model fit with tidiers
tidy(dax.garch)
#> # A tibble: 3 × 5
#>   term    estimate   std.error statistic  p.value
#>   <chr>      <dbl>       <dbl>     <dbl>    <dbl>
#> 1 a0    0.00000464 0.000000756      6.14 8.42e-10
#> 2 a1    0.0683     0.0113           6.07 1.25e- 9
#> 3 b1    0.889      0.0165          53.8  0       
glance(dax.garch)
#> # A tibble: 1 × 8
#>   statistic p.value parameter method       logLik     AIC     BIC  nobs
#>       <dbl>   <dbl>     <dbl> <chr>         <dbl>   <dbl>   <dbl> <int>
#> 1     0.136   0.713         1 Box-Ljung t…  5958. -11911. -11894.  1859
```
