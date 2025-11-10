# Tidy a(n) binWidth object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'binWidth'
tidy(x, ...)
```

## Arguments

- x:

  A
  [`binGroup::binWidth()`](https://rdrr.io/pkg/binGroup/man/binWidth.html)
  object.

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
[`binGroup::binWidth()`](https://rdrr.io/pkg/binGroup/man/binWidth.html)

Other bingroup tidiers:
[`glance.binDesign()`](https://broom.tidymodels.org/dev/reference/glance.binDesign.md),
[`tidy.binDesign()`](https://broom.tidymodels.org/dev/reference/tidy.binDesign.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- alternative:

  Alternative hypothesis (character).

- ci.width:

  Expected width of confidence interval.

- p:

  True proportion.

- n:

  Total sample size

## Examples

``` r
# load libraries
library(binGroup)

# fit model
bw <- binWidth(100, .1)

bw
#> $expCIWidth
#> [1] 0.1256172
#> 
#> $alternative
#> [1] "two.sided"
#> 
#> $p
#> [1] 0.1
#> 
#> $n
#> [1] 100
#> 
#> attr(,"class")
#> [1] "binWidth"

# summarize model fit with tidiers
tidy(bw)
#> # A tibble: 1 × 4
#>   ci.width alternative     p     n
#>      <dbl> <chr>       <dbl> <dbl>
#> 1    0.126 two.sided     0.1   100
```
