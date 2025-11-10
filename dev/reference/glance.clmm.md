# Glance at a(n) clmm object

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
# S3 method for class 'clmm'
glance(x, ...)
```

## Arguments

- x:

  A `clmm` object returned from
  [`ordinal::clmm()`](https://rdrr.io/pkg/ordinal/man/clmm.html).

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
[`ordinal::clmm()`](https://rdrr.io/pkg/ordinal/man/clmm.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
[`glance.clm()`](https://broom.tidymodels.org/dev/reference/glance.clm.md),
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
