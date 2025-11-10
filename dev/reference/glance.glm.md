# Glance at a(n) glm object

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
# S3 method for class 'glm'
glance(x, ...)
```

## Arguments

- x:

  A `glm` object returned from
  [`stats::glm()`](https://rdrr.io/r/stats/glm.html).

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

[`stats::glm()`](https://rdrr.io/r/stats/glm.html)

Other lm tidiers:
[`augment.glm()`](https://broom.tidymodels.org/dev/reference/augment.glm.md),
[`augment.lm()`](https://broom.tidymodels.org/dev/reference/augment.lm.md),
[`glance.lm()`](https://broom.tidymodels.org/dev/reference/glance.lm.md),
[`glance.summary.lm()`](https://broom.tidymodels.org/dev/reference/glance.summary.lm.md),
[`glance.svyglm()`](https://broom.tidymodels.org/dev/reference/glance.svyglm.md),
[`tidy.glm()`](https://broom.tidymodels.org/dev/reference/tidy.glm.md),
[`tidy.lm()`](https://broom.tidymodels.org/dev/reference/tidy.lm.md),
[`tidy.lm.beta()`](https://broom.tidymodels.org/dev/reference/tidy.lm.beta.md),
[`tidy.mlm()`](https://broom.tidymodels.org/dev/reference/tidy.mlm.md),
[`tidy.summary.lm()`](https://broom.tidymodels.org/dev/reference/tidy.summary.lm.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- deviance:

  Deviance of the model.

- df.null:

  Degrees of freedom used by the null model.

- df.residual:

  Residual degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- null.deviance:

  Deviance of the null model.

## Examples

``` r
g <- glm(am ~ mpg, mtcars, family = "binomial")
glance(g)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          43.2      31  -14.8  33.7  36.6     29.7          30    32
```
