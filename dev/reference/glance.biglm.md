# Glance at a(n) biglm object

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
# S3 method for class 'biglm'
glance(x, ...)
```

## Arguments

- x:

  A `biglm` object created by a call to
  [`biglm::biglm()`](https://rdrr.io/pkg/biglm/man/biglm.html) or
  [`biglm::bigglm()`](https://rdrr.io/pkg/biglm/man/bigglm.html).

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
[`biglm::biglm()`](https://rdrr.io/pkg/biglm/man/biglm.html),
[`biglm::bigglm()`](https://rdrr.io/pkg/biglm/man/bigglm.html)

Other biglm tidiers:
[`tidy.biglm()`](https://broom.tidymodels.org/dev/reference/tidy.biglm.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- deviance:

  Deviance of the model.

- df.residual:

  Residual degrees of freedom.

- nobs:

  Number of observations used.

- r.squared:

  R squared statistic, or the percent of variation explained by the
  model. Also known as the coefficient of determination.

## Examples

``` r
# load modeling library
library(biglm)

# fit model -- linear regression
bfit <- biglm(mpg ~ wt + disp, mtcars)

# summarize model fit with tidiers
tidy(bfit)
#> # A tibble: 3 × 4
#>   term        estimate std.error  p.value
#>   <chr>          <dbl>     <dbl>    <dbl>
#> 1 (Intercept)  35.0      2.16    1.11e-58
#> 2 wt           -3.35     1.16    4.00e- 3
#> 3 disp         -0.0177   0.00919 5.38e- 2
tidy(bfit, conf.int = TRUE)
#> # A tibble: 3 × 6
#>   term        estimate std.error  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept)  35.0      2.16    1.11e-58  30.7    39.2     
#> 2 wt           -3.35     1.16    4.00e- 3  -5.63   -1.07    
#> 3 disp         -0.0177   0.00919 5.38e- 2  -0.0357  0.000288
tidy(bfit, conf.int = TRUE, conf.level = .9)
#> # A tibble: 3 × 6
#>   term        estimate std.error  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept)  35.0      2.16    1.11e-58  31.4     38.5    
#> 2 wt           -3.35     1.16    4.00e- 3  -5.27    -1.44   
#> 3 disp         -0.0177   0.00919 5.38e- 2  -0.0328  -0.00261

glance(bfit)
#> # A tibble: 1 × 5
#>   r.squared   AIC deviance df.residual  nobs
#>       <dbl> <dbl>    <dbl>       <int> <int>
#> 1     0.781  253.     247.          29    32

# fit model -- logistic regression
bgfit <- bigglm(am ~ mpg, mtcars, family = binomial())

# summarize model fit with tidiers
tidy(bgfit)
#> # A tibble: 2 × 4
#>   term        estimate std.error p.value
#>   <chr>          <dbl>     <dbl>   <dbl>
#> 1 (Intercept)   -6.60      2.35  0.00498
#> 2 mpg            0.307     0.115 0.00751
tidy(bgfit, exponentiate = TRUE)
#> # A tibble: 2 × 4
#>   term        estimate std.error p.value
#>   <chr>          <dbl>     <dbl>   <dbl>
#> 1 (Intercept)  0.00136     2.35  0.00498
#> 2 mpg          1.36        0.115 0.00751
tidy(bgfit, conf.int = TRUE)
#> # A tibble: 2 × 6
#>   term        estimate std.error p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 (Intercept)   -6.60      2.35  0.00498 -11.2       -1.99 
#> 2 mpg            0.307     0.115 0.00751   0.0819     0.532
tidy(bgfit, conf.int = TRUE, conf.level = .9)
#> # A tibble: 2 × 6
#>   term        estimate std.error p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 (Intercept)   -6.60      2.35  0.00498  -10.5      -2.74 
#> 2 mpg            0.307     0.115 0.00751    0.118     0.496
tidy(bgfit, conf.int = TRUE, conf.level = .9, exponentiate = TRUE)
#> # A tibble: 2 × 6
#>   term        estimate std.error p.value  conf.low conf.high
#>   <chr>          <dbl>     <dbl>   <dbl>     <dbl>     <dbl>
#> 1 (Intercept)  0.00136     2.35  0.00498 0.0000283    0.0648
#> 2 mpg          1.36        0.115 0.00751 1.13         1.64  

glance(bgfit)
#> # A tibble: 1 × 5
#>   r.squared   AIC deviance df.residual  nobs
#>       <dbl> <dbl>    <dbl>       <dbl> <dbl>
#> 1     0.175  33.7     29.7          30    32
```
