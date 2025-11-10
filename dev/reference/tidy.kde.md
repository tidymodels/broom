# Tidy a(n) kde object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'kde'
tidy(x, ...)
```

## Arguments

- x:

  A `kde` object returned from
  [`ks::kde()`](https://rdrr.io/pkg/ks/man/kde.html).

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

Returns a data frame in long format with four columns. Use
`tidyr::pivot_wider(..., names_from = variable, values_from = value)` on
the output to return to a wide format.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`ks::kde()`](https://rdrr.io/pkg/ks/man/kde.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- estimate:

  The estimated value of the regression term.

- obs:

  weighted observed number of events in each group.

- value:

  The value/estimate of the component. Results from data reshaping.

- variable:

  Variable under consideration.

## Examples

``` r
# load libraries for models and data
library(ks)

# generate data
dat <- replicate(2, rnorm(100))
k <- kde(dat)

# summarize model fit with tidiers + visualization
td <- tidy(k)
td
#> # A tibble: 45,602 × 4
#>      obs variable value estimate
#>    <int> <chr>    <dbl>    <dbl>
#>  1     1 x1       -4.75        0
#>  2     2 x1       -4.68        0
#>  3     3 x1       -4.62        0
#>  4     4 x1       -4.55        0
#>  5     5 x1       -4.49        0
#>  6     6 x1       -4.42        0
#>  7     7 x1       -4.36        0
#>  8     8 x1       -4.29        0
#>  9     9 x1       -4.23        0
#> 10    10 x1       -4.17        0
#> # ℹ 45,592 more rows

library(ggplot2)
library(dplyr)
library(tidyr)

td |>
  pivot_wider(c(obs, estimate),
    names_from = variable,
    values_from = value
  ) |>
  ggplot(aes(x1, x2, fill = estimate)) +
  geom_tile() +
  theme_void()
#> Warning: Specifying the `id_cols` argument by position was deprecated in tidyr
#> 1.3.0.
#> ℹ Please explicitly name `id_cols`, like `id_cols = c(obs, estimate)`.


# also works with 3 dimensions
dat3 <- replicate(3, rnorm(100))
k3 <- kde(dat3)

td3 <- tidy(k3)
td3
#> # A tibble: 397,953 × 4
#>      obs variable value estimate
#>    <int> <chr>    <dbl>    <dbl>
#>  1     1 x1       -3.92        0
#>  2     2 x1       -3.76        0
#>  3     3 x1       -3.60        0
#>  4     4 x1       -3.45        0
#>  5     5 x1       -3.29        0
#>  6     6 x1       -3.13        0
#>  7     7 x1       -2.98        0
#>  8     8 x1       -2.82        0
#>  9     9 x1       -2.66        0
#> 10    10 x1       -2.51        0
#> # ℹ 397,943 more rows
```
