# Augment data with information from a(n) mfx object

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
# S3 method for class 'mfx'
augment(
  x,
  data = model.frame(x$fit),
  newdata = NULL,
  type.predict = c("link", "response", "terms"),
  type.residuals = c("deviance", "pearson"),
  se_fit = FALSE,
  ...
)

# S3 method for class 'logitmfx'
augment(
  x,
  data = model.frame(x$fit),
  newdata = NULL,
  type.predict = c("link", "response", "terms"),
  type.residuals = c("deviance", "pearson"),
  se_fit = FALSE,
  ...
)

# S3 method for class 'negbinmfx'
augment(
  x,
  data = model.frame(x$fit),
  newdata = NULL,
  type.predict = c("link", "response", "terms"),
  type.residuals = c("deviance", "pearson"),
  se_fit = FALSE,
  ...
)

# S3 method for class 'poissonmfx'
augment(
  x,
  data = model.frame(x$fit),
  newdata = NULL,
  type.predict = c("link", "response", "terms"),
  type.residuals = c("deviance", "pearson"),
  se_fit = FALSE,
  ...
)

# S3 method for class 'probitmfx'
augment(
  x,
  data = model.frame(x$fit),
  newdata = NULL,
  type.predict = c("link", "response", "terms"),
  type.residuals = c("deviance", "pearson"),
  se_fit = FALSE,
  ...
)
```

## Arguments

- x:

  A `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx` object. (Note
  that `betamfx` objects receive their own set of tidiers.)

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

  Passed to
  [`stats::predict.glm()`](https://rdrr.io/r/stats/predict.glm.html)
  `type` argument. Defaults to `"link"`.

- type.residuals:

  Passed to
  [`stats::residuals.glm()`](https://rdrr.io/r/stats/glm.summaries.html)
  and to
  [`stats::rstandard.glm()`](https://rdrr.io/r/stats/influence.measures.html)
  `type` arguments. Defaults to `"deviance"`.

- se_fit:

  Logical indicating whether or not a `.se.fit` column should be added
  to the augmented output. For some models, this calculation can be
  somewhat time-consuming. Defaults to `FALSE`.

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

This generic augment method wraps
[`augment.glm()`](https://broom.tidymodels.org/dev/reference/augment.glm.md)
for applicable objects from the `mfx` package.

## See also

[`augment.glm()`](https://broom.tidymodels.org/dev/reference/augment.glm.md),
[`mfx::logitmfx()`](https://rdrr.io/pkg/mfx/man/logitmfx.html),
[`mfx::negbinmfx()`](https://rdrr.io/pkg/mfx/man/negbinmfx.html),
[`mfx::poissonmfx()`](https://rdrr.io/pkg/mfx/man/poissonmfx.html),
[`mfx::probitmfx()`](https://rdrr.io/pkg/mfx/man/probitmfx.html)

Other mfx tidiers:
[`augment.betamfx()`](https://broom.tidymodels.org/dev/reference/augment.betamfx.md),
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

- .hat:

  Diagonal of the hat matrix.

- .resid:

  The difference between observed and fitted values.

- .se.fit:

  Standard errors of fitted values.

- .sigma:

  Estimated residual standard deviation when corresponding observation
  is dropped from model.

- .std.resid:

  Standardised residuals.

## Examples

``` r
# load libraries for models and data
library(mfx)

# get the marginal effects from a logit regression
mod_logmfx <- logitmfx(am ~ cyl + hp + wt, atmean = TRUE, data = mtcars)

tidy(mod_logmfx, conf.int = TRUE)
#> # A tibble: 3 × 8
#>   term  atmean estimate std.error statistic p.value conf.low conf.high
#>   <chr> <lgl>     <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 cyl   TRUE    0.0538    0.113       0.475   0.635 -0.178     0.286  
#> 2 hp    TRUE    0.00359   0.00290     1.24    0.216 -0.00236   0.00954
#> 3 wt    TRUE   -1.01      0.668      -1.51    0.131 -2.38      0.359  

# compare with the naive model coefficients of the same logit call
tidy(
  glm(am ~ cyl + hp + wt, family = binomial, data = mtcars),
  conf.int = TRUE
)
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> # A tibble: 4 × 7
#>   term        estimate std.error statistic p.value  conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>     <dbl>     <dbl>
#> 1 (Intercept)  19.7       8.12       2.43   0.0152   8.56      44.3   
#> 2 cyl           0.488     1.07       0.455  0.649   -1.53       3.12  
#> 3 hp            0.0326    0.0189     1.73   0.0840   0.00332    0.0884
#> 4 wt           -9.15      4.15      -2.20   0.0276 -21.4       -3.48  

augment(mod_logmfx)
#> # A tibble: 32 × 11
#>    .rownames         am   cyl    hp    wt .fitted  .resid   .hat .sigma
#>    <chr>          <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 Mazda RX4          1     6   110  2.62  2.24    0.449  0.278   0.595
#>  2 Mazda RX4 Wag      1     6   110  2.88 -0.0912  1.22   0.352   0.529
#>  3 Datsun 710         1     4    93  2.32  3.46    0.249  0.0960  0.602
#>  4 Hornet 4 Drive     0     6   110  3.22 -3.20   -0.282  0.0945  0.601
#>  5 Hornet Sporta…     0     8   175  3.44 -2.17   -0.466  0.220   0.595
#>  6 Valiant            0     6   105  3.46 -5.61   -0.0856 0.0221  0.604
#>  7 Duster 360         0     8   245  3.57 -1.07   -0.766  0.337   0.576
#>  8 Merc 240D          0     4    62  3.19 -5.51   -0.0897 0.0376  0.603
#>  9 Merc 230           0     4    95  3.15 -4.07   -0.184  0.122   0.603
#> 10 Merc 280           0     6   123  3.44 -4.84   -0.126  0.0375  0.603
#> # ℹ 22 more rows
#> # ℹ 2 more variables: .cooksd <dbl>, .std.resid <dbl>
glance(mod_logmfx)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          43.2      31  -4.92  17.8  23.7     9.84          28    32

# another example, this time using probit regression
mod_probmfx <- probitmfx(am ~ cyl + hp + wt, atmean = TRUE, data = mtcars)
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred

tidy(mod_probmfx, conf.int = TRUE)
#> # A tibble: 3 × 8
#>   term  atmean estimate std.error statistic p.value conf.low conf.high
#>   <chr> <lgl>     <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 cyl   TRUE    0.0616    0.112       0.548  0.583  -0.169     0.292  
#> 2 hp    TRUE    0.00383   0.00282     1.36   0.174  -0.00194   0.00960
#> 3 wt    TRUE   -1.06      0.594      -1.78   0.0753 -2.27      0.160  
augment(mod_probmfx)
#> # A tibble: 32 × 11
#>    .rownames         am   cyl    hp    wt .fitted  .resid   .hat .sigma
#>    <chr>          <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 Mazda RX4          1     6   110  2.62   1.21   0.490  0.308   0.585
#>  2 Mazda RX4 Wag      1     6   110  2.88  -0.129  1.27   0.249   0.526
#>  3 Datsun 710         1     4    93  2.32   1.85   0.256  0.134   0.594
#>  4 Hornet 4 Drive     0     6   110  3.22  -1.92  -0.237  0.116   0.594
#>  5 Hornet Sporta…     0     8   175  3.44  -1.25  -0.474  0.236   0.587
#>  6 Valiant            0     6   105  3.46  -3.30  -0.0312 0.0111  0.596
#>  7 Duster 360         0     8   245  3.57  -0.595 -0.804  0.285   0.567
#>  8 Merc 240D          0     4    62  3.19  -3.31  -0.0304 0.0179  0.596
#>  9 Merc 230           0     4    95  3.15  -2.47  -0.116  0.130   0.596
#> 10 Merc 280           0     6   123  3.44  -2.85  -0.0662 0.0315  0.596
#> # ℹ 22 more rows
#> # ℹ 2 more variables: .cooksd <dbl>, .std.resid <dbl>
glance(mod_probmfx)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          43.2      31  -4.80  17.6  23.5     9.59          28    32
```
