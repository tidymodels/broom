# Glance at a(n) svyolr object

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
# S3 method for class 'svyolr'
glance(x, ...)
```

## Arguments

- x:

  A `svyolr` object returned from
  [`survey::svyolr()`](https://rdrr.io/pkg/survey/man/svyolr.html).

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

[tidy](https://generics.r-lib.org/reference/tidy.html),
[`survey::svyolr()`](https://rdrr.io/pkg/survey/man/svyolr.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
[`glance.clm()`](https://broom.tidymodels.org/dev/reference/glance.clm.md),
[`glance.clmm()`](https://broom.tidymodels.org/dev/reference/glance.clmm.md),
[`glance.polr()`](https://broom.tidymodels.org/dev/reference/glance.polr.md),
[`tidy.clm()`](https://broom.tidymodels.org/dev/reference/tidy.clm.md),
[`tidy.clmm()`](https://broom.tidymodels.org/dev/reference/tidy.clmm.md),
[`tidy.polr()`](https://broom.tidymodels.org/dev/reference/tidy.polr.md),
[`tidy.svyolr()`](https://broom.tidymodels.org/dev/reference/tidy.svyolr.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- df.residual:

  Residual degrees of freedom.

- edf:

  The effective degrees of freedom.

- nobs:

  Number of observations used.

## Examples

``` r
library(broom)
library(survey)

data(api)
dclus1 <- svydesign(id = ~dnum, weights = ~pw, data = apiclus1, fpc = ~fpc)
dclus1 <- update(dclus1, mealcat = cut(meals, c(0, 25, 50, 75, 100)))

m <- svyolr(mealcat ~ avg.ed + mobility + stype, design = dclus1)

m
#> Call:
#> svyolr(mealcat ~ avg.ed + mobility + stype, design = dclus1)
#> 
#> Coefficients:
#>     avg.ed   mobility     stypeH     stypeM 
#> -2.6999217  0.0325042 -1.7574715 -0.6191463 
#> 
#> Intercepts:
#>   (0,25]|(25,50]  (25,50]|(50,75] (50,75]|(75,100] 
#>        -8.857919        -6.586464        -4.924938 

tidy(m, conf.int = TRUE)
#> # A tibble: 7 × 7
#>   term        estimate std.error statistic conf.low conf.high coef.type
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>     <dbl> <chr>    
#> 1 avg.ed       -2.70      1.13       -2.38 -4.92e+0   -0.477  coeffici…
#> 2 mobility      0.0325    0.0207      1.57 -7.98e-3    0.0730 coeffici…
#> 3 stypeH       -1.76      0.700      -2.51 -3.13e+0   -0.386  coeffici…
#> 4 stypeM       -0.619     0.310      -2.00 -1.23e+0   -0.0123 coeffici…
#> 5 (0,25]|(25…  -8.86      3.69       -2.40 -1.61e+1   -1.63   scale    
#> 6 (25,50]|(5…  -6.59      3.11       -2.12 -1.27e+1   -0.493  scale    
#> 7 (50,75]|(7…  -4.92      2.86       -1.72 -1.05e+1    0.687  scale    
```
