# Tidy a(n) clmm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'clmm'
tidy(x, conf.int = FALSE, conf.level = 0.95, exponentiate = FALSE, ...)
```

## Arguments

- x:

  A `clmm` object returned from
  [`ordinal::clmm()`](https://rdrr.io/pkg/ordinal/man/clmm.html).

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

## Note

In `broom 0.7.0` the `coefficient_type` column was renamed to
`coef.type`, and the contents were changed as well.

Note that `intercept` type coefficients correspond to `alpha`
parameters, `location` type coefficients correspond to `beta`
parameters, and `scale` type coefficients correspond to `zeta`
parameters.

## See also

[tidy](https://generics.r-lib.org/reference/tidy.html),
[`ordinal::clmm()`](https://rdrr.io/pkg/ordinal/man/clmm.html),
[`ordinal::confint.clm()`](https://rdrr.io/pkg/ordinal/man/confint.clm.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
[`glance.clm()`](https://broom.tidymodels.org/dev/reference/glance.clm.md),
[`glance.clmm()`](https://broom.tidymodels.org/dev/reference/glance.clmm.md),
[`glance.polr()`](https://broom.tidymodels.org/dev/reference/glance.polr.md),
[`glance.svyolr()`](https://broom.tidymodels.org/dev/reference/glance.svyolr.md),
[`tidy.clm()`](https://broom.tidymodels.org/dev/reference/tidy.clm.md),
[`tidy.polr()`](https://broom.tidymodels.org/dev/reference/tidy.polr.md),
[`tidy.svyolr()`](https://broom.tidymodels.org/dev/reference/tidy.svyolr.md)

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
# load libraries for models and data
library(ordinal)

# fit model
fit <- clmm(rating ~ temp + contact + (1 | judge), data = wine)

# summarize model fit with tidiers
tidy(fit)
#> # A tibble: 6 × 6
#>   term       estimate std.error statistic  p.value coef.type
#>   <chr>         <dbl>     <dbl>     <dbl>    <dbl> <chr>    
#> 1 1|2           -1.62     0.682     -2.38 1.74e- 2 intercept
#> 2 2|3            1.51     0.604      2.51 1.22e- 2 intercept
#> 3 3|4            4.23     0.809      5.23 1.72e- 7 intercept
#> 4 4|5            6.09     0.972      6.26 3.82e-10 intercept
#> 5 tempwarm       3.06     0.595      5.14 2.68e- 7 location 
#> 6 contactyes     1.83     0.513      3.58 3.44e- 4 location 
tidy(fit, conf.int = TRUE, conf.level = 0.9)
#> # A tibble: 6 × 8
#>   term       estimate std.error statistic  p.value conf.low conf.high
#>   <chr>         <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 1|2           -1.62     0.682     -2.38 1.74e- 2   -2.75     -0.501
#> 2 2|3            1.51     0.604      2.51 1.22e- 2    0.520     2.51 
#> 3 3|4            4.23     0.809      5.23 1.72e- 7    2.90      5.56 
#> 4 4|5            6.09     0.972      6.26 3.82e-10    4.49      7.69 
#> 5 tempwarm       3.06     0.595      5.14 2.68e- 7    2.08      4.04 
#> 6 contactyes     1.83     0.513      3.58 3.44e- 4    0.992     2.68 
#> # ℹ 1 more variable: coef.type <chr>
tidy(fit, conf.int = TRUE, exponentiate = TRUE)
#> # A tibble: 6 × 8
#>   term       estimate std.error statistic  p.value conf.low conf.high
#>   <chr>         <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 1|2           0.197     0.682     -2.38 1.74e- 2   0.0518     0.751
#> 2 2|3           4.54      0.604      2.51 1.22e- 2   1.39      14.8  
#> 3 3|4          68.6       0.809      5.23 1.72e- 7  14.1      335.   
#> 4 4|5         441.        0.972      6.26 3.82e-10  65.5     2965.   
#> 5 tempwarm     21.4       0.595      5.14 2.68e- 7   6.66      68.7  
#> 6 contactyes    6.26      0.513      3.58 3.44e- 4   2.29      17.1  
#> # ℹ 1 more variable: coef.type <chr>

glance(fit)
#> # A tibble: 1 × 5
#>     edf   AIC   BIC logLik     nobs
#>   <dbl> <dbl> <dbl> <logLik>  <dbl>
#> 1     7  177.  193. -81.56541    72

# ...and again with another model specification
fit2 <- clmm(rating ~ temp + (1 | judge), nominal = ~contact, data = wine)
#> Warning: unrecognized control elements named ‘nominal’ ignored

tidy(fit2)
#> # A tibble: 5 × 6
#>   term     estimate std.error statistic       p.value coef.type
#>   <chr>       <dbl>     <dbl>     <dbl>         <dbl> <chr>    
#> 1 1|2        -2.20      0.613     -3.59 0.000333      intercept
#> 2 2|3         0.545     0.476      1.15 0.252         intercept
#> 3 3|4         2.84      0.607      4.68 0.00000291    intercept
#> 4 4|5         4.48      0.751      5.96 0.00000000256 intercept
#> 5 tempwarm    2.67      0.554      4.81 0.00000147    location 
glance(fit2)
#> # A tibble: 1 × 5
#>     edf   AIC   BIC logLik     nobs
#>   <dbl> <dbl> <dbl> <logLik>  <dbl>
#> 1     6  189.  203. -88.73882    72
```
