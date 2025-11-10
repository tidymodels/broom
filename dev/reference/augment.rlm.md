# Augment data with information from a(n) rlm object

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
# S3 method for class 'rlm'
augment(x, data = model.frame(x), newdata = NULL, se_fit = FALSE, ...)
```

## Arguments

- x:

  An `rlm` object returned by
  [`MASS::rlm()`](https://rdrr.io/pkg/MASS/man/rlm.html).

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

## See also

[`MASS::rlm()`](https://rdrr.io/pkg/MASS/man/rlm.html)

Other rlm tidiers:
[`glance.rlm()`](https://broom.tidymodels.org/dev/reference/glance.rlm.md),
[`tidy.rlm()`](https://broom.tidymodels.org/dev/reference/tidy.rlm.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

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

## Examples

``` r
# load libraries for models and data
library(MASS)

# fit model
r <- rlm(stack.loss ~ ., stackloss)

# summarize model fit with tidiers
tidy(r)
#> # A tibble: 4 × 4
#>   term        estimate std.error statistic
#>   <chr>          <dbl>     <dbl>     <dbl>
#> 1 (Intercept)  -41.0       9.81     -4.18 
#> 2 Air.Flow       0.829     0.111     7.46 
#> 3 Water.Temp     0.926     0.303     3.05 
#> 4 Acid.Conc.    -0.128     0.129    -0.992
augment(r)
#> # A tibble: 21 × 10
#>    stack.loss Air.Flow Water.Temp Acid.Conc. .fitted .resid   .hat
#>         <dbl>    <dbl>      <dbl>      <dbl>   <dbl>  <dbl>  <dbl>
#>  1         42       80         27         89    38.9  3.05  0.327 
#>  2         37       80         27         88    39.1 -2.08  0.343 
#>  3         37       75         25         90    32.8  4.18  0.155 
#>  4         28       62         24         87    21.5  6.50  0.0713
#>  5         18       62         22         87    19.6 -1.65  0.0562
#>  6         18       62         23         87    20.6 -2.57  0.0835
#>  7         19       62         24         93    20.7 -1.73  0.230 
#>  8         20       62         24         93    20.7 -0.731 0.230 
#>  9         15       58         23         87    17.3 -2.25  0.155 
#> 10         14       58         18         80    13.5  0.481 0.213 
#> # ℹ 11 more rows
#> # ℹ 3 more variables: .sigma <dbl>, .cooksd <dbl>, .std.resid <dbl>
glance(r)
#> # A tibble: 1 × 7
#>   sigma converged logLik     AIC   BIC deviance  nobs
#>   <dbl> <lgl>     <logLik> <dbl> <dbl>    <dbl> <int>
#> 1  2.44 TRUE      -52.954   116.  121.     191.    21
```
