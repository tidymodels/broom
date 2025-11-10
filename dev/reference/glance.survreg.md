# Glance at a(n) survreg object

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
# S3 method for class 'survreg'
glance(x, ...)
```

## Arguments

- x:

  An `survreg` object returned from
  [`survival::survreg()`](https://rdrr.io/pkg/survival/man/survreg.html).

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
[`survival::survreg()`](https://rdrr.io/pkg/survival/man/survreg.html)

Other survreg tidiers:
[`augment.survreg()`](https://broom.tidymodels.org/dev/reference/augment.survreg.md),
[`tidy.survreg()`](https://broom.tidymodels.org/dev/reference/tidy.survreg.md)

Other survival tidiers:
[`augment.coxph()`](https://broom.tidymodels.org/dev/reference/augment.coxph.md),
[`augment.survreg()`](https://broom.tidymodels.org/dev/reference/augment.survreg.md),
[`glance.aareg()`](https://broom.tidymodels.org/dev/reference/glance.aareg.md),
[`glance.cch()`](https://broom.tidymodels.org/dev/reference/glance.cch.md),
[`glance.coxph()`](https://broom.tidymodels.org/dev/reference/glance.coxph.md),
[`glance.pyears()`](https://broom.tidymodels.org/dev/reference/glance.pyears.md),
[`glance.survdiff()`](https://broom.tidymodels.org/dev/reference/glance.survdiff.md),
[`glance.survexp()`](https://broom.tidymodels.org/dev/reference/glance.survexp.md),
[`glance.survfit()`](https://broom.tidymodels.org/dev/reference/glance.survfit.md),
[`tidy.aareg()`](https://broom.tidymodels.org/dev/reference/tidy.aareg.md),
[`tidy.cch()`](https://broom.tidymodels.org/dev/reference/tidy.cch.md),
[`tidy.coxph()`](https://broom.tidymodels.org/dev/reference/tidy.coxph.md),
[`tidy.pyears()`](https://broom.tidymodels.org/dev/reference/tidy.pyears.md),
[`tidy.survdiff()`](https://broom.tidymodels.org/dev/reference/tidy.survdiff.md),
[`tidy.survexp()`](https://broom.tidymodels.org/dev/reference/tidy.survexp.md),
[`tidy.survfit()`](https://broom.tidymodels.org/dev/reference/tidy.survfit.md),
[`tidy.survreg()`](https://broom.tidymodels.org/dev/reference/tidy.survreg.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- df:

  Degrees of freedom used by the model.

- df.residual:

  Residual degrees of freedom.

- iter:

  Iterations of algorithm/fitting procedure completed.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- p.value:

  P-value corresponding to the test statistic.

- statistic:

  Chi-squared statistic.

## Examples

``` r
# load libraries for models and data
library(survival)

# fit model
sr <- survreg(
  Surv(futime, fustat) ~ ecog.ps + rx,
  ovarian,
  dist = "exponential"
)

# summarize model fit with tidiers + visualization
tidy(sr)
#> # A tibble: 3 × 5
#>   term        estimate std.error statistic     p.value
#>   <chr>          <dbl>     <dbl>     <dbl>       <dbl>
#> 1 (Intercept)    6.96      1.32      5.27  0.000000139
#> 2 ecog.ps       -0.433     0.587    -0.738 0.461      
#> 3 rx             0.582     0.587     0.991 0.322      
augment(sr, ovarian)
#> # A tibble: 26 × 9
#>    futime fustat   age resid.ds    rx ecog.ps .fitted .se.fit .resid
#>     <dbl>  <dbl> <dbl>    <dbl> <dbl>   <dbl>   <dbl>   <dbl>  <dbl>
#>  1     59      1  72.3        2     1       1   1224.    639. -1165.
#>  2    115      1  74.5        2     1       1   1224.    639. -1109.
#>  3    156      1  66.5        2     1       2    794.    350.  -638.
#>  4    421      0  53.4        2     2       1   2190.   1202. -1769.
#>  5    431      1  50.3        2     1       1   1224.    639.  -793.
#>  6    448      0  56.4        1     1       2    794.    350.  -346.
#>  7    464      1  56.9        2     2       2   1420.    741.  -956.
#>  8    475      1  59.9        2     2       2   1420.    741.  -945.
#>  9    477      0  64.2        2     1       1   1224.    639.  -747.
#> 10    563      1  55.2        1     2       2   1420.    741.  -857.
#> # ℹ 16 more rows
glance(sr)
#> # A tibble: 1 × 9
#>    iter    df statistic logLik   AIC   BIC df.residual  nobs p.value
#>   <int> <int>     <dbl>  <dbl> <dbl> <dbl>       <int> <int>   <dbl>
#> 1     4     3      1.67  -97.2  200.  204.          23    26   0.434

# coefficient plot
td <- tidy(sr, conf.int = TRUE)

library(ggplot2)

ggplot(td, aes(estimate, term)) +
  geom_point() +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
  geom_vline(xintercept = 0)
#> `height` was translated to `width`.
```
