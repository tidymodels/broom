# Glance at a(n) glmRob object

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
# S3 method for class 'glmRob'
glance(x, ...)
```

## Arguments

- x:

  A `glmRob` object returned from
  [`robust::glmRob()`](https://rdrr.io/pkg/robust/man/glmRob.html).

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

[`robust::glmRob()`](https://rdrr.io/pkg/robust/man/glmRob.html)

Other robust tidiers:
[`augment.lmRob()`](https://broom.tidymodels.org/dev/reference/augment.lmRob.md),
[`glance.lmRob()`](https://broom.tidymodels.org/dev/reference/glance.lmRob.md),
[`tidy.glmRob()`](https://broom.tidymodels.org/dev/reference/tidy.glmRob.md),
[`tidy.lmRob()`](https://broom.tidymodels.org/dev/reference/tidy.lmRob.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- deviance:

  Deviance of the model.

- df.residual:

  Residual degrees of freedom.

- nobs:

  Number of observations used.

- null.deviance:

  Deviance of the null model.

- sigma:

  Estimated standard error of the residuals.

## Examples

``` r
# load libraries for models and data
library(robust)

# fit model
gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")

# summarize model fit with tidiers
tidy(gm)
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)    12.0       4.51      2.67 0.00759
#> 2 wt             -4.02      1.44     -2.80 0.00509
glance(gm)
#> # A tibble: 1 × 5
#>   deviance sigma null.deviance df.residual  nobs
#>      <dbl> <dbl>         <dbl>       <int> <int>
#> 1     19.2 0.800          44.4          30    32
```
