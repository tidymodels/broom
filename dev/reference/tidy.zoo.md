# Tidy a(n) zoo object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'zoo'
tidy(x, ...)
```

## Arguments

- x:

  A `zoo` object such as those created by
  [`zoo::zoo()`](https://rdrr.io/pkg/zoo/man/zoo.html).

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
[`zoo::zoo()`](https://rdrr.io/pkg/zoo/man/zoo.html)

Other time series tidiers:
[`tidy.acf()`](https://broom.tidymodels.org/dev/reference/tidy.acf.md),
[`tidy.spec()`](https://broom.tidymodels.org/dev/reference/tidy.spec.md),
[`tidy.ts()`](https://broom.tidymodels.org/dev/reference/tidy.ts.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- index:

  Index (i.e. date or time) for a \`ts\` or \`zoo\` object.

- series:

  Name of the series (present only for multivariate time series).

- value:

  The value/estimate of the component. Results from data reshaping.

## Examples

``` r
# load libraries for models and data
library(zoo)
library(ggplot2)

set.seed(1071)

# generate data
Z.index <- as.Date(sample(12450:12500, 10))
Z.data <- matrix(rnorm(30), ncol = 3)
colnames(Z.data) <- c("Aa", "Bb", "Cc")
Z <- zoo(Z.data, Z.index)

# summarize model fit with tidiers + visualization
tidy(Z)
#> # A tibble: 30 × 3
#>    index      series   value
#>    <date>     <chr>    <dbl>
#>  1 2004-02-02 Aa     -0.537 
#>  2 2004-02-02 Bb      0.746 
#>  3 2004-02-02 Cc     -0.634 
#>  4 2004-02-06 Aa     -0.586 
#>  5 2004-02-06 Bb     -0.0779
#>  6 2004-02-06 Cc      0.0397
#>  7 2004-02-08 Aa     -0.289 
#>  8 2004-02-08 Bb     -1.11  
#>  9 2004-02-08 Cc     -0.341 
#> 10 2004-02-12 Aa      1.85  
#> # ℹ 20 more rows

ggplot(tidy(Z), aes(index, value, color = series)) +
  geom_line()


ggplot(tidy(Z), aes(index, value)) +
  geom_line() +
  facet_wrap(~series, ncol = 1)


Zrolled <- rollmean(Z, 5)
ggplot(tidy(Zrolled), aes(index, value, color = series)) +
  geom_line()
```
