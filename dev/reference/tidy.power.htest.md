# Tidy a(n) power.htest object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'power.htest'
tidy(x, ...)
```

## Arguments

- x:

  A `power.htest` object such as those returned from
  [`stats::power.t.test()`](https://rdrr.io/r/stats/power.t.test.html).

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

[`stats::power.t.test()`](https://rdrr.io/r/stats/power.t.test.html)

Other htest tidiers:
[`augment.htest()`](https://broom.tidymodels.org/dev/reference/augment.htest.md),
[`tidy.htest()`](https://broom.tidymodels.org/dev/reference/tidy.htest.md),
[`tidy.pairwise.htest()`](https://broom.tidymodels.org/dev/reference/tidy.pairwise.htest.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- delta:

  True difference in means.

- n:

  Number of observations by component.

- power:

  Power achieved for given value of n.

- sd:

  Standard deviation.

- sig.level:

  Significance level (Type I error probability).

## Examples

``` r
ptt <- power.t.test(n = 2:30, delta = 1)
tidy(ptt)
#> # A tibble: 29 × 5
#>        n delta    sd sig.level  power
#>    <int> <dbl> <dbl>     <dbl>  <dbl>
#>  1     2     1     1      0.05 0.0913
#>  2     3     1     1      0.05 0.157 
#>  3     4     1     1      0.05 0.222 
#>  4     5     1     1      0.05 0.286 
#>  5     6     1     1      0.05 0.347 
#>  6     7     1     1      0.05 0.406 
#>  7     8     1     1      0.05 0.461 
#>  8     9     1     1      0.05 0.513 
#>  9    10     1     1      0.05 0.562 
#> 10    11     1     1      0.05 0.607 
#> # ℹ 19 more rows

library(ggplot2)

ggplot(tidy(ptt), aes(n, power)) +
  geom_line()
```
