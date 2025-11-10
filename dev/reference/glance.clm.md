# Glance at a(n) clm object

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
# S3 method for class 'clm'
glance(x, ...)
```

## Arguments

- x:

  A `clm` object returned from
  [`ordinal::clm()`](https://rdrr.io/pkg/ordinal/man/clm.html).

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
[`ordinal::clm()`](https://rdrr.io/pkg/ordinal/man/clm.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
[`glance.clmm()`](https://broom.tidymodels.org/dev/reference/glance.clmm.md),
[`glance.polr()`](https://broom.tidymodels.org/dev/reference/glance.polr.md),
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
library(ordinal)

# fit model
fit <- clm(rating ~ temp * contact, data = wine)

# summarize model fit with tidiers
tidy(fit)
#> # A tibble: 7 × 6
#>   term                estimate std.error statistic  p.value coef.type
#>   <chr>                  <dbl>     <dbl>     <dbl>    <dbl> <chr>    
#> 1 1|2                   -1.41      0.545    -2.59  9.66e- 3 intercept
#> 2 2|3                    1.14      0.510     2.24  2.48e- 2 intercept
#> 3 3|4                    3.38      0.638     5.29  1.21e- 7 intercept
#> 4 4|5                    4.94      0.751     6.58  4.66e-11 intercept
#> 5 tempwarm               2.32      0.701     3.31  9.28e- 4 location 
#> 6 contactyes             1.35      0.660     2.04  4.13e- 2 location 
#> 7 tempwarm:contactyes    0.360     0.924     0.389 6.97e- 1 location 
tidy(fit, conf.int = TRUE, conf.level = 0.9)
#> # A tibble: 7 × 8
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 1|2            -1.41      0.545    -2.59  9.66e- 3   NA         NA   
#> 2 2|3             1.14      0.510     2.24  2.48e- 2   NA         NA   
#> 3 3|4             3.38      0.638     5.29  1.21e- 7   NA         NA   
#> 4 4|5             4.94      0.751     6.58  4.66e-11   NA         NA   
#> 5 tempwarm        2.32      0.701     3.31  9.28e- 4    1.20       3.52
#> 6 contactyes      1.35      0.660     2.04  4.13e- 2    0.284      2.47
#> 7 tempwarm:co…    0.360     0.924     0.389 6.97e- 1   -1.17       1.89
#> # ℹ 1 more variable: coef.type <chr>
tidy(fit, conf.int = TRUE, conf.type = "Wald", exponentiate = TRUE)
#> # A tibble: 7 × 8
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 1|2             0.244     0.545    -2.59  9.66e- 3   0.0837     0.710
#> 2 2|3             3.14      0.510     2.24  2.48e- 2   1.16       8.52 
#> 3 3|4            29.3       0.638     5.29  1.21e- 7   8.38     102.   
#> 4 4|5           140.        0.751     6.58  4.66e-11  32.1      610.   
#> 5 tempwarm       10.2       0.701     3.31  9.28e- 4   2.58      40.2  
#> 6 contactyes      3.85      0.660     2.04  4.13e- 2   1.05      14.0  
#> 7 tempwarm:co…    1.43      0.924     0.389 6.97e- 1   0.234      8.76 
#> # ℹ 1 more variable: coef.type <chr>

glance(fit)
#> # A tibble: 1 × 6
#>     edf   AIC   BIC logLik   df.residual  nobs
#>   <int> <dbl> <dbl> <logLik>       <dbl> <dbl>
#> 1     7  187.  203. -86.4162          65    72
augment(fit, type.predict = "prob")
#> # A tibble: 72 × 4
#>    rating temp  contact .fitted
#>    <ord>  <fct> <fct>     <dbl>
#>  1 2      cold  no       0.562 
#>  2 3      cold  no       0.209 
#>  3 3      cold  yes      0.435 
#>  4 4      cold  yes      0.0894
#>  5 4      warm  no       0.190 
#>  6 4      warm  no       0.190 
#>  7 5      warm  yes      0.286 
#>  8 5      warm  yes      0.286 
#>  9 1      cold  no       0.196 
#> 10 2      cold  no       0.562 
#> # ℹ 62 more rows
augment(fit, type.predict = "class")
#> # A tibble: 72 × 4
#>    rating temp  contact .fitted
#>    <ord>  <fct> <fct>   <fct>  
#>  1 2      cold  no      2      
#>  2 3      cold  no      2      
#>  3 3      cold  yes     3      
#>  4 4      cold  yes     3      
#>  5 4      warm  no      3      
#>  6 4      warm  no      3      
#>  7 5      warm  yes     4      
#>  8 5      warm  yes     4      
#>  9 1      cold  no      2      
#> 10 2      cold  no      2      
#> # ℹ 62 more rows

# ...and again with another model specification
fit2 <- clm(rating ~ temp, nominal = ~contact, data = wine)

tidy(fit2)
#> # A tibble: 9 × 6
#>   term            estimate std.error statistic      p.value coef.type
#>   <chr>              <dbl>     <dbl>     <dbl>        <dbl> <chr>    
#> 1 1|2.(Intercept)    -1.32     0.562     -2.35 0.0186       intercept
#> 2 2|3.(Intercept)     1.25     0.475      2.63 0.00866      intercept
#> 3 3|4.(Intercept)     3.55     0.656      5.41 0.0000000625 intercept
#> 4 4|5.(Intercept)     4.66     0.860      5.42 0.0000000608 intercept
#> 5 1|2.contactyes     -1.62     1.16      -1.39 0.164        intercept
#> 6 2|3.contactyes     -1.51     0.591     -2.56 0.0105       intercept
#> 7 3|4.contactyes     -1.67     0.649     -2.58 0.00985      intercept
#> 8 4|5.contactyes     -1.05     0.897     -1.17 0.241        intercept
#> 9 tempwarm            2.52     0.535      4.71 0.00000250   location 
glance(fit2)
#> # A tibble: 1 × 6
#>     edf   AIC   BIC logLik    df.residual  nobs
#>   <int> <dbl> <dbl> <logLik>        <dbl> <dbl>
#> 1     9  190.  211. -86.20855          63    72
```
