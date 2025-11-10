# Tidy a(n) ivreg object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'ivreg'
tidy(x, conf.int = FALSE, conf.level = 0.95, instruments = FALSE, ...)
```

## Arguments

- x:

  An `ivreg` object created by a call to
  [`AER::ivreg()`](https://rdrr.io/pkg/AER/man/ivreg.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- instruments:

  Logical indicating whether to return coefficients from the
  second-stage or diagnostics tests for each endogenous regressor
  (F-statistics). Defaults to `FALSE`.

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

This tidier currently only supports `ivreg`-classed objects outputted by
the `AER` package. The `ivreg` package also outputs objects of class
`ivreg`, and will be supported in a later release.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`AER::ivreg()`](https://rdrr.io/pkg/AER/man/ivreg.html)

Other ivreg tidiers:
[`augment.ivreg()`](https://broom.tidymodels.org/dev/reference/augment.ivreg.md),
[`glance.ivreg()`](https://broom.tidymodels.org/dev/reference/glance.ivreg.md)

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

- p.value.Sargan:

  p-value for Sargan test of overidentifying restrictions.

- p.value.weakinst:

  p-value for weak instruments test.

- p.value.Wu.Hausman:

  p-value for Wu-Hausman weak instruments test for endogeneity.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- statistic.Sargan:

  Statistic for Sargan test of overidentifying restrictions.

- statistic.weakinst:

  Statistic for Wu-Hausman test.

- statistic.Wu.Hausman:

  Statistic for Wu-Hausman weak instruments test for endogeneity.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

## Examples

``` r
# load libraries for models and data
library(AER)

# load data
data("CigarettesSW", package = "AER")

# fit model
ivr <- ivreg(
  log(packs) ~ income | population,
  data = CigarettesSW,
  subset = year == "1995"
)

# summarize model fit with tidiers
tidy(ivr)
#> # A tibble: 2 × 5
#>   term         estimate std.error statistic  p.value
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)  4.61e+ 0  4.45e- 2    104.   3.74e-56
#> 2 income      -5.71e-10  2.33e-10     -2.44 1.84e- 2
tidy(ivr, conf.int = TRUE)
#> # A tibble: 2 × 7
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept)  4.61e+ 0  4.45e- 2    104.   3.74e-56  4.52e+0  4.70e+ 0
#> 2 income      -5.71e-10  2.33e-10     -2.44 1.84e- 2 -1.03e-9 -1.13e-10
tidy(ivr, conf.int = TRUE, instruments = TRUE)
#> # A tibble: 1 × 5
#>   term   num.df den.df statistic  p.value
#>   <chr>   <dbl>  <dbl>     <dbl>    <dbl>
#> 1 income      1     46     3329. 1.46e-44

augment(ivr)
#> # A tibble: 48 × 6
#>    .rownames `log(packs)`    income population .fitted  .resid
#>    <chr>            <dbl>     <dbl>      <dbl>   <dbl>   <dbl>
#>  1 49                4.62  83903280    4262731    4.56  0.0522
#>  2 50                4.71  45995496    2480121    4.59  0.124 
#>  3 51                4.28  88870496    4306908    4.56 -0.285 
#>  4 52                4.04 771470144   31493524    4.17 -0.131 
#>  5 53                4.41  92946544    3738061    4.56 -0.145 
#>  6 54                4.38 104315120    3265293    4.55 -0.177 
#>  7 55                4.82  18237436     718265    4.60  0.223 
#>  8 56                4.53 333525344   14185403    4.42  0.112 
#>  9 57                4.58 159800448    7188538    4.52  0.0591
#> 10 58                4.53  60170928    2840860    4.58 -0.0512
#> # ℹ 38 more rows
augment(ivr, data = CigarettesSW)
#> # A tibble: 96 × 11
#>    state year    cpi population packs  income   tax price  taxs .fitted
#>    <fct> <fct> <dbl>      <dbl> <dbl>   <dbl> <dbl> <dbl> <dbl>   <dbl>
#>  1 AL    1985   1.08    3973000  116.  4.60e7  32.5 102.   33.3    4.56
#>  2 AR    1985   1.08    2327000  129.  2.62e7  37   101.   37      4.59
#>  3 AZ    1985   1.08    3184000  105.  4.40e7  31   109.   36.2    4.56
#>  4 CA    1985   1.08   26444000  100.  4.47e8  26   108.   32.1    4.17
#>  5 CO    1985   1.08    3209000  113.  4.95e7  31    94.3  31      4.56
#>  6 CT    1985   1.08    3201000  109.  6.01e7  42   128.   51.5    4.55
#>  7 DE    1985   1.08     618000  144.  9.93e6  30   102.   30      4.60
#>  8 FL    1985   1.08   11352000  122.  1.67e8  37   115.   42.5    4.42
#>  9 GA    1985   1.08    5963000  127.  7.84e7  28    97.0  28.8    4.52
#> 10 IA    1985   1.08    2830000  114.  3.79e7  34   102.   37.9    4.58
#> # ℹ 86 more rows
#> # ℹ 1 more variable: .resid <dbl>
augment(ivr, newdata = CigarettesSW)
#> # A tibble: 96 × 10
#>    state year    cpi population packs  income   tax price  taxs .fitted
#>    <fct> <fct> <dbl>      <dbl> <dbl>   <dbl> <dbl> <dbl> <dbl>   <dbl>
#>  1 AL    1985   1.08    3973000  116.  4.60e7  32.5 102.   33.3    4.59
#>  2 AR    1985   1.08    2327000  129.  2.62e7  37   101.   37      4.60
#>  3 AZ    1985   1.08    3184000  105.  4.40e7  31   109.   36.2    4.59
#>  4 CA    1985   1.08   26444000  100.  4.47e8  26   108.   32.1    4.36
#>  5 CO    1985   1.08    3209000  113.  4.95e7  31    94.3  31      4.58
#>  6 CT    1985   1.08    3201000  109.  6.01e7  42   128.   51.5    4.58
#>  7 DE    1985   1.08     618000  144.  9.93e6  30   102.   30      4.61
#>  8 FL    1985   1.08   11352000  122.  1.67e8  37   115.   42.5    4.52
#>  9 GA    1985   1.08    5963000  127.  7.84e7  28    97.0  28.8    4.57
#> 10 IA    1985   1.08    2830000  114.  3.79e7  34   102.   37.9    4.59
#> # ℹ 86 more rows

glance(ivr)
#> # A tibble: 1 × 8
#>   r.squared adj.r.squared sigma statistic p.value    df df.residual
#>       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <int>       <int>
#> 1     0.131         0.112 0.229      5.98  0.0184     2          46
#> # ℹ 1 more variable: nobs <int>
```
