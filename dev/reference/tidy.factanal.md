# Tidy a(n) factanal object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'factanal'
tidy(x, ...)
```

## Arguments

- x:

  A `factanal` object created by
  [`stats::factanal()`](https://rdrr.io/r/stats/factanal.html).

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
[`stats::factanal()`](https://rdrr.io/r/stats/factanal.html)

Other factanal tidiers:
[`augment.factanal()`](https://broom.tidymodels.org/dev/reference/augment.factanal.md),
[`glance.factanal()`](https://broom.tidymodels.org/dev/reference/glance.factanal.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- variable:

  Variable under consideration.

- uniqueness:

  Proportion of residual, or unexplained variance

- flX:

  Factor loading for level X.

## Examples

``` r
set.seed(123)

# generate data
library(dplyr)
library(purrr)

m1 <- tibble(
  v1 = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 4, 5, 6),
  v2 = c(1, 2, 1, 1, 1, 1, 2, 1, 2, 1, 3, 4, 3, 3, 3, 4, 6, 5),
  v3 = c(3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 4, 6),
  v4 = c(3, 3, 4, 3, 3, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 5, 6, 4),
  v5 = c(1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 6, 4, 5),
  v6 = c(1, 1, 1, 2, 1, 3, 3, 3, 4, 3, 1, 1, 1, 2, 1, 6, 5, 4)
)

# new data
m2 <- map_dfr(m1, rev)

# factor analysis objects
fit1 <- factanal(m1, factors = 3, scores = "Bartlett")
fit2 <- factanal(m1, factors = 3, scores = "regression")

# tidying the object
tidy(fit1)
#> # A tibble: 6 × 5
#>   variable uniqueness   fl1   fl2   fl3
#>   <chr>         <dbl> <dbl> <dbl> <dbl>
#> 1 v1           0.005  0.944 0.182 0.267
#> 2 v2           0.101  0.905 0.235 0.159
#> 3 v3           0.005  0.236 0.210 0.946
#> 4 v4           0.224  0.180 0.242 0.828
#> 5 v5           0.0843 0.242 0.881 0.286
#> 6 v6           0.005  0.193 0.959 0.196
tidy(fit2)
#> # A tibble: 6 × 5
#>   variable uniqueness   fl1   fl2   fl3
#>   <chr>         <dbl> <dbl> <dbl> <dbl>
#> 1 v1           0.005  0.944 0.182 0.267
#> 2 v2           0.101  0.905 0.235 0.159
#> 3 v3           0.005  0.236 0.210 0.946
#> 4 v4           0.224  0.180 0.242 0.828
#> 5 v5           0.0843 0.242 0.881 0.286
#> 6 v6           0.005  0.193 0.959 0.196

# augmented dataframe
augment(fit1)
#> # A tibble: 18 × 4
#>    .rownames   .fs1   .fs2   .fs3
#>    <chr>      <dbl>  <dbl>  <dbl>
#>  1 1         -0.904 -0.931  0.948
#>  2 2         -0.869 -0.933  0.935
#>  3 3         -0.908 -0.932  0.962
#>  4 4         -1.00  -0.253  0.818
#>  5 5         -0.904 -0.931  0.948
#>  6 6         -0.745  0.727 -0.788
#>  7 7         -0.710  0.725 -0.801
#>  8 8         -0.750  0.726 -0.774
#>  9 9         -0.808  1.40  -0.930
#> 10 10        -0.745  0.727 -0.788
#> 11 11         0.927 -0.931 -0.837
#> 12 12         0.963 -0.933 -0.849
#> 13 13         0.923 -0.932 -0.823
#> 14 14         0.829 -0.253 -0.967
#> 15 15         0.927 -0.931 -0.837
#> 16 16         0.422  2.05   1.29 
#> 17 17         1.47   1.29   0.545
#> 18 18         1.88   0.309  1.95 
augment(fit2)
#> # A tibble: 18 × 4
#>    .rownames   .fs1   .fs2   .fs3
#>    <chr>      <dbl>  <dbl>  <dbl>
#>  1 1         -0.897 -0.925  0.936
#>  2 2         -0.861 -0.927  0.924
#>  3 3         -0.901 -0.926  0.950
#>  4 4         -0.993 -0.251  0.809
#>  5 5         -0.897 -0.925  0.936
#>  6 6         -0.741  0.720 -0.784
#>  7 7         -0.706  0.718 -0.796
#>  8 8         -0.745  0.719 -0.770
#>  9 9         -0.803  1.39  -0.923
#> 10 10        -0.741  0.720 -0.784
#> 11 11         0.917 -0.925 -0.830
#> 12 12         0.952 -0.927 -0.842
#> 13 13         0.913 -0.926 -0.816
#> 14 14         0.820 -0.252 -0.958
#> 15 15         0.917 -0.925 -0.830
#> 16 16         0.426  2.04   1.28 
#> 17 17         1.46   1.29   0.548
#> 18 18         1.88   0.314  1.95 

# augmented dataframe (with new data)
augment(fit1, data = m2)
#> # A tibble: 18 × 10
#>    .rownames    v1    v2    v3    v4    v5    v6   .fs1   .fs2   .fs3
#>    <chr>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>
#>  1 1             6     5     6     4     5     4 -0.904 -0.931  0.948
#>  2 2             5     6     4     6     4     5 -0.869 -0.933  0.935
#>  3 3             4     4     5     5     6     6 -0.908 -0.932  0.962
#>  4 4             3     3     1     1     1     1 -1.00  -0.253  0.818
#>  5 5             3     3     1     1     1     2 -0.904 -0.931  0.948
#>  6 6             3     3     1     2     1     1 -0.745  0.727 -0.788
#>  7 7             3     4     1     1     1     1 -0.710  0.725 -0.801
#>  8 8             3     3     1     1     1     1 -0.750  0.726 -0.774
#>  9 9             1     1     1     1     3     3 -0.808  1.40  -0.930
#> 10 10            1     2     1     1     3     4 -0.745  0.727 -0.788
#> 11 11            1     1     1     2     3     3  0.927 -0.931 -0.837
#> 12 12            1     2     1     1     3     3  0.963 -0.933 -0.849
#> 13 13            1     1     1     1     3     3  0.923 -0.932 -0.823
#> 14 14            1     1     3     3     1     1  0.829 -0.253 -0.967
#> 15 15            1     1     3     3     1     2  0.927 -0.931 -0.837
#> 16 16            1     1     3     4     1     1  0.422  2.05   1.29 
#> 17 17            1     2     3     3     1     1  1.47   1.29   0.545
#> 18 18            1     1     3     3     1     1  1.88   0.309  1.95 
augment(fit2, data = m2)
#> # A tibble: 18 × 10
#>    .rownames    v1    v2    v3    v4    v5    v6   .fs1   .fs2   .fs3
#>    <chr>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>
#>  1 1             6     5     6     4     5     4 -0.897 -0.925  0.936
#>  2 2             5     6     4     6     4     5 -0.861 -0.927  0.924
#>  3 3             4     4     5     5     6     6 -0.901 -0.926  0.950
#>  4 4             3     3     1     1     1     1 -0.993 -0.251  0.809
#>  5 5             3     3     1     1     1     2 -0.897 -0.925  0.936
#>  6 6             3     3     1     2     1     1 -0.741  0.720 -0.784
#>  7 7             3     4     1     1     1     1 -0.706  0.718 -0.796
#>  8 8             3     3     1     1     1     1 -0.745  0.719 -0.770
#>  9 9             1     1     1     1     3     3 -0.803  1.39  -0.923
#> 10 10            1     2     1     1     3     4 -0.741  0.720 -0.784
#> 11 11            1     1     1     2     3     3  0.917 -0.925 -0.830
#> 12 12            1     2     1     1     3     3  0.952 -0.927 -0.842
#> 13 13            1     1     1     1     3     3  0.913 -0.926 -0.816
#> 14 14            1     1     3     3     1     1  0.820 -0.252 -0.958
#> 15 15            1     1     3     3     1     2  0.917 -0.925 -0.830
#> 16 16            1     1     3     4     1     1  0.426  2.04   1.28 
#> 17 17            1     2     3     3     1     1  1.46   1.29   0.548
#> 18 18            1     1     3     3     1     1  1.88   0.314  1.95 
```
