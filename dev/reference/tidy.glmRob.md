# Tidy a(n) glmRob object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'glmRob'
tidy(x, ...)
```

## Arguments

- x:

  A `glmRob` object returned from
  [`robust::glmRob()`](https://rdrr.io/pkg/robust/man/glmRob.html).

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

For tidiers for robust models from the MASS package see
[`tidy.rlm()`](https://broom.tidymodels.org/dev/reference/tidy.rlm.md).

## See also

[`robust::glmRob()`](https://rdrr.io/pkg/robust/man/glmRob.html)

Other robust tidiers:
[`augment.lmRob()`](https://broom.tidymodels.org/dev/reference/augment.lmRob.md),
[`glance.glmRob()`](https://broom.tidymodels.org/dev/reference/glance.glmRob.md),
[`glance.lmRob()`](https://broom.tidymodels.org/dev/reference/glance.lmRob.md),
[`tidy.lmRob()`](https://broom.tidymodels.org/dev/reference/tidy.lmRob.md)

## Examples

``` r
# load libraries for models and data
library(robust)

# fit model
gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")

# summarize model fit with tidiers
tidy(gm)
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)    12.0       4.51      2.67 0.00759
#> 2 wt             -4.02      1.44     -2.80 0.00509
glance(gm)
#> # A tibble: 1 × 5
#>   deviance sigma null.deviance df.residual  nobs
#>      <dbl> <dbl>         <dbl>       <int> <int>
#> 1     19.2 0.800          44.4          30    32
```
