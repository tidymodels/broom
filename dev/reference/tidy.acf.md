# Tidy a(n) acf object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'acf'
tidy(x, ...)
```

## Arguments

- x:

  An `acf` object created by
  [`stats::acf()`](https://rdrr.io/r/stats/acf.html),
  [`stats::pacf()`](https://rdrr.io/r/stats/acf.html) or
  [`stats::ccf()`](https://rdrr.io/r/stats/acf.html).

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
[`stats::acf()`](https://rdrr.io/r/stats/acf.html),
[`stats::pacf()`](https://rdrr.io/r/stats/acf.html),
[`stats::ccf()`](https://rdrr.io/r/stats/acf.html)

Other time series tidiers:
[`tidy.spec()`](https://broom.tidymodels.org/dev/reference/tidy.spec.md),
[`tidy.ts()`](https://broom.tidymodels.org/dev/reference/tidy.ts.md),
[`tidy.zoo()`](https://broom.tidymodels.org/dev/reference/tidy.zoo.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- acf:

  Autocorrelation.

- lag:

  Lag values.

## Examples

``` r
tidy(acf(lh, plot = FALSE))
#> # A tibble: 17 × 2
#>      lag      acf
#>    <dbl>    <dbl>
#>  1     0  1      
#>  2     1  0.576  
#>  3     2  0.182  
#>  4     3 -0.145  
#>  5     4 -0.175  
#>  6     5 -0.150  
#>  7     6 -0.0210 
#>  8     7 -0.0203 
#>  9     8 -0.00420
#> 10     9 -0.136  
#> 11    10 -0.154  
#> 12    11 -0.0972 
#> 13    12  0.0490 
#> 14    13  0.120  
#> 15    14  0.0867 
#> 16    15  0.119  
#> 17    16  0.151  
tidy(ccf(mdeaths, fdeaths, plot = FALSE))
#> # A tibble: 31 × 2
#>       lag     acf
#>     <dbl>   <dbl>
#>  1 -1.25   0.0151
#>  2 -1.17   0.366 
#>  3 -1.08   0.615 
#>  4 -1      0.708 
#>  5 -0.917  0.622 
#>  6 -0.833  0.340 
#>  7 -0.75  -0.0245
#>  8 -0.667 -0.382 
#>  9 -0.583 -0.612 
#> 10 -0.5   -0.678 
#> # ℹ 21 more rows
tidy(pacf(lh, plot = FALSE))
#> # A tibble: 16 × 2
#>      lag      acf
#>    <dbl>    <dbl>
#>  1     1  0.576  
#>  2     2 -0.223  
#>  3     3 -0.227  
#>  4     4  0.103  
#>  5     5 -0.0759 
#>  6     6  0.0676 
#>  7     7 -0.104  
#>  8     8  0.0120 
#>  9     9 -0.188  
#> 10    10  0.00255
#> 11    11  0.0656 
#> 12    12  0.0320 
#> 13    13  0.0219 
#> 14    14 -0.0931 
#> 15    15  0.230  
#> 16    16  0.0444 
```
