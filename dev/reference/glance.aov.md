# Glance at a(n) lm object

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
# S3 method for class 'aov'
glance(x, ...)
```

## Arguments

- x:

  An `aov` object, such as those created by
  [`stats::aov()`](https://rdrr.io/r/stats/aov.html).

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

## Note

Note that
[`tidy.aov()`](https://broom.tidymodels.org/dev/reference/tidy.aov.md)
now contains the numerator and denominator degrees of freedom, which
were included in the output of `glance.aov()` in some previous versions
of the package.

## See also

[`glance()`](https://generics.r-lib.org/reference/glance.html)

Other anova tidiers:
[`glance.anova()`](https://broom.tidymodels.org/dev/reference/glance.anova.md),
[`tidy.TukeyHSD()`](https://broom.tidymodels.org/dev/reference/tidy.TukeyHSD.md),
[`tidy.anova()`](https://broom.tidymodels.org/dev/reference/tidy.anova.md),
[`tidy.aov()`](https://broom.tidymodels.org/dev/reference/tidy.aov.md),
[`tidy.aovlist()`](https://broom.tidymodels.org/dev/reference/tidy.aovlist.md),
[`tidy.manova()`](https://broom.tidymodels.org/dev/reference/tidy.manova.md)

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

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

## Examples

``` r
a <- aov(mpg ~ wt + qsec + disp, mtcars)
tidy(a)
#> # A tibble: 4 × 6
#>   term         df     sumsq    meansq  statistic   p.value
#>   <chr>     <dbl>     <dbl>     <dbl>      <dbl>     <dbl>
#> 1 wt            1 848.      848.      121.        1.08e-11
#> 2 qsec          1  82.9      82.9      11.9       1.82e- 3
#> 3 disp          1   0.00102   0.00102   0.000147  9.90e- 1
#> 4 Residuals    28 195.        6.98     NA        NA       
```
