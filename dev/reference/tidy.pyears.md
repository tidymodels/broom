# Tidy a(n) pyears object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'pyears'
tidy(x, ...)
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

## Details

`expected` is only present in the output when if a `ratetable` term is
present.

If the `data.frame = TRUE` argument is supplied to `pyears`, this is
simply the contents of `x$data`.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`survival::pyears()`](https://rdrr.io/pkg/survival/man/pyears.html)

Other pyears tidiers:
[`glance.pyears()`](https://broom.tidymodels.org/dev/reference/glance.pyears.md)

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
[`glance.survreg()`](https://broom.tidymodels.org/dev/reference/glance.survreg.md),
[`tidy.aareg()`](https://broom.tidymodels.org/dev/reference/tidy.aareg.md),
[`tidy.cch()`](https://broom.tidymodels.org/dev/reference/tidy.cch.md),
[`tidy.coxph()`](https://broom.tidymodels.org/dev/reference/tidy.coxph.md),
[`tidy.survdiff()`](https://broom.tidymodels.org/dev/reference/tidy.survdiff.md),
[`tidy.survexp()`](https://broom.tidymodels.org/dev/reference/tidy.survexp.md),
[`tidy.survfit()`](https://broom.tidymodels.org/dev/reference/tidy.survfit.md),
[`tidy.survreg()`](https://broom.tidymodels.org/dev/reference/tidy.survreg.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- expected:

  Expected number of events.

- pyears:

  Person-years of exposure.

- n:

  number of subjects contributing time

- event:

  observed number of events

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
