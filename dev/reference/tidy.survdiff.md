# Tidy a(n) survdiff object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'survdiff'
tidy(x, ...)
```

## Arguments

- x:

  An `survdiff` object returned from
  [`survival::survdiff()`](https://rdrr.io/pkg/survival/man/survdiff.html).

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
[`survival::survdiff()`](https://rdrr.io/pkg/survival/man/survdiff.html)

Other survdiff tidiers:
[`glance.survdiff()`](https://broom.tidymodels.org/dev/reference/glance.survdiff.md)

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
[`tidy.pyears()`](https://broom.tidymodels.org/dev/reference/tidy.pyears.md),
[`tidy.survexp()`](https://broom.tidymodels.org/dev/reference/tidy.survexp.md),
[`tidy.survfit()`](https://broom.tidymodels.org/dev/reference/tidy.survfit.md),
[`tidy.survreg()`](https://broom.tidymodels.org/dev/reference/tidy.survreg.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- exp:

  Weighted expected number of events in each group.

- N:

  Number of subjects in each group.

- obs:

  weighted observed number of events in each group.

## Examples

``` r
# load libraries for models and data
library(survival)

# fit model
s <- survdiff(
  Surv(time, status) ~ pat.karno + strata(inst),
  data = lung
)

# summarize model fit with tidiers
tidy(s)
#> # A tibble: 8 × 4
#>   pat.karno     N   obs    exp
#>   <chr>     <dbl> <dbl>  <dbl>
#> 1 30            2     1  0.692
#> 2 40            2     1  1.10 
#> 3 50            4     4  1.17 
#> 4 60           30    27 16.3  
#> 5 70           41    31 26.4  
#> 6 80           50    38 41.9  
#> 7 90           60    38 47.2  
#> 8 100          35    21 26.2  
glance(s)
#> # A tibble: 1 × 3
#>   statistic    df p.value
#>       <dbl> <dbl>   <dbl>
#> 1      21.4     7 0.00326
```
