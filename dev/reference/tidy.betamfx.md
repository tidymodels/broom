# Tidy a(n) betamfx object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'betamfx'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `betamfx` object.

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

The `mfx` package provides methods for calculating marginal effects for
various generalized linear models (GLMs). Unlike standard linear models,
estimated model coefficients in a GLM cannot be directly interpreted as
marginal effects (i.e., the change in the response variable predicted
after a one unit change in one of the regressors). This is because the
estimated coefficients are multiplicative, dependent on both the link
function that was used for the estimation and any other variables that
were included in the model. When calculating marginal effects, users
must typically choose whether they want to use i) the average
observation in the data, or ii) the average of the sample marginal
effects. See
[`vignette("mfxarticle")`](https://cran.rstudio.com/web/packages/mfx/vignettes/mfxarticle.pdf)
from the `mfx` package for more details.

## See also

[`tidy.betareg()`](https://broom.tidymodels.org/dev/reference/tidy.betareg.md),
[`mfx::betamfx()`](https://rdrr.io/pkg/mfx/man/betamfx.html)

Other mfx tidiers:
[`augment.betamfx()`](https://broom.tidymodels.org/dev/reference/augment.betamfx.md),
[`augment.mfx()`](https://broom.tidymodels.org/dev/reference/augment.mfx.md),
[`glance.betamfx()`](https://broom.tidymodels.org/dev/reference/glance.betamfx.md),
[`glance.mfx()`](https://broom.tidymodels.org/dev/reference/glance.mfx.md),
[`tidy.mfx()`](https://broom.tidymodels.org/dev/reference/tidy.mfx.md)

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

- atmean:

  TRUE if the marginal effects were originally calculated as the partial
  effects for the average observation. If FALSE, then these were instead
  calculated as average partial effects.

## Examples

``` r
library(mfx)

# Simulate some data
set.seed(12345)
n <- 1000
x <- rnorm(n)

# Beta outcome
y <- rbeta(n, shape1 = plogis(1 + 0.5 * x), shape2 = (abs(0.2 * x)))
# Use Smithson and Verkuilen correction
y <- (y * (n - 1) + 0.5) / n

d <- data.frame(y, x)
mod_betamfx <- betamfx(y ~ x | x, data = d)

tidy(mod_betamfx, conf.int = TRUE)
#> # A tibble: 1 × 8
#>   term  atmean estimate std.error statistic p.value conf.low conf.high
#>   <chr> <lgl>     <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 x     TRUE     0.0226   0.00801      2.82 0.00483  0.00686    0.0383

# Compare with the naive model coefficients of the equivalent betareg call (not run)
# tidy(betamfx(y ~ x | x, data = d), conf.int = TRUE)

augment(mod_betamfx)
#> # A tibble: 1,000 × 4
#>        y      x .fitted   .cooksd
#>    <dbl>  <dbl>   <dbl>     <dbl>
#>  1 0.951  0.586   0.809 0.000189 
#>  2 0.714  0.709   0.811 0.0000993
#>  3 0.999 -0.109   0.793 0.000273 
#>  4 0.998 -0.453   0.785 0.000334 
#>  5 0.999  0.606   0.809 0.000342 
#>  6 0.562 -1.82    0.751 0.000878 
#>  7 0.999  0.630   0.810 0.000348 
#>  8 0.999 -0.276   0.789 0.000294 
#>  9 0.744 -0.284   0.789 0.0000134
#> 10 0.999 -0.919   0.774 0.000551 
#> # ℹ 990 more rows
glance(mod_betamfx)
#> # A tibble: 1 × 7
#>   pseudo.r.squared df.null logLik    AIC    BIC df.residual  nobs
#>              <dbl>   <dbl>  <dbl>  <dbl>  <dbl>       <int> <int>
#> 1          0.00726     998  1897. -3787. -3767.         996  1000
```
