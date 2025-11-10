# Glance at a(n) survdiff object

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
# S3 method for class 'survdiff'
glance(x, ...)
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

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`survival::survdiff()`](https://rdrr.io/pkg/survival/man/survdiff.html)

Other survdiff tidiers:
[`tidy.survdiff()`](https://broom.tidymodels.org/dev/reference/tidy.survdiff.md)

Other survival tidiers:
[`augment.coxph()`](https://broom.tidymodels.org/dev/reference/augment.coxph.md),
[`augment.survreg()`](https://broom.tidymodels.org/dev/reference/augment.survreg.md),
[`glance.aareg()`](https://broom.tidymodels.org/dev/reference/glance.aareg.md),
[`glance.cch()`](https://broom.tidymodels.org/dev/reference/glance.cch.md),
[`glance.coxph()`](https://broom.tidymodels.org/dev/reference/glance.coxph.md),
[`glance.pyears()`](https://broom.tidymodels.org/dev/reference/glance.pyears.md),
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

- p.value:

  P-value corresponding to the test statistic.

- statistic:

  Test statistic.

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
