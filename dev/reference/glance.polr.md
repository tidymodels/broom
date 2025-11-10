# Glance at a(n) polr object

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
# S3 method for class 'polr'
glance(x, ...)
```

## Arguments

- x:

  A `polr` object returned from
  [`MASS::polr()`](https://rdrr.io/pkg/MASS/man/polr.html).

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
[`MASS::polr()`](https://rdrr.io/pkg/MASS/man/polr.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
[`glance.clm()`](https://broom.tidymodels.org/dev/reference/glance.clm.md),
[`glance.clmm()`](https://broom.tidymodels.org/dev/reference/glance.clmm.md),
[`glance.svyolr()`](https://broom.tidymodels.org/dev/reference/glance.svyolr.md),
[`tidy.clm()`](https://broom.tidymodels.org/dev/reference/tidy.clm.md),
[`tidy.clmm()`](https://broom.tidymodels.org/dev/reference/tidy.clmm.md),
[`tidy.polr()`](https://broom.tidymodels.org/dev/reference/tidy.polr.md),
[`tidy.svyolr()`](https://broom.tidymodels.org/dev/reference/tidy.svyolr.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- deviance:

  Deviance of the model.

- df.residual:

  Residual degrees of freedom.

- edf:

  The effective degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

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
