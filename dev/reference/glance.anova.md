# Glance at a(n) anova object

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
# S3 method for class 'anova'
glance(x, ...)
```

## Arguments

- x:

  An `anova` object, such as those created by
  [`stats::anova()`](https://rdrr.io/r/stats/anova.html),
  [`car::Anova()`](https://rdrr.io/pkg/car/man/Anova.html),
  [`car::leveneTest()`](https://rdrr.io/pkg/car/man/leveneTest.html), or
  [`car::linearHypothesis()`](https://rdrr.io/pkg/car/man/linearHypothesis.html).

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

Note that the output of `glance.anova()` will vary depending on the
initializing anova call. In some cases, it will just return an empty
data frame. In other cases, `glance.anova()` may return columns that are
also common to
[`tidy.anova()`](https://broom.tidymodels.org/dev/reference/tidy.anova.md).
This is partly to preserve backwards compatibility with early versions
of `broom`, but also because the underlying anova model yields
components that could reasonably be interpreted as goodness-of-fit
summaries too.

## See also

[`glance()`](https://generics.r-lib.org/reference/glance.html)

Other anova tidiers:
[`glance.aov()`](https://broom.tidymodels.org/dev/reference/glance.aov.md),
[`tidy.TukeyHSD()`](https://broom.tidymodels.org/dev/reference/tidy.TukeyHSD.md),
[`tidy.anova()`](https://broom.tidymodels.org/dev/reference/tidy.anova.md),
[`tidy.aov()`](https://broom.tidymodels.org/dev/reference/tidy.aov.md),
[`tidy.aovlist()`](https://broom.tidymodels.org/dev/reference/tidy.aovlist.md),
[`tidy.manova()`](https://broom.tidymodels.org/dev/reference/tidy.manova.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- deviance:

  Deviance of the model.

- df.residual:

  Residual degrees of freedom.

## Examples

``` r
if (FALSE) {

# fit models
a <- lm(mpg ~ wt + qsec + disp, mtcars)
b <- lm(mpg ~ wt + qsec, mtcars)

mod <- anova(a, b)

# summarize model fit with tidiers
tidy(mod)
glance(mod)

# car::linearHypothesis() example
library(car)
mod_lht <- linearHypothesis(a, "wt - disp")
tidy(mod_lht)
glance(mod_lht)
}
```
