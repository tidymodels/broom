# Augment data with information from a(n) fixest object

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
# S3 method for class 'fixest'
augment(
  x,
  data = NULL,
  newdata = NULL,
  type.predict = c("link", "response"),
  type.residuals = c("response", "deviance", "pearson", "working"),
  ...
)
```

## Arguments

- x:

  A `fixest` object returned from any of the `fixest` estimators

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
  [`predict.fixest`](https://lrberge.github.io/fixest/reference/predict.fixest.html)
  `type` argument. Defaults to `"link"` (like `predict.glm`).

- type.residuals:

  Passed to
  [`predict.fixest`](https://lrberge.github.io/fixest/reference/resid.fixest.html)
  `type` argument. Defaults to `"response"` (like `residuals.lm`, but
  unlike `residuals.glm`).

- ...:

  Additional arguments passed to `summary` and `confint`. Important
  arguments are `se` and `cluster`. Other arguments are `dof`,
  `exact_dof`, `forceCovariance`, and `keepBounded`. See
  [`summary.fixest`](https://lrberge.github.io/fixest/reference/summary.fixest.html).

## Note

Important note: `fixest` models do not include a copy of the input data,
so you must provide it manually.

augment.fixest only works for
[`fixest::feols()`](https://lrberge.github.io/fixest/reference/feols.html),
[`fixest::feglm()`](https://lrberge.github.io/fixest/reference/feglm.html),
and
[`fixest::femlm()`](https://lrberge.github.io/fixest/reference/femlm.html)
models. It does not work with results from
[`fixest::fenegbin()`](https://lrberge.github.io/fixest/reference/femlm.html),
[`fixest::feNmlm()`](https://lrberge.github.io/fixest/reference/feNmlm.html),
or
[`fixest::fepois()`](https://lrberge.github.io/fixest/reference/feglm.html).

## See also

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`fixest::feglm()`](https://lrberge.github.io/fixest/reference/feglm.html),
[`fixest::femlm()`](https://lrberge.github.io/fixest/reference/femlm.html),
[`fixest::feols()`](https://lrberge.github.io/fixest/reference/feols.html)

Other fixest tidiers:
[`tidy.fixest()`](https://broom.tidymodels.org/dev/reference/tidy.fixest.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .fitted:

  Fitted or predicted value.

- .resid:

  The difference between observed and fitted values.

## Examples

``` r
# load libraries for models and data
library(fixest)
#> 
#> Attaching package: ‘fixest’
#> The following object is masked from ‘package:lfe’:
#> 
#>     fepois

gravity <-
  feols(
    log(Euros) ~ log(dist_km) | Origin + Destination + Product + Year, trade
  )

tidy(gravity)
#> # A tibble: 1 × 5
#>   term         estimate std.error statistic p.value
#>   <chr>           <dbl>     <dbl>     <dbl>   <dbl>
#> 1 log(dist_km)    -2.17    0.0209     -104.       0
glance(gravity)
#> # A tibble: 1 × 9
#>   r.squared adj.r.squared within.r.squared pseudo.r.squared sigma  nobs
#>       <dbl>         <dbl>            <dbl>            <dbl> <dbl> <int>
#> 1     0.706         0.705            0.219               NA  1.74 38325
#> # ℹ 3 more variables: AIC <dbl>, BIC <dbl>, logLik <dbl>
augment(gravity, trade)
#> # A tibble: 38,325 × 9
#>    .rownames Destination Origin Product  Year dist_km    Euros .fitted
#>    <chr>     <fct>       <fct>    <int> <dbl>   <dbl>    <dbl>   <dbl>
#>  1 1         LU          BE           1  2007    140.  2966697    14.1
#>  2 2         BE          LU           1  2007    140.  6755030    13.0
#>  3 3         LU          BE           2  2007    140. 57078782    16.9
#>  4 4         BE          LU           2  2007    140.  7117406    15.8
#>  5 5         LU          BE           3  2007    140. 17379821    16.3
#>  6 6         BE          LU           3  2007    140.  2622254    15.2
#>  7 7         LU          BE           4  2007    140. 64867588    17.4
#>  8 8         BE          LU           4  2007    140. 10731757    16.3
#>  9 9         LU          BE           5  2007    140.   330702    14.1
#> 10 10        BE          LU           5  2007    140.     7706    13.0
#> # ℹ 38,315 more rows
#> # ℹ 1 more variable: .resid <dbl>

# to get robust or clustered SEs, users can either:

# 1) specify the arguments directly in the `tidy()` call

tidy(gravity, conf.int = TRUE, cluster = c("Product", "Year"))
#> # A tibble: 1 × 7
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 log(dist_km)    -2.17    0.0760     -28.5 3.88e-10    -2.34     -2.00

tidy(gravity, conf.int = TRUE, se = "threeway")
#> # A tibble: 1 × 7
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 log(dist_km)    -2.17     0.175     -12.4  6.08e-9    -2.54     -1.79

# 2) or, feed tidy() a summary.fixest object that has already accepted
# these arguments

gravity_summ <- summary(gravity, cluster = c("Product", "Year"))

tidy(gravity_summ, conf.int = TRUE)
#> # A tibble: 1 × 7
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 log(dist_km)    -2.17    0.0760     -28.5 3.88e-10    -2.34     -2.00

# approach (1) is preferred.
```
