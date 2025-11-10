# Glance at a(n) binDesign object

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
# S3 method for class 'binDesign'
glance(x, ...)
```

## Arguments

- x:

  A
  [binGroup::binDesign](https://rdrr.io/pkg/binGroup/man/binDesign.html)
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

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`binGroup::binDesign()`](https://rdrr.io/pkg/binGroup/man/binDesign.html)

Other bingroup tidiers:
[`tidy.binDesign()`](https://broom.tidymodels.org/dev/reference/tidy.binDesign.md),
[`tidy.binWidth()`](https://broom.tidymodels.org/dev/reference/tidy.binWidth.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- power:

  Power achieved by the analysis.

- n:

  Sample size used to achieve this power.

- power.reached:

  Whether the desired power was reached.

- maxit:

  Number of iterations performed.

## Examples

``` r
# load libraries for models and data
library(binGroup)

des <- binDesign(
  nmax = 300, delta = 0.06,
  p.hyp = 0.1, power = .8
)

glance(des)
#> # A tibble: 1 × 4
#>   power     n power.reached maxit
#>   <dbl> <int> <lgl>         <int>
#> 1 0.805   240 TRUE            238
tidy(des)
#> # A tibble: 238 × 2
#>        n     power
#>    <int>     <dbl>
#>  1     3 0.0000640
#>  2     4 0.000248 
#>  3     5 0.000602 
#>  4     6 0.00117  
#>  5     7 0.0000813
#>  6     8 0.000157 
#>  7     9 0.000274 
#>  8    10 0.000443 
#>  9    11 0.000673 
#> 10    12 0.0000640
#> # ℹ 228 more rows

library(ggplot2)

ggplot(tidy(des), aes(n, power)) +
  geom_line()
```
