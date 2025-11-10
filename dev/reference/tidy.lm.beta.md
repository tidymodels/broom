# Tidy a(n) lm.beta object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'lm.beta'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  An `lm.beta` object created by
  [lm.beta::lm.beta](https://rdrr.io/pkg/lm.beta/man/lm.beta.html).

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

If the linear model is an `mlm` object (multiple linear model), there is
an additional column `response`.

If you have missing values in your model data, you may need to refit the
model with `na.action = na.exclude`.

## See also

Other lm tidiers:
[`augment.glm()`](https://broom.tidymodels.org/dev/reference/augment.glm.md),
[`augment.lm()`](https://broom.tidymodels.org/dev/reference/augment.lm.md),
[`glance.glm()`](https://broom.tidymodels.org/dev/reference/glance.glm.md),
[`glance.lm()`](https://broom.tidymodels.org/dev/reference/glance.lm.md),
[`glance.summary.lm()`](https://broom.tidymodels.org/dev/reference/glance.summary.lm.md),
[`glance.svyglm()`](https://broom.tidymodels.org/dev/reference/glance.svyglm.md),
[`tidy.glm()`](https://broom.tidymodels.org/dev/reference/tidy.glm.md),
[`tidy.lm()`](https://broom.tidymodels.org/dev/reference/tidy.lm.md),
[`tidy.mlm()`](https://broom.tidymodels.org/dev/reference/tidy.mlm.md),
[`tidy.summary.lm()`](https://broom.tidymodels.org/dev/reference/tidy.summary.lm.md)

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

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

## Examples

``` r
# load libraries for models and data
library(lm.beta)

# fit models
mod <- stats::lm(speed ~ ., data = cars)
std <- lm.beta(mod)

# summarize model fit with tidiers
tidy(std, conf.int = TRUE)
#> # A tibble: 2 × 8
#>   term      estimate std_estimate std.error statistic  p.value conf.low
#>   <chr>        <dbl>        <dbl>     <dbl>     <dbl>    <dbl>    <dbl>
#> 1 (Interce…    8.28        NA        0.874       9.47 1.44e-12   NA    
#> 2 dist         0.166        0.807    0.0175      9.46 1.49e-12    0.772
#> # ℹ 1 more variable: conf.high <dbl>

# generate data
ctl <- c(4.17, 5.58, 5.18, 6.11, 4.50, 4.61, 5.17, 4.53, 5.33, 5.14)
trt <- c(4.81, 4.17, 4.41, 3.59, 5.87, 3.83, 6.03, 4.89, 4.32, 4.69)
group <- gl(2, 10, 20, labels = c("Ctl", "Trt"))
weight <- c(ctl, trt)

# fit models
mod2 <- lm(weight ~ group)
std2 <- lm.beta(mod2)

# summarize model fit with tidiers
tidy(std2, conf.int = TRUE)
#> # A tibble: 2 × 8
#>   term      estimate std_estimate std.error statistic  p.value conf.low
#>   <chr>        <dbl>        <dbl>     <dbl>     <dbl>    <dbl>    <dbl>
#> 1 (Interce…    5.03        NA         0.220     22.9  9.55e-15   NA    
#> 2 groupTrt    -0.371       -0.270     0.311     -1.19 2.49e- 1   -0.925
#> # ℹ 1 more variable: conf.high <dbl>
```
