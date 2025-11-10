# Tidy a(n) aovlist object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'aovlist'
tidy(x, ...)
```

## Arguments

- x:

  An `aovlist` objects, such as those created by
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
[`tidy.aov()`](https://broom.tidymodels.org/dev/reference/tidy.aov.md),
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

- stratum:

  The error stratum.

- sumsq:

  Sum of squares explained by this term.

- term:

  The name of the regression term.

## Examples

``` r
a <- aov(mpg ~ wt + qsec + Error(disp / am), mtcars)
tidy(a)
#> # A tibble: 5 × 7
#>   stratum term         df   sumsq  meansq statistic  p.value
#>   <chr>   <chr>     <dbl>   <dbl>   <dbl>     <dbl>    <dbl>
#> 1 disp    wt            1 809.    809.        NA    NA      
#> 2 disp:am wt            1   0.389   0.389     NA    NA      
#> 3 Within  wt            1  87.2    87.2       12.0   0.00176
#> 4 Within  qsec          1  34.2    34.2        4.72  0.0387 
#> 5 Within  Residuals    27 195.      7.24      NA    NA      
```
