# Tidy a(n) aov object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'aov'
tidy(x, intercept = FALSE, ...)
```

## Arguments

- x:

  An `aov` object, such as those created by
  [`stats::aov()`](https://rdrr.io/r/stats/aov.html).

- intercept:

  A logical indicating whether information on the intercept ought to be
  included. Passed to
  [`stats::summary.aov()`](https://rdrr.io/r/stats/summary.aov.html).

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
[`stats::aov()`](https://rdrr.io/r/stats/aov.html)

Other anova tidiers:
[`glance.anova()`](https://broom.tidymodels.org/dev/reference/glance.anova.md),
[`glance.aov()`](https://broom.tidymodels.org/dev/reference/glance.aov.md),
[`tidy.TukeyHSD()`](https://broom.tidymodels.org/dev/reference/tidy.TukeyHSD.md),
[`tidy.anova()`](https://broom.tidymodels.org/dev/reference/tidy.anova.md),
[`tidy.aovlist()`](https://broom.tidymodels.org/dev/reference/tidy.aovlist.md),
[`tidy.manova()`](https://broom.tidymodels.org/dev/reference/tidy.manova.md)

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
