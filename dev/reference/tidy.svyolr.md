# Tidy a(n) svyolr object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'svyolr'
tidy(x, conf.int = FALSE, conf.level = 0.95, exponentiate = FALSE, ...)
```

## Arguments

- x:

  A `svyolr` object returned from
  [`survey::svyolr()`](https://rdrr.io/pkg/survey/man/svyolr.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- exponentiate:

  Logical indicating whether or not to exponentiate the the coefficient
  estimates. This is typical for logistic and multinomial regressions,
  but a bad idea if there is no log or logit link. Defaults to `FALSE`.

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

The `tidy.svyolr()` tidier is a light wrapper around
[`tidy.polr()`](https://broom.tidymodels.org/dev/reference/tidy.polr.md).
However, the implementation for p-value calculation in
[`tidy.polr()`](https://broom.tidymodels.org/dev/reference/tidy.polr.md)
is both computationally intensive and specific to that model, so the
`p.values` argument to `tidy.svyolr()` is currently ignored, and will
raise a warning when passed.

## See also

[tidy](https://generics.r-lib.org/reference/tidy.html),
[`survey::svyolr()`](https://rdrr.io/pkg/survey/man/svyolr.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
[`glance.clm()`](https://broom.tidymodels.org/dev/reference/glance.clm.md),
[`glance.clmm()`](https://broom.tidymodels.org/dev/reference/glance.clmm.md),
[`glance.polr()`](https://broom.tidymodels.org/dev/reference/glance.polr.md),
[`glance.svyolr()`](https://broom.tidymodels.org/dev/reference/glance.svyolr.md),
[`tidy.clm()`](https://broom.tidymodels.org/dev/reference/tidy.clm.md),
[`tidy.clmm()`](https://broom.tidymodels.org/dev/reference/tidy.clmm.md),
[`tidy.polr()`](https://broom.tidymodels.org/dev/reference/tidy.polr.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- estimate:

  The estimated value of the regression term.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

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
