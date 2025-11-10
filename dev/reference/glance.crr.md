# Glance at a(n) crr object

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
# S3 method for class 'crr'
glance(x, ...)
```

## Arguments

- x:

  A `crr` object returned from
  [`cmprsk::crr()`](https://rdrr.io/pkg/cmprsk/man/crr.html).

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
[`cmprsk::crr()`](https://rdrr.io/pkg/cmprsk/man/crr.html)

Other cmprsk tidiers:
[`tidy.crr()`](https://broom.tidymodels.org/dev/reference/tidy.crr.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- converged:

  Logical indicating if the model fitting procedure was succesful and
  converged.

- df:

  Degrees of freedom used by the model.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- statistic:

  Test statistic.

## Examples

``` r
library(cmprsk)

# time to loco-regional failure (lrf)
lrf_time <- rexp(100)
lrf_event <- sample(0:2, 100, replace = TRUE)
trt <- sample(0:1, 100, replace = TRUE)
strt <- sample(1:2, 100, replace = TRUE)

# fit model
x <- crr(lrf_time, lrf_event, cbind(trt, strt))

# summarize model fit with tidiers
tidy(x, conf.int = TRUE)
#> # A tibble: 2 × 7
#>   term  estimate std.error statistic p.value conf.low conf.high
#>   <chr>    <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 trt     -0.540     0.342    -1.58     0.11   -1.21      0.131
#> 2 strt     0.125     0.326     0.382    0.7    -0.514     0.763
glance(x)
#> # A tibble: 1 × 5
#>   converged logLik  nobs    df statistic
#>   <lgl>      <dbl> <int> <dbl>     <dbl>
#> 1 TRUE       -144.   100     2      2.77
```
