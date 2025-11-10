# Augment data with information from a(n) lmRob object

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
# S3 method for class 'lmRob'
augment(x, data = model.frame(x), newdata = NULL, ...)
```

## Arguments

- x:

  A `lmRob` object returned from
  [`robust::lmRob()`](https://rdrr.io/pkg/robust/man/lmRob.html).

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

[`robust::lmRob()`](https://rdrr.io/pkg/robust/man/lmRob.html)

Other robust tidiers:
[`glance.glmRob()`](https://broom.tidymodels.org/dev/reference/glance.glmRob.md),
[`glance.lmRob()`](https://broom.tidymodels.org/dev/reference/glance.lmRob.md),
[`tidy.glmRob()`](https://broom.tidymodels.org/dev/reference/tidy.glmRob.md),
[`tidy.lmRob()`](https://broom.tidymodels.org/dev/reference/tidy.lmRob.md)

## Examples

``` r
# load modeling library
library(robust)
#> Loading required package: fit.models

# fit model
m <- lmRob(mpg ~ wt, data = mtcars)

# summarize model fit with tidiers
tidy(m)
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)    35.6       3.58      9.93 5.37e-11
#> 2 wt             -4.91      1.09     -4.49 9.67e- 5
augment(m)
#> # A tibble: 32 × 4
#>    .rownames           mpg    wt .fitted
#>    <chr>             <dbl> <dbl>   <dbl>
#>  1 Mazda RX4          21    2.62    22.7
#>  2 Mazda RX4 Wag      21    2.88    21.4
#>  3 Datsun 710         22.8  2.32    24.2
#>  4 Hornet 4 Drive     21.4  3.22    19.8
#>  5 Hornet Sportabout  18.7  3.44    18.7
#>  6 Valiant            18.1  3.46    18.6
#>  7 Duster 360         14.3  3.57    18.0
#>  8 Merc 240D          24.4  3.19    19.9
#>  9 Merc 230           22.8  3.15    20.1
#> 10 Merc 280           19.2  3.44    18.7
#> # ℹ 22 more rows
glance(m)
#> # A tibble: 1 × 5
#>   r.squared deviance sigma df.residual  nobs
#>       <dbl>    <dbl> <dbl>       <int> <int>
#> 1     0.567     136.  2.95          30    32
```
