# Tidy a(n) Gam object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'Gam'
tidy(x, ...)
```

## Arguments

- x:

  A `Gam` object returned from a call to
  [`gam::gam()`](https://rdrr.io/pkg/gam/man/gam.html).

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

Tidy `gam` objects created by calls to
[`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html) with
[`tidy.gam()`](https://broom.tidymodels.org/dev/reference/tidy.gam.md).

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`gam::gam()`](https://rdrr.io/pkg/gam/man/gam.html),
[`tidy.anova()`](https://broom.tidymodels.org/dev/reference/tidy.anova.md),
[`tidy.gam()`](https://broom.tidymodels.org/dev/reference/tidy.gam.md)

Other gam tidiers:
[`glance.Gam()`](https://broom.tidymodels.org/dev/reference/glance_gam_hastie.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- df:

  Degrees of freedom used by this term in the model.

- meansq:

  Mean sum of squares. Equal to total sum of squares divided by degrees
  of freedom.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- sumsq:

  Sum of squares explained by this term.

- term:

  The name of the regression term.

## Examples

``` r
# load libraries for models and data
library(gam)
#> Loading required package: splines
#> Loading required package: foreach
#> 
#> Attaching package: ‘foreach’
#> The following objects are masked from ‘package:purrr’:
#> 
#>     accumulate, when
#> Loaded gam 1.22-6
#> 
#> Attaching package: ‘gam’
#> The following objects are masked from ‘package:mgcv’:
#> 
#>     gam, gam.control, gam.fit, s

# fit model
g <- gam(mpg ~ s(hp, 4) + am + qsec, data = mtcars)

# summarize model fit with tidiers
tidy(g)
#> # A tibble: 4 × 6
#>   term         df    sumsq   meansq statistic   p.value
#>   <chr>     <dbl>    <dbl>    <dbl>     <dbl>     <dbl>
#> 1 s(hp, 4)    1   678.     678.      94.4      5.73e-10
#> 2 am          1   113.     113.      15.7      5.52e- 4
#> 3 qsec        1     0.0263   0.0263   0.00366  9.52e- 1
#> 4 Residuals  25.0 180.       7.19    NA       NA       
glance(g)
#> # A tibble: 1 × 7
#>      df logLik   AIC   BIC deviance df.residual  nobs
#>   <dbl>  <dbl> <dbl> <dbl>    <dbl>       <dbl> <int>
#> 1  7.00  -76.0  162.  169.     180.        25.0    32
```
