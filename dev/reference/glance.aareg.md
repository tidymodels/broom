# Glance at a(n) aareg object

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
# S3 method for class 'aareg'
glance(x, ...)
```

## Arguments

- x:

  An `aareg` object returned from
  [`survival::aareg()`](https://rdrr.io/pkg/survival/man/aareg.html).

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
[`survival::aareg()`](https://rdrr.io/pkg/survival/man/aareg.html)

Other aareg tidiers:
[`tidy.aareg()`](https://broom.tidymodels.org/dev/reference/tidy.aareg.md)

Other survival tidiers:
[`augment.coxph()`](https://broom.tidymodels.org/dev/reference/augment.coxph.md),
[`augment.survreg()`](https://broom.tidymodels.org/dev/reference/augment.survreg.md),
[`glance.cch()`](https://broom.tidymodels.org/dev/reference/glance.cch.md),
[`glance.coxph()`](https://broom.tidymodels.org/dev/reference/glance.coxph.md),
[`glance.pyears()`](https://broom.tidymodels.org/dev/reference/glance.pyears.md),
[`glance.survdiff()`](https://broom.tidymodels.org/dev/reference/glance.survdiff.md),
[`glance.survexp()`](https://broom.tidymodels.org/dev/reference/glance.survexp.md),
[`glance.survfit()`](https://broom.tidymodels.org/dev/reference/glance.survfit.md),
[`glance.survreg()`](https://broom.tidymodels.org/dev/reference/glance.survreg.md),
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

- df:

  Degrees of freedom used by the model.

- nobs:

  Number of observations used.

- p.value:

  P-value corresponding to the test statistic.

- statistic:

  Test statistic.

## Examples

``` r
# load libraries for models and data
library(survival)

# fit model
afit <- aareg(
  Surv(time, status) ~ age + sex + ph.ecog,
  data = lung,
  dfbeta = TRUE
)

# summarize model fit with tidiers
tidy(afit)
#> # A tibble: 4 × 7
#>   term       estimate statistic std.error robust.se statistic.z p.value
#>   <chr>         <dbl>     <dbl>     <dbl>     <dbl>       <dbl>   <dbl>
#> 1 Intercept   5.05e-3   5.87e-3 0.00474   0.00477          1.23 2.19e-1
#> 2 age         4.01e-5   7.15e-5 0.0000723 0.0000700        1.02 3.07e-1
#> 3 sex        -3.16e-3  -4.03e-3 0.00122   0.00123         -3.28 1.03e-3
#> 4 ph.ecog     3.01e-3   3.67e-3 0.00102   0.00102          3.62 2.99e-4
```
