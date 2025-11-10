# Glance at a(n) fitdistr object

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
# S3 method for class 'fitdistr'
glance(x, ...)
```

## Arguments

- x:

  A `fitdistr` object returned by
  [`MASS::fitdistr()`](https://rdrr.io/pkg/MASS/man/fitdistr.html).

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
[`MASS::fitdistr()`](https://rdrr.io/pkg/MASS/man/fitdistr.html)

Other fitdistr tidiers:
[`tidy.fitdistr()`](https://broom.tidymodels.org/dev/reference/tidy.fitdistr.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

## Examples

``` r
# load libraries for models and data
library(MASS)

# generate data
set.seed(2015)
x <- rnorm(100, 5, 2)

#  fit models
fit <- fitdistr(x, dnorm, list(mean = 3, sd = 1))
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced
#> Warning: NaNs produced

# summarize model fit with tidiers
tidy(fit)
#> # A tibble: 2 × 3
#>   term  estimate std.error
#>   <chr>    <dbl>     <dbl>
#> 1 mean      4.90     0.201
#> 2 sd        2.01     0.142
glance(fit)
#> # A tibble: 1 × 4
#>   logLik      AIC   BIC  nobs
#>   <logLik>  <dbl> <dbl> <int>
#> 1 -211.6533  427.  433.   100
```
