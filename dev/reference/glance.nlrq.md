# Glance at a(n) nlrq object

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
# S3 method for class 'nlrq'
glance(x, ...)
```

## Arguments

- x:

  A `nlrq` object returned from
  [`quantreg::nlrq()`](https://rdrr.io/pkg/quantreg/man/nlrq.html).

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
[`quantreg::nlrq()`](https://rdrr.io/pkg/quantreg/man/nlrq.html)

Other quantreg tidiers:
[`augment.nlrq()`](https://broom.tidymodels.org/dev/reference/augment.nlrq.md),
[`augment.rq()`](https://broom.tidymodels.org/dev/reference/augment.rq.md),
[`augment.rqs()`](https://broom.tidymodels.org/dev/reference/augment.rqs.md),
[`glance.rq()`](https://broom.tidymodels.org/dev/reference/glance.rq.md),
[`tidy.nlrq()`](https://broom.tidymodels.org/dev/reference/tidy.nlrq.md),
[`tidy.rq()`](https://broom.tidymodels.org/dev/reference/tidy.rq.md),
[`tidy.rqs()`](https://broom.tidymodels.org/dev/reference/tidy.rqs.md)

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

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- tau:

  Quantile.

## Examples

``` r
# load modeling library
library(quantreg)

# build artificial data with multiplicative error
set.seed(1)
dat <- NULL
dat$x <- rep(1:25, 20)
dat$y <- SSlogis(dat$x, 10, 12, 2) * rnorm(500, 1, 0.1)

# fit the median using nlrq
mod <- nlrq(y ~ SSlogis(x, Asym, mid, scal),
  data = dat, tau = 0.5, trace = TRUE
)
#> 109.059 :   9.968027 11.947208  1.962113 
#> final  value 108.942725 
#> converged
#> lambda = 1 
#> 108.9427 :   9.958648 11.943273  1.967144 
#> final  value 108.490939 
#> stopped after 2 iterations
#> lambda = 0.9750984 
#> 108.4909 :   9.949430 11.987472  1.998607 
#> final  value 108.471416 
#> converged
#> lambda = 0.9999299 
#> 108.4714 :   9.94163 11.99077  1.99344 
#> final  value 108.471243 
#> converged
#> lambda = 1 
#> 108.4712 :   9.941008 11.990550  1.992921 
#> final  value 108.470935 
#> converged
#> lambda = 0.8621249 
#> 108.4709 :   9.942734 11.992773  1.993209 
#> final  value 108.470923 
#> converged
#> lambda = 0.9999613 
#> 108.4709 :   9.942629 11.992728  1.993136 
#> final  value 108.470919 
#> converged
#> lambda = 1 
#> 108.4709 :   9.942644 11.992737  1.993144 
#> final  value 108.470919 
#> converged
#> lambda = 1 
#> 108.4709 :   9.942644 11.992737  1.993144 
#> final  value 108.470919 
#> converged
#> lambda = 1 
#> 108.4709 :   9.942644 11.992737  1.993144 

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 3 × 5
#>   term  estimate std.error statistic p.value
#>   <chr>    <dbl>     <dbl>     <dbl>   <dbl>
#> 1 Asym      9.94    0.0841     118.        0
#> 2 mid      12.0     0.0673     178.        0
#> 3 scal      1.99    0.0248      80.3       0
glance(mod)
#> # A tibble: 1 × 5
#>     tau logLik      AIC   BIC df.residual
#>   <dbl> <logLik>  <dbl> <dbl>       <int>
#> 1   0.5 -429.0842  864.  877.         497
augment(mod)
#> # A tibble: 500 × 4
#>        x      y .fitted   .resid
#>    <int>  <dbl>   <dbl>    <dbl>
#>  1     1 0.0382  0.0399 -0.00171
#>  2     2 0.0682  0.0657  0.00250
#>  3     3 0.101   0.108  -0.00728
#>  4     4 0.209   0.177   0.0315 
#>  5     5 0.303   0.289   0.0137 
#>  6     6 0.435   0.469  -0.0332 
#>  7     7 0.796   0.751   0.0448 
#>  8     8 1.28    1.18    0.0982 
#>  9     9 1.93    1.81    0.118  
#> 10    10 2.61    2.67   -0.0671 
#> # ℹ 490 more rows
```
