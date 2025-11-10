# Tidy a(n) systemfit object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'systemfit'
tidy(x, conf.int = TRUE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `systemfit` object produced by a call to
  [`systemfit::systemfit()`](https://rdrr.io/pkg/systemfit/man/systemfit.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

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

This tidy method works with any model objects of class `systemfit`.
Default returns a tibble of six columns.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`systemfit::systemfit()`](https://rdrr.io/pkg/systemfit/man/systemfit.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- estimate:

  The estimated value of the regression term.

- p.value:

  The two-sided p-value associated with the observed statistic.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

## Examples

``` r
set.seed(27)

# load libraries for models and data
library(systemfit)
#> 
#> Please cite the 'systemfit' package as:
#> Arne Henningsen and Jeff D. Hamann (2007). systemfit: A Package for Estimating Systems of Simultaneous Equations in R. Journal of Statistical Software 23(4), 1-40. http://www.jstatsoft.org/v23/i04/.
#> 
#> If you have questions, suggestions, or comments regarding the 'systemfit' package, please use a forum or 'tracker' at systemfit's R-Forge site:
#> https://r-forge.r-project.org/projects/systemfit/

# generate data
df <- data.frame(
  X = rnorm(100),
  Y = rnorm(100),
  Z = rnorm(100),
  W = rnorm(100)
)

# fit model
fit <- systemfit(formula = list(Y ~ Z, W ~ X), data = df, method = "SUR")

# summarize model fit with tidiers
tidy(fit)
#> # A tibble: 4 × 7
#>   term          estimate std.error statistic p.value conf.low conf.high
#>   <chr>            <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 eq1_(Interce…   0.109     0.0981     1.11    0.269  -0.0857    0.304 
#> 2 eq1_Z          -0.0808    0.0934    -0.865   0.389  -0.266     0.105 
#> 3 eq2_(Interce…  -0.0495    0.110     -0.449   0.655  -0.269     0.170 
#> 4 eq2_X          -0.133     0.103     -1.30    0.198  -0.337     0.0707
tidy(fit, conf.int = TRUE)
#> # A tibble: 4 × 7
#>   term          estimate std.error statistic p.value conf.low conf.high
#>   <chr>            <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 eq1_(Interce…   0.109     0.0981     1.11    0.269  -0.0857    0.304 
#> 2 eq1_Z          -0.0808    0.0934    -0.865   0.389  -0.266     0.105 
#> 3 eq2_(Interce…  -0.0495    0.110     -0.449   0.655  -0.269     0.170 
#> 4 eq2_X          -0.133     0.103     -1.30    0.198  -0.337     0.0707
```
