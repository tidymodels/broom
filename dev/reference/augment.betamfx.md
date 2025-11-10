# Augment data with information from a(n) betamfx object

Augment accepts a model object and a dataset and adds information about
each observation in the dataset. Most commonly, this includes predicted
values in the `.fitted` column, residuals in the `.resid` column, and
standard errors for the fitted values in a `.se.fit` column. New columns
always begin with a `.` prefix to avoid overwriting columns in the
original dataset.

Users may pass data to augment via either the `data` argument or the
`newdata` argument. If the user passes data to the `data` argument, it
**must** be exactly the data that was used to fit the model object. Pass
datasets to `newdata` to augment data that was not used during model
fitting. This still requires that at least all predictor variable
columns used to fit the model are present. If the original outcome
variable used to fit the model is not included in `newdata`, then no
`.resid` column will be included in the output.

Augment will often behave differently depending on whether `data` or
`newdata` is given. This is because there is often information
associated with training observations (such as influences or related)
measures that is not meaningfully defined for new observations.

For convenience, many augment methods provide default `data` arguments,
so that `augment(fit)` will return the augmented training data. In these
cases, augment tries to reconstruct the original data based on the model
object with varying degrees of success.

The augmented dataset is always returned as a
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with the **same number of rows** as the passed dataset. This means that
the passed data must be coercible to a tibble. If a predictor enters the
model as part of a matrix of covariates, such as when the model formula
uses [`splines::ns()`](https://rdrr.io/r/splines/ns.html),
[`stats::poly()`](https://rdrr.io/r/stats/poly.html), or
[`survival::Surv()`](https://rdrr.io/pkg/survival/man/Surv.html), it is
represented as a matrix column.

We are in the process of defining behaviors for models fit with various
`na.action` arguments, but make no guarantees about behavior when data
is missing at this time.

## Usage

``` r
# S3 method for class 'betamfx'
augment(
  x,
  data = model.frame(x$fit),
  newdata = NULL,
  type.predict = c("response", "link", "precision", "variance", "quantile"),
  type.residuals = c("sweighted2", "deviance", "pearson", "response", "weighted",
    "sweighted"),
  ...
)
```

## Arguments

- x:

  A `betamfx` object.

- data:

  A [base::data.frame](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing the original data that was used to produce the object `x`.
  Defaults to `stats::model.frame(x)` so that `augment(my_fit)` returns
  the augmented original data. **Do not** pass new data to the `data`
  argument. Augment will report information such as influence and cooks
  distance for data passed to the `data` argument. These measures are
  only defined for the original training data.

- newdata:

  A [`base::data.frame()`](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing all the original predictors used to create `x`. Defaults to
  `NULL`, indicating that nothing has been passed to `newdata`. If
  `newdata` is specified, the `data` argument will be ignored.

- type.predict:

  Character indicating type of prediction to use. Passed to the `type`
  argument of
  [`betareg::predict.betareg()`](https://rdrr.io/pkg/betareg/man/predict.betareg.html).
  Defaults to `"response"`.

- type.residuals:

  Character indicating type of residuals to use. Passed to the `type`
  argument of
  [`betareg::residuals.betareg()`](https://rdrr.io/pkg/betareg/man/residuals.betareg.html).
  Defaults to `"sweighted2`.

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

This augment method wraps
[`augment.betareg()`](https://broom.tidymodels.org/dev/reference/augment.betareg.md)
for [`mfx::betamfx()`](https://rdrr.io/pkg/mfx/man/betamfx.html)
objects.

## See also

[`augment.betareg()`](https://broom.tidymodels.org/dev/reference/augment.betareg.md),
[`mfx::betamfx()`](https://rdrr.io/pkg/mfx/man/betamfx.html)

Other mfx tidiers:
[`augment.mfx()`](https://broom.tidymodels.org/dev/reference/augment.mfx.md),
[`glance.betamfx()`](https://broom.tidymodels.org/dev/reference/glance.betamfx.md),
[`glance.mfx()`](https://broom.tidymodels.org/dev/reference/glance.mfx.md),
[`tidy.betamfx()`](https://broom.tidymodels.org/dev/reference/tidy.betamfx.md),
[`tidy.mfx()`](https://broom.tidymodels.org/dev/reference/tidy.mfx.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .cooksd:

  Cooks distance.

- .fitted:

  Fitted or predicted value.

- .resid:

  The difference between observed and fitted values.

## Examples

``` r
library(mfx)
#> Loading required package: sandwich
#> Loading required package: lmtest
#> Loading required package: zoo
#> 
#> Attaching package: ‘zoo’
#> The following objects are masked from ‘package:base’:
#> 
#>     as.Date, as.Date.numeric
#> Loading required package: MASS
#> 
#> Attaching package: ‘MASS’
#> The following object is masked from ‘package:dplyr’:
#> 
#>     select
#> Loading required package: betareg

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
