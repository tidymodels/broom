# Glance at a(n) lavaan object

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
# S3 method for class 'lavaan'
glance(x, ...)
```

## Arguments

- x:

  A `lavaan` object, such as those returned from
  [`lavaan::cfa()`](https://rdrr.io/pkg/lavaan/man/cfa.html), and
  [`lavaan::sem()`](https://rdrr.io/pkg/lavaan/man/sem.html).

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

## Value

A one-row
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- chisq:

  Model chi squared

- npar:

  Number of parameters in the model

- rmsea:

  Root mean square error of approximation

- rmsea.conf.high:

  95 percent upper bound on RMSEA

- srmr:

  Standardised root mean residual

- agfi:

  Adjusted goodness of fit

- cfi:

  Comparative fit index

- tli:

  Tucker Lewis index

- AIC:

  Akaike information criterion

- BIC:

  Bayesian information criterion

- ngroups:

  Number of groups in model

- nobs:

  Number of observations included

- norig:

  Number of observation in the original dataset

- nexcluded:

  Number of excluded observations

- converged:

  Logical - Did the model converge

- estimator:

  Estimator used

- missing_method:

  Method for eliminating missing data

For further recommendations on reporting SEM and CFA models see
Schreiber, J. B. (2017). Update to core reporting practices in
structural equation modeling. Research in Social and Administrative
Pharmacy, 13(3), 634-643. https://doi.org/10.1016/j.sapharm.2016.06.006

## See also

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`lavaan::cfa()`](https://rdrr.io/pkg/lavaan/man/cfa.html),
[`lavaan::sem()`](https://rdrr.io/pkg/lavaan/man/sem.html),
[`lavaan::fitmeasures()`](https://rdrr.io/pkg/lavaan/man/fitMeasures.html)

Other lavaan tidiers:
[`tidy.lavaan()`](https://broom.tidymodels.org/dev/reference/tidy.lavaan.md)

## Examples

``` r
library(lavaan)
#> This is lavaan 0.6-20
#> lavaan is FREE software! Please report any bugs.

# fit model
cfa.fit <- cfa(
  "F =~ x1 + x2 + x3 + x4 + x5",
  data = HolzingerSwineford1939, group = "school"
)

# summarize model fit with tidiers
glance(cfa.fit)
#> # A tibble: 1 × 17
#>    agfi   AIC   BIC   cfi chisq  npar rmsea rmsea.conf.high  srmr   tli
#>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>           <dbl> <dbl> <dbl>
#> 1 0.971 4473. 4584. 0.766  99.3    30 0.244           0.288 0.115 0.533
#> # ℹ 7 more variables: converged <lgl>, estimator <chr>, ngroups <int>,
#> #   missing_method <chr>, nobs <int>, norig <int>, nexcluded <int>
```
