# Glance at a(n) drc object

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
# S3 method for class 'drc'
glance(x, ...)
```

## Arguments

- x:

  A `drc` object produced by a call to
  [`drc::drm()`](https://rdrr.io/pkg/drc/man/drm.html).

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
[`drc::drm()`](https://rdrr.io/pkg/drc/man/drm.html)

Other drc tidiers:
[`augment.drc()`](https://broom.tidymodels.org/dev/reference/augment.drc.md),
[`tidy.drc()`](https://broom.tidymodels.org/dev/reference/tidy.drc.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- df.residual:

  Residual degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- AICc:

  AIC corrected for small samples

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
