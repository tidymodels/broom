# Glance at a(n) pyears object

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
# S3 method for class 'pyears'
glance(x, ...)
```

## Arguments

- x:

  A `pyears` object returned from
  [`survival::pyears()`](https://rdrr.io/pkg/survival/man/pyears.html).

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
[`survival::pyears()`](https://rdrr.io/pkg/survival/man/pyears.html)

Other pyears tidiers:
[`tidy.pyears()`](https://broom.tidymodels.org/dev/reference/tidy.pyears.md)

Other survival tidiers:
[`augment.coxph()`](https://broom.tidymodels.org/dev/reference/augment.coxph.md),
[`augment.survreg()`](https://broom.tidymodels.org/dev/reference/augment.survreg.md),
[`glance.aareg()`](https://broom.tidymodels.org/dev/reference/glance.aareg.md),
[`glance.cch()`](https://broom.tidymodels.org/dev/reference/glance.cch.md),
[`glance.coxph()`](https://broom.tidymodels.org/dev/reference/glance.coxph.md),
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

- nobs:

  Number of observations used.

- total:

  total number of person-years tabulated

- offtable:

  total number of person-years off table

## Examples

``` r
# load libraries for models and data
library(survival)

# generate and format data
temp.yr <- tcut(mgus$dxyr, 55:92, labels = as.character(55:91))
temp.age <- tcut(mgus$age, 34:101, labels = as.character(34:100))
ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
pstat <- ifelse(is.na(mgus$pctime), 0, 1)
pfit <- pyears(Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus,
  data.frame = TRUE
)

# summarize model fit with tidiers
tidy(pfit)
#> # A tibble: 1,752 × 6
#>    temp.yr temp.age sex     pyears     n event
#>    <fct>   <fct>    <fct>    <dbl> <dbl> <dbl>
#>  1 71      34       female 0.00274     1     0
#>  2 68      35       female 0.00274     1     0
#>  3 72      35       female 0.00274     1     0
#>  4 69      36       female 0.00274     1     0
#>  5 73      36       female 0.00274     1     0
#>  6 69      37       female 0.00274     1     0
#>  7 70      37       female 0.00274     1     0
#>  8 74      37       female 0.00274     1     0
#>  9 70      38       female 0.00274     1     0
#> 10 71      38       female 0.00274     1     0
#> # ℹ 1,742 more rows
glance(pfit)
#> # A tibble: 1 × 3
#>   total offtable  nobs
#>   <dbl>    <dbl> <int>
#> 1  8.32    0.727   241

# if data.frame argument is not given, different information is present in
# output
pfit2 <- pyears(Surv(ptime / 365.25, pstat) ~ temp.yr + temp.age + sex, mgus)

tidy(pfit2)
#> # A tibble: 37 × 402
#>    pyears.34.female pyears.35.female pyears.36.female pyears.37.female
#>               <dbl>            <dbl>            <dbl>            <dbl>
#>  1                0                0                0                0
#>  2                0                0                0                0
#>  3                0                0                0                0
#>  4                0                0                0                0
#>  5                0                0                0                0
#>  6                0                0                0                0
#>  7                0                0                0                0
#>  8                0                0                0                0
#>  9                0                0                0                0
#> 10                0                0                0                0
#> # ℹ 27 more rows
#> # ℹ 398 more variables: pyears.38.female <dbl>,
#> #   pyears.39.female <dbl>, pyears.40.female <dbl>,
#> #   pyears.41.female <dbl>, pyears.42.female <dbl>,
#> #   pyears.43.female <dbl>, pyears.44.female <dbl>,
#> #   pyears.45.female <dbl>, pyears.46.female <dbl>,
#> #   pyears.47.female <dbl>, pyears.48.female <dbl>, …
glance(pfit2)
#> # A tibble: 1 × 3
#>   total offtable  nobs
#>   <dbl>    <dbl> <int>
#> 1  8.32    0.727   241
```
