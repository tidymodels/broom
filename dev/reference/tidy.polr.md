# Tidy a(n) polr object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'polr'
tidy(
  x,
  conf.int = FALSE,
  conf.level = 0.95,
  exponentiate = FALSE,
  p.values = FALSE,
  ...
)
```

## Arguments

- x:

  A `polr` object returned from
  [`MASS::polr()`](https://rdrr.io/pkg/MASS/man/polr.html).

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

- p.values:

  Logical. Should p-values be returned, based on chi-squared tests from
  [`MASS::dropterm()`](https://rdrr.io/pkg/MASS/man/dropterm.html).
  Defaults to FALSE.

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

In `broom 0.7.0` the `coefficient_type` column was renamed to
`coef.type`, and the contents were changed as well. Now the contents are
`coefficient` and `scale`, rather than `coefficient` and `zeta`.

Calculating p.values with the
[`dropterm()`](https://rdrr.io/pkg/MASS/man/dropterm.html) function is
the approach suggested by the MASS package author. This approach is
computationally intensive so that p.values are only returned if
requested explicitly. Additionally, it only works for models containing
no variables with more than two categories. If this condition is not
met, a message is shown and NA is returned instead of p-values.

## See also

[tidy](https://generics.r-lib.org/reference/tidy.html),
[`MASS::polr()`](https://rdrr.io/pkg/MASS/man/polr.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
[`glance.clm()`](https://broom.tidymodels.org/dev/reference/glance.clm.md),
[`glance.clmm()`](https://broom.tidymodels.org/dev/reference/glance.clmm.md),
[`glance.polr()`](https://broom.tidymodels.org/dev/reference/glance.polr.md),
[`glance.svyolr()`](https://broom.tidymodels.org/dev/reference/glance.svyolr.md),
[`tidy.clm()`](https://broom.tidymodels.org/dev/reference/tidy.clm.md),
[`tidy.clmm()`](https://broom.tidymodels.org/dev/reference/tidy.clmm.md),
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
library(MASS)

# fit model
fit <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)

# summarize model fit with tidiers
tidy(fit, exponentiate = TRUE, conf.int = TRUE)
#> 
#> Re-fitting to get Hessian
#> # A tibble: 8 × 7
#>   term        estimate std.error statistic conf.low conf.high coef.type
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>     <dbl> <chr>    
#> 1 InflMedium     1.76     0.105       5.41    1.44      2.16  coeffici…
#> 2 InflHigh       3.63     0.127      10.1     2.83      4.66  coeffici…
#> 3 TypeApartm…    0.564    0.119      -4.80    0.446     0.712 coeffici…
#> 4 TypeAtrium     0.693    0.155      -2.36    0.511     0.940 coeffici…
#> 5 TypeTerrace    0.336    0.151      -7.20    0.249     0.451 coeffici…
#> 6 ContHigh       1.43     0.0955      3.77    1.19      1.73  coeffici…
#> 7 Low|Medium     0.609    0.125      -3.97   NA        NA     scale    
#> 8 Medium|High    2.00     0.125       5.50   NA        NA     scale    

glance(fit)
#> # A tibble: 1 × 7
#>     edf logLik   AIC   BIC deviance df.residual  nobs
#>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1     8 -1740. 3495. 3539.    3479.        1673  1681
augment(fit, type.predict = "class")
#> # A tibble: 72 × 6
#>    Sat    Infl   Type      Cont  `(weights)` .fitted
#>    <ord>  <fct>  <fct>     <fct>       <int> <fct>  
#>  1 Low    Low    Tower     Low            21 Low    
#>  2 Medium Low    Tower     Low            21 Low    
#>  3 High   Low    Tower     Low            28 Low    
#>  4 Low    Medium Tower     Low            34 High   
#>  5 Medium Medium Tower     Low            22 High   
#>  6 High   Medium Tower     Low            36 High   
#>  7 Low    High   Tower     Low            10 High   
#>  8 Medium High   Tower     Low            11 High   
#>  9 High   High   Tower     Low            36 High   
#> 10 Low    Low    Apartment Low            61 Low    
#> # ℹ 62 more rows

fit2 <- polr(factor(gear) ~ am + mpg + qsec, data = mtcars)

tidy(fit, p.values = TRUE)
#> 
#> Re-fitting to get Hessian
#> p-values can presently only be returned for models that contain no
#> categorical variables with more than two levels.
#> # A tibble: 8 × 6
#>   term          estimate std.error statistic p.value coef.type  
#>   <chr>            <dbl>     <dbl>     <dbl> <lgl>   <chr>      
#> 1 InflMedium       0.566    0.105       5.41 NA      coefficient
#> 2 InflHigh         1.29     0.127      10.1  NA      coefficient
#> 3 TypeApartment   -0.572    0.119      -4.80 NA      coefficient
#> 4 TypeAtrium      -0.366    0.155      -2.36 NA      coefficient
#> 5 TypeTerrace     -1.09     0.151      -7.20 NA      coefficient
#> 6 ContHigh         0.360    0.0955      3.77 NA      coefficient
#> 7 Low|Medium      -0.496    0.125      -3.97 NA      scale      
#> 8 Medium|High      0.691    0.125       5.50 NA      scale      
```
