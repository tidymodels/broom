# Tidy/glance a(n) durbinWatsonTest object

For models that have only a single component, the
[`tidy()`](https://generics.r-lib.org/reference/tidy.html) and
[`glance()`](https://generics.r-lib.org/reference/glance.html) methods
are identical. Please see the documentation for both of those methods.

## Usage

``` r
# S3 method for class 'durbinWatsonTest'
tidy(x, ...)

# S3 method for class 'durbinWatsonTest'
glance(x, ...)
```

## Arguments

- x:

  An object of class `durbinWatsonTest` created by a call to
  [`car::durbinWatsonTest()`](https://rdrr.io/pkg/car/man/durbinWatsonTest.html).

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
[`car::durbinWatsonTest()`](https://rdrr.io/pkg/car/man/durbinWatsonTest.html)

Other car tidiers:
[`leveneTest_tidiers`](https://broom.tidymodels.org/dev/reference/leveneTest_tidiers.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- alternative:

  Alternative hypothesis (character).

- autocorrelation:

  Autocorrelation.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  Test statistic for Durbin-Watson test.

- method:

  Always \`Durbin-Watson Test\`.

## Examples

``` r
# load modeling library
library(car)

# fit model
dw <- durbinWatsonTest(lm(mpg ~ wt, data = mtcars))

# summarize model fit with tidiers
tidy(dw)
#> # A tibble: 1 × 5
#>   statistic p.value autocorrelation method             alternative
#>       <dbl>   <dbl>           <dbl> <chr>              <chr>      
#> 1      1.25  0.0160           0.363 Durbin-Watson Test two.sided  

# same output for all durbinWatsonTests
glance(dw)
#> # A tibble: 1 × 5
#>   statistic p.value autocorrelation method             alternative
#>       <dbl>   <dbl>           <dbl> <chr>              <chr>      
#> 1      1.25  0.0160           0.363 Durbin-Watson Test two.sided  
```
