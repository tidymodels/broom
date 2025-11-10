# Tidy a(n) pairwise.htest object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'pairwise.htest'
tidy(x, ...)
```

## Arguments

- x:

  A `pairwise.htest` object such as those returned from
  [`stats::pairwise.t.test()`](https://rdrr.io/r/stats/pairwise.t.test.html)
  or
  [`stats::pairwise.wilcox.test()`](https://rdrr.io/r/stats/pairwise.wilcox.test.html).

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

Note that in one-sided tests, the alternative hypothesis of each test
can be stated as "group1 is greater/less than group2".

Note also that the columns of group1 and group2 will always be a factor,
even if the original input is (e.g.) numeric.

## See also

[`stats::pairwise.t.test()`](https://rdrr.io/r/stats/pairwise.t.test.html),
[`stats::pairwise.wilcox.test()`](https://rdrr.io/r/stats/pairwise.wilcox.test.html),
[`tidy()`](https://generics.r-lib.org/reference/tidy.html)

Other htest tidiers:
[`augment.htest()`](https://broom.tidymodels.org/dev/reference/augment.htest.md),
[`tidy.htest()`](https://broom.tidymodels.org/dev/reference/tidy.htest.md),
[`tidy.power.htest()`](https://broom.tidymodels.org/dev/reference/tidy.power.htest.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- group1:

  First group being compared.

- group2:

  Second group being compared.

- p.value:

  The two-sided p-value associated with the observed statistic.

## Examples

``` r
attach(airquality)
Month <- factor(Month, labels = month.abb[5:9])
ptt <- pairwise.t.test(Ozone, Month)
tidy(ptt)
#> # A tibble: 10 × 3
#>    group1 group2  p.value
#>    <chr>  <chr>     <dbl>
#>  1 Jun    May    1       
#>  2 Jul    May    0.000264
#>  3 Jul    Jun    0.0511  
#>  4 Aug    May    0.000195
#>  5 Aug    Jun    0.0499  
#>  6 Aug    Jul    1       
#>  7 Sep    May    1       
#>  8 Sep    Jun    1       
#>  9 Sep    Jul    0.00488 
#> 10 Sep    Aug    0.00388 

library(modeldata)
data(hpc_data)
attach(hpc_data)
ptt2 <- pairwise.t.test(compounds, class)
tidy(ptt2)
#> # A tibble: 6 × 3
#>   group1 group2   p.value
#>   <chr>  <chr>      <dbl>
#> 1 F      VF     9.28e-  8
#> 2 M      VF     2.55e- 61
#> 3 M      F      4.26e- 34
#> 4 L      VF     2.52e-126
#> 5 L      F      5.44e- 95
#> 6 L      M      2.45e- 25

tidy(pairwise.t.test(compounds, class, alternative = "greater"))
#> # A tibble: 6 × 3
#>   group1 group2   p.value
#>   <chr>  <chr>      <dbl>
#> 1 F      VF     4.64e-  8
#> 2 M      VF     1.27e- 61
#> 3 M      F      2.13e- 34
#> 4 L      VF     1.26e-126
#> 5 L      F      2.72e- 95
#> 6 L      M      1.22e- 25
tidy(pairwise.t.test(compounds, class, alternative = "less"))
#> # A tibble: 6 × 3
#>   group1 group2 p.value
#>   <chr>  <chr>    <dbl>
#> 1 F      VF           1
#> 2 M      VF           1
#> 3 M      F            1
#> 4 L      VF           1
#> 5 L      F            1
#> 6 L      M            1

tidy(pairwise.wilcox.test(compounds, class))
#> # A tibble: 6 × 3
#>   group1 group2  p.value
#>   <chr>  <chr>     <dbl>
#> 1 F      VF     4.85e-32
#> 2 M      VF     2.41e-66
#> 3 M      F      1.45e-23
#> 4 L      VF     1.90e-77
#> 5 L      F      1.28e-42
#> 6 L      M      6.84e- 9
```
