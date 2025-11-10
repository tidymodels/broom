# Tidy/glance a(n) leveneTest object

For models that have only a single component, the
[`tidy()`](https://generics.r-lib.org/reference/tidy.html) and
[`glance()`](https://generics.r-lib.org/reference/glance.html) methods
are identical. Please see the documentation for both of those methods.

## Usage

``` r
# S3 method for class 'leveneTest'
tidy(x, ...)
```

## Arguments

- x:

  An object of class `anova` created by a call to
  [`car::leveneTest()`](https://rdrr.io/pkg/car/man/leveneTest.html).

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
[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`car::leveneTest()`](https://rdrr.io/pkg/car/man/leveneTest.html)

Other car tidiers:
[`durbinWatsonTest_tidiers`](https://broom.tidymodels.org/dev/reference/durbinWatsonTest_tidiers.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- df:

  Degrees of freedom used by this term in the model.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- df.residual:

  Residual degrees of freedom.

## Examples

``` r
# load libraries for models and data
library(car)

data(Moore)

lt <- with(Moore, leveneTest(conformity, fcategory))

tidy(lt)
#> # A tibble: 1 × 4
#>   statistic p.value    df df.residual
#>       <dbl>   <dbl> <int>       <int>
#> 1    0.0460   0.955     2          42
glance(lt)
#> # A tibble: 0 × 0
```
