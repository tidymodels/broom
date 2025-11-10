# Tidy a(n) anova object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'anova'
tidy(x, ...)
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

## Details

The `term` column of an ANOVA table can come with leading or trailing
whitespace, which this tidying method trims.

For documentation on the tidier for
[`car::leveneTest()`](https://rdrr.io/pkg/car/man/leveneTest.html)
output, see
[`tidy.leveneTest()`](https://broom.tidymodels.org/dev/reference/leveneTest_tidiers.md)

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`stats::anova()`](https://rdrr.io/r/stats/anova.html),
[`car::Anova()`](https://rdrr.io/pkg/car/man/Anova.html),
[`car::leveneTest()`](https://rdrr.io/pkg/car/man/leveneTest.html)

Other anova tidiers:
[`glance.anova()`](https://broom.tidymodels.org/dev/reference/glance.anova.md),
[`glance.aov()`](https://broom.tidymodels.org/dev/reference/glance.aov.md),
[`tidy.TukeyHSD()`](https://broom.tidymodels.org/dev/reference/tidy.TukeyHSD.md),
[`tidy.aov()`](https://broom.tidymodels.org/dev/reference/tidy.aov.md),
[`tidy.aovlist()`](https://broom.tidymodels.org/dev/reference/tidy.aovlist.md),
[`tidy.manova()`](https://broom.tidymodels.org/dev/reference/tidy.manova.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- df:

  Degrees of freedom used by this term in the model.

- meansq:

  Mean sum of squares. Equal to total sum of squares divided by degrees
  of freedom.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- sumsq:

  Sum of squares explained by this term.

- term:

  The name of the regression term.

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
