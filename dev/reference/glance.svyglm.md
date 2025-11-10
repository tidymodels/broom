# Glance at a(n) svyglm object

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
# S3 method for class 'svyglm'
glance(x, maximal = x, ...)
```

## Arguments

- x:

  A `svyglm` object returned from
  [`survey::svyglm()`](https://rdrr.io/pkg/survey/man/svyglm.html).

- maximal:

  A `svyglm` object corresponding to the maximal model against which to
  compute the BIC. See Lumley and Scott (2015) for details. Defaults to
  `x`, which is equivalent to not using a maximal model.

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

## References

Lumley T, Scott A (2015). AIC and BIC for modelling with complex survey
data. *Journal of Survey Statistics and Methodology*, 3(1).

## See also

[`survey::svyglm()`](https://rdrr.io/pkg/survey/man/svyglm.html),
[`stats::glm()`](https://rdrr.io/r/stats/glm.html),
[survey::anova.svyglm](https://rdrr.io/pkg/survey/man/anova.svyglm.html)

Other lm tidiers:
[`augment.glm()`](https://broom.tidymodels.org/dev/reference/augment.glm.md),
[`augment.lm()`](https://broom.tidymodels.org/dev/reference/augment.lm.md),
[`glance.glm()`](https://broom.tidymodels.org/dev/reference/glance.glm.md),
[`glance.lm()`](https://broom.tidymodels.org/dev/reference/glance.lm.md),
[`glance.summary.lm()`](https://broom.tidymodels.org/dev/reference/glance.summary.lm.md),
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

- null.deviance:

  Deviance of the null model.

## Examples

``` r
# load libraries for models and data
library(survey)
#> Loading required package: grid
#> 
#> Attaching package: ‘survey’
#> The following object is masked from ‘package:drc’:
#> 
#>     twophase
#> The following object is masked from ‘package:graphics’:
#> 
#>     dotchart

set.seed(123)
data(api)

# survey design
dstrat <-
  svydesign(
    id = ~1,
    strata = ~stype,
    weights = ~pw,
    data = apistrat,
    fpc = ~fpc
  )

# model
m <- svyglm(
  formula = sch.wide ~ ell + meals + mobility,
  design = dstrat,
  family = quasibinomial()
)

glance(m)
#> # A tibble: 1 × 7
#>   null.deviance df.null   AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int> <dbl> <dbl>    <dbl>       <dbl> <int>
#> 1          184.     199  184.  199.     178.         194   200
```
