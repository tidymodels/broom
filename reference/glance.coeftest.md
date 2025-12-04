# Glance at a(n) coeftest object

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
# S3 method for class 'coeftest'
glance(x, ...)
```

## Arguments

- x:

  A `coeftest` object returned from
  [`lmtest::coeftest()`](https://rdrr.io/pkg/lmtest/man/coeftest.html).

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

Because of the way that lmtest::coeftest() retains information about the
underlying model object, the returned columns for glance.coeftest() will
vary depending on the arguments. Specifically, four columns are returned
regardless: "Loglik", "AIC", "BIC", and "nobs". Users can obtain
additional columns (e.g. "r.squared", "df") by invoking the "save =
TRUE" argument as part of lmtest::coeftest(). See examples.

As an aside, goodness-of-fit measures such as R-squared are unaffected
by the presence of heteroskedasticity. For further discussion see, e.g.
chapter 8.1 of Wooldridge (2016).

## References

Wooldridge, Jeffrey M. (2016) Introductory econometrics: A modern
approach. (6th edition). Nelson Education.

## See also

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`lmtest::coeftest()`](https://rdrr.io/pkg/lmtest/man/coeftest.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- adj.r.squared:

  Adjusted R squared statistic, which is like the R squared statistic
  except taking degrees of freedom into account.

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- deviance:

  Deviance of the model.

- df:

  Degrees of freedom used by the model.

- df.residual:

  Residual degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- p.value:

  P-value corresponding to the test statistic.

- r.squared:

  R squared statistic, or the percent of variation explained by the
  model. Also known as the coefficient of determination.

- sigma:

  Estimated standard error of the residuals.

- statistic:

  Test statistic.

## Examples

``` r
# load libraries for models and data
library(lmtest)

m <- lm(dist ~ speed, data = cars)

coeftest(m)
#> 
#> t test of coefficients:
#> 
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -17.57909    6.75844 -2.6011  0.01232 *  
#> speed         3.93241    0.41551  9.4640 1.49e-12 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
tidy(coeftest(m))
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)   -17.6      6.76      -2.60 1.23e- 2
#> 2 speed           3.93     0.416      9.46 1.49e-12
tidy(coeftest(m, conf.int = TRUE))
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)   -17.6      6.76      -2.60 1.23e- 2
#> 2 speed           3.93     0.416      9.46 1.49e-12

# a very common workflow is to combine lmtest::coeftest with alternate
# variance-covariance matrices via the sandwich package. The lmtest
# tidiers support this workflow too, enabling you to adjust the standard
# errors of your tidied models on the fly.
library(sandwich)

# "HC3" (default) robust SEs
tidy(coeftest(m, vcov = vcovHC))
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)   -17.6      5.93      -2.96 4.72e- 3
#> 2 speed           3.93     0.428      9.20 3.64e-12

# "HC2" robust SEs
tidy(coeftest(m, vcov = vcovHC, type = "HC2"))
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)   -17.6      5.73      -3.07 3.55e- 3
#> 2 speed           3.93     0.413      9.53 1.21e-12

# N-W HAC robust SEs
tidy(coeftest(m, vcov = NeweyWest))
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic       p.value
#>   <chr>          <dbl>     <dbl>     <dbl>         <dbl>
#> 1 (Intercept)   -17.6      7.02      -2.50 0.0157       
#> 2 speed           3.93     0.551      7.14 0.00000000453

# the columns of the returned tibble for glance.coeftest() will vary
# depending on whether the coeftest object retains the underlying model.
# Users can control this with the "save = TRUE" argument of coeftest().
glance(coeftest(m))
#> Original model not retained as part of coeftest object.
#> ℹ For additional model summary information (r.squared, df, etc.),
#>   consider passing `glance.coeftest()` an object where the underlying
#>   model has been saved, i.e.  `lmtest::coeftest(..., save = TRUE)`.
#> This message is displayed once per session.
#> # A tibble: 1 × 4
#>   logLik     AIC   BIC  nobs
#>   <chr>    <dbl> <dbl> <int>
#> 1 -206.578  419.  425.    50
glance(coeftest(m, save = TRUE))
#> # A tibble: 1 × 12
#>   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl>
#> 1     0.651         0.644  15.4      89.6 1.49e-12     1  -207.  419.
#> # ℹ 4 more variables: BIC <dbl>, deviance <dbl>, df.residual <int>,
#> #   nobs <int>
```
