# Tidy a(n) ts object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'ts'
tidy(x, ...)
```

## Arguments

- x:

  A univariate or multivariate `ts` times series object.

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

`series` column is only present for multivariate `ts` objects.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`stats::ts()`](https://rdrr.io/r/stats/ts.html)

Other time series tidiers:
[`tidy.acf()`](https://broom.tidymodels.org/dev/reference/tidy.acf.md),
[`tidy.spec()`](https://broom.tidymodels.org/dev/reference/tidy.spec.md),
[`tidy.zoo()`](https://broom.tidymodels.org/dev/reference/tidy.zoo.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- index:

  Index (i.e. date or time) for a \`ts\` or \`zoo\` object.

- series:

  Name of the series (present only for multivariate time series).

- value:

  The value/estimate of the component. Results from data reshaping.

## Examples

``` r
set.seed(678)

tidy(ts(1:10, frequency = 4, start = c(1959, 2)))
#> # A tibble: 10 × 2
#>    index value
#>    <dbl> <int>
#>  1 1959.     1
#>  2 1960.     2
#>  3 1960.     3
#>  4 1960      4
#>  5 1960.     5
#>  6 1960.     6
#>  7 1961.     7
#>  8 1961      8
#>  9 1961.     9
#> 10 1962.    10

z <- ts(matrix(rnorm(300), 100, 3), start = c(1961, 1), frequency = 12)
colnames(z) <- c("Aa", "Bb", "Cc")

tidy(z)
#> # A tibble: 300 × 3
#>    index series  value
#>    <dbl> <chr>   <dbl>
#>  1 1961  Aa     -0.773
#>  2 1961  Bb      0.855
#>  3 1961  Cc     -1.43 
#>  4 1961. Aa      0.933
#>  5 1961. Bb     -0.738
#>  6 1961. Cc     -2.55 
#>  7 1961. Aa      0.466
#>  8 1961. Bb      2.37 
#>  9 1961. Cc      1.22 
#> 10 1961. Aa     -1.08 
#> # ℹ 290 more rows
```
