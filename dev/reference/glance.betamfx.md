# Glance at a(n) betamfx object

Glance accepts a model object and returns a
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row of model summaries. The summaries are typically
goodness of fit measures, p-values for hypothesis tests on residuals, or
model convergence information.

Glance never returns information from the original call to the modeling
function. This includes the name of the modeling function or any
arguments passed to the modeling function.

Glance does not calculate summary measures. Rather, it farms out these
computations to appropriate methods and gathers the results together.
Sometimes a goodness of fit measure will be undefined. In these cases
the measure will be reported as `NA`.

Glance returns the same number of columns regardless of whether the
model matrix is rank-deficient or not. If so, entries in columns that no
longer have a well-defined value are filled in with an `NA` of the
appropriate type.

## Usage

``` r
# S3 method for class 'betamfx'
glance(x, ...)
```

## Arguments

- x:

  A `betamfx` object.

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

This glance method wraps
[`glance.betareg()`](https://broom.tidymodels.org/dev/reference/glance.betareg.md)
for [`mfx::betamfx()`](https://rdrr.io/pkg/mfx/man/betamfx.html)
objects.

## See also

[`glance.betareg()`](https://broom.tidymodels.org/dev/reference/glance.betareg.md),
[`mfx::betamfx()`](https://rdrr.io/pkg/mfx/man/betamfx.html)

Other mfx tidiers:
[`augment.betamfx()`](https://broom.tidymodels.org/dev/reference/augment.betamfx.md),
[`augment.mfx()`](https://broom.tidymodels.org/dev/reference/augment.mfx.md),
[`glance.mfx()`](https://broom.tidymodels.org/dev/reference/glance.mfx.md),
[`tidy.betamfx()`](https://broom.tidymodels.org/dev/reference/tidy.betamfx.md),
[`tidy.mfx()`](https://broom.tidymodels.org/dev/reference/tidy.mfx.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- df.null:

  Degrees of freedom used by the null model.

- df.residual:

  Residual degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- pseudo.r.squared:

  Like the R squared statistic, but for situations when the R squared
  statistic isn't defined.

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
