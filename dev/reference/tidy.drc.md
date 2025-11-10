# Tidy a(n) drc object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'drc'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `drc` object produced by a call to
  [`drc::drm()`](https://rdrr.io/pkg/drc/man/drm.html).

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

## Details

The tibble has one row for each curve and term in the regression. The
`curveid` column indicates the curve.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`drc::drm()`](https://rdrr.io/pkg/drc/man/drm.html)

Other drc tidiers:
[`augment.drc()`](https://broom.tidymodels.org/dev/reference/augment.drc.md),
[`glance.drc()`](https://broom.tidymodels.org/dev/reference/glance.drc.md)

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

- curve:

  Index identifying the curve.

## Examples

``` r
# load libraries for models and data
library(drc)

# fit model
mod <- drm(dead / total ~ conc, type,
  weights = total, data = selenium, fct = LL.2(), type = "binomial"
)

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 8 × 6
#>   term  curve estimate std.error statistic  p.value
#>   <chr> <chr>    <dbl>     <dbl>     <dbl>    <dbl>
#> 1 b     1       -1.50      0.155     -9.67 2.01e-22
#> 2 b     2       -0.843     0.139     -6.06 1.35e- 9
#> 3 b     3       -2.16      0.138    -15.7  1.65e-55
#> 4 b     4       -1.45      0.169     -8.62 3.41e-18
#> 5 e     1      252.       13.8       18.2  1.16e-74
#> 6 e     2      378.       39.4        9.61 3.53e-22
#> 7 e     3      120.        5.91      20.3  1.14e-91
#> 8 e     4       88.8       8.62      10.3  3.28e-25
tidy(mod, conf.int = TRUE)
#> # A tibble: 8 × 8
#>   term  curve estimate std.error statistic  p.value conf.low conf.high
#>   <chr> <chr>    <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 b     1       -1.50      0.155     -9.67 2.01e-22    -1.81    -1.20 
#> 2 b     2       -0.843     0.139     -6.06 1.35e- 9    -1.12    -0.571
#> 3 b     3       -2.16      0.138    -15.7  1.65e-55    -2.43    -1.89 
#> 4 b     4       -1.45      0.169     -8.62 3.41e-18    -1.78    -1.12 
#> 5 e     1      252.       13.8       18.2  1.16e-74   225.     279.   
#> 6 e     2      378.       39.4        9.61 3.53e-22   301.     456.   
#> 7 e     3      120.        5.91      20.3  1.14e-91   108.     131.   
#> 8 e     4       88.8       8.62      10.3  3.28e-25    71.9    106.   

glance(mod)
#> # A tibble: 1 × 4
#>     AIC   BIC logLik    df.residual
#>   <dbl> <dbl> <logLik>        <int>
#> 1  768.  778. -376.2099          17

augment(mod, selenium)
#> # A tibble: 25 × 7
#>     type  conc total  dead .fitted  .resid    .cooksd
#>    <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>      <dbl>
#>  1     1     0   151     3   0      0.0199 0         
#>  2     1   100   146    40   0.199  0.0748 0.0000909 
#>  3     1   200   116    31   0.414 -0.146  0.000104  
#>  4     1   300   159    85   0.565 -0.0302 0.00000516
#>  5     1   400   150   102   0.667  0.0133 0.00000220
#>  6     1   500   140   112   0.737  0.0633 0.0000720 
#>  7     2     0   141     2   0      0.0142 0         
#>  8     2   100   153    30   0.246 -0.0495 0.000168  
#>  9     2   200   142    59   0.369  0.0468 0.0000347 
#> 10     2   300   139    82   0.451  0.139  0.0000430 
#> # ℹ 15 more rows
```
