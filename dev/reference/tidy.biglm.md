# Tidy a(n) biglm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'biglm'
tidy(x, conf.int = FALSE, conf.level = 0.95, exponentiate = FALSE, ...)
```

## Arguments

- x:

  A `biglm` object created by a call to
  [`biglm::biglm()`](https://rdrr.io/pkg/biglm/man/biglm.html) or
  [`biglm::bigglm()`](https://rdrr.io/pkg/biglm/man/bigglm.html).

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

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`biglm::biglm()`](https://rdrr.io/pkg/biglm/man/biglm.html),
[`biglm::bigglm()`](https://rdrr.io/pkg/biglm/man/bigglm.html)

Other biglm tidiers:
[`glance.biglm()`](https://broom.tidymodels.org/dev/reference/glance.biglm.md)

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
