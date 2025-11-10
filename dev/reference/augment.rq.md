# Augment data with information from a(n) rq object

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
# S3 method for class 'rq'
augment(x, data = model.frame(x), newdata = NULL, ...)
```

## Arguments

- x:

  An `rq` object returned from
  [`quantreg::rq()`](https://rdrr.io/pkg/quantreg/man/rq.html).

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

  Arguments passed on to
  [`quantreg::predict.rq`](https://rdrr.io/pkg/quantreg/man/predict.rq.html)

  `object`

  :   object of class rq or rqs or rq.process produced by `rq`

  `interval`

  :   type of interval desired: default is 'none', when set to
      'confidence' the function returns a matrix predictions with point
      predictions for each of the 'newdata' points as well as lower and
      upper confidence limits.

  `level`

  :   converage probability for the 'confidence' intervals.

  `type`

  :   For `predict.rq`, the method for 'confidence' intervals, if
      desired. If 'percentile' then one of the bootstrap methods is used
      to generate percentile intervals for each prediction, if 'direct'
      then a version of the Portnoy and Zhou (1998) method is used, and
      otherwise an estimated covariance matrix for the parameter
      estimates is used. Further arguments to determine the choice of
      bootstrap method or covariance matrix estimate can be passed via
      the ... argument. For `predict.rqs` and `predict.rq.process` when
      `stepfun = TRUE`, `type` is "Qhat", "Fhat" or "fhat" depending on
      whether the user would like to have estimates of the conditional
      quantile, distribution or density functions respectively. As noted
      below the two former estimates can be monotonized with the
      function `rearrange`. When the "fhat" option is invoked, a list of
      conditional density functions is returned based on Silverman's
      adaptive kernel method as implemented in `akj` and `approxfun`.

  `na.action`

  :   function determining what should be done with missing values in
      'newdata'. The default is to predict 'NA'.

## Details

Depending on the arguments passed on to `predict.rq` via `...`, a
confidence interval is also calculated on the fitted values resulting in
columns `.lower` and `.upper`. Does not provide confidence intervals
when data is specified via the `newdata` argument.

## See also

[augment](https://generics.r-lib.org/reference/augment.html),
[`quantreg::rq()`](https://rdrr.io/pkg/quantreg/man/rq.html),
[`quantreg::predict.rq()`](https://rdrr.io/pkg/quantreg/man/predict.rq.html)

Other quantreg tidiers:
[`augment.nlrq()`](https://broom.tidymodels.org/dev/reference/augment.nlrq.md),
[`augment.rqs()`](https://broom.tidymodels.org/dev/reference/augment.rqs.md),
[`glance.nlrq()`](https://broom.tidymodels.org/dev/reference/glance.nlrq.md),
[`glance.rq()`](https://broom.tidymodels.org/dev/reference/glance.rq.md),
[`tidy.nlrq()`](https://broom.tidymodels.org/dev/reference/tidy.nlrq.md),
[`tidy.rq()`](https://broom.tidymodels.org/dev/reference/tidy.rq.md),
[`tidy.rqs()`](https://broom.tidymodels.org/dev/reference/tidy.rqs.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .fitted:

  Fitted or predicted value.

- .resid:

  The difference between observed and fitted values.

- .tau:

  Quantile.

## Examples

``` r
# load modeling library and data
library(quantreg)
#> Loading required package: SparseM
#> 
#> Attaching package: ‘SparseM’
#> The following object is masked from ‘package:Matrix’:
#> 
#>     det
#> 
#> Attaching package: ‘quantreg’
#> The following object is masked from ‘package:survival’:
#> 
#>     untangle.specials

data(stackloss)

# median (l1) regression fit for the stackloss data.
mod1 <- rq(stack.loss ~ stack.x, .5)

# weighted sample median
mod2 <- rq(rnorm(50) ~ 1, weights = runif(50))

# summarize model fit with tidiers
tidy(mod1)
#> # A tibble: 4 × 5
#>   term              estimate conf.low conf.high   tau
#>   <chr>                <dbl>    <dbl>     <dbl> <dbl>
#> 1 (Intercept)       -39.7     -53.8    -24.5      0.5
#> 2 stack.xAir.Flow     0.832     0.509    1.17     0.5
#> 3 stack.xWater.Temp   0.574     0.272    3.04     0.5
#> 4 stack.xAcid.Conc.  -0.0609   -0.278    0.0153   0.5
glance(mod1)
#> # A tibble: 1 × 5
#>     tau logLik      AIC   BIC df.residual
#>   <dbl> <logLik>  <dbl> <dbl>       <int>
#> 1   0.5 -50.15272  108.  112.          17
augment(mod1)
#> # A tibble: 21 × 5
#>    stack.loss stack.x[,"Air.Flow"]    .resid .fitted  .tau
#>         <dbl>                <dbl>     <dbl>   <dbl> <dbl>
#>  1         42                   80  5.06e+ 0    36.9   0.5
#>  2         37                   80 -1.42e-14    37     0.5
#>  3         37                   75  5.43e+ 0    31.6   0.5
#>  4         28                   62  7.63e+ 0    20.4   0.5
#>  5         18                   62 -1.22e+ 0    19.2   0.5
#>  6         18                   62 -1.79e+ 0    19.8   0.5
#>  7         19                   62 -1.00e+ 0    20     0.5
#>  8         20                   62 -7.11e-15    20     0.5
#>  9         15                   58 -1.46e+ 0    16.5   0.5
#> 10         14                   58 -2.03e- 2    14.0   0.5
#> # ℹ 11 more rows
#> # ℹ 1 more variable: stack.x[2:3] <dbl>

tidy(mod2)
#> # A tibble: 1 × 5
#>   term        estimate conf.low conf.high   tau
#>   <chr>          <dbl> <lgl>    <lgl>     <dbl>
#> 1 (Intercept)   -0.170 NA       NA          0.5
glance(mod2)
#> # A tibble: 1 × 5
#>     tau logLik      AIC   BIC df.residual
#>   <dbl> <logLik>  <dbl> <dbl>       <int>
#> 1   0.5 -79.69325  161.  163.          49
augment(mod2)
#> # A tibble: 50 × 5
#>    `rnorm(50)` `(weights)` .resid .fitted  .tau
#>          <dbl>       <dbl>  <dbl>   <dbl> <dbl>
#>  1     0.458       0.660    0.628  -0.170   0.5
#>  2    -1.22        0.212   -1.05   -0.170   0.5
#>  3    -1.12        0.00527 -0.952  -0.170   0.5
#>  4     0.993       0.103    1.16   -0.170   0.5
#>  5    -1.83        0.287   -1.66   -0.170   0.5
#>  6     0.124       0.444    0.294  -0.170   0.5
#>  7     0.591       0.693    0.761  -0.170   0.5
#>  8     0.805       0.0209   0.975  -0.170   0.5
#>  9     0.00754     0.956    0.178  -0.170   0.5
#> 10    -1.82        0.804   -1.65   -0.170   0.5
#> # ℹ 40 more rows

# varying tau to generate an rqs object
mod3 <- rq(stack.loss ~ stack.x, tau = c(.25, .5))

tidy(mod3)
#> # A tibble: 8 × 5
#>   term                estimate conf.low conf.high   tau
#>   <chr>                  <dbl>    <dbl>     <dbl> <dbl>
#> 1 (Intercept)       -3.6  e+ 1  -59.0     -7.84    0.25
#> 2 stack.xAir.Flow    5.00 e- 1    0.229    0.970   0.25
#> 3 stack.xWater.Temp  1.000e+ 0    0.286    2.26    0.25
#> 4 stack.xAcid.Conc. -4.58 e-16   -0.643    0.0861  0.25
#> 5 (Intercept)       -3.97 e+ 1  -53.8    -24.5     0.5 
#> 6 stack.xAir.Flow    8.32 e- 1    0.509    1.17    0.5 
#> 7 stack.xWater.Temp  5.74 e- 1    0.272    3.04    0.5 
#> 8 stack.xAcid.Conc. -6.09 e- 2   -0.278    0.0153  0.5 
augment(mod3)
#> # A tibble: 42 × 5
#>    stack.loss stack.x[,"Air.Flow"] .tau      .resid .fitted
#>         <dbl>                <dbl> <chr>      <dbl>   <dbl>
#>  1         42                   80 0.25   1.10 e+ 1    31.0
#>  2         42                   80 0.5    5.06 e+ 0    36.9
#>  3         37                   80 0.25   6.00 e+ 0    31.0
#>  4         37                   80 0.5   -1.42 e-14    37  
#>  5         37                   75 0.25   1.05 e+ 1    26.5
#>  6         37                   75 0.5    5.43 e+ 0    31.6
#>  7         28                   62 0.25   9.00 e+ 0    19  
#>  8         28                   62 0.5    7.63 e+ 0    20.4
#>  9         18                   62 0.25   1.000e+ 0    17.0
#> 10         18                   62 0.5   -1.22 e+ 0    19.2
#> # ℹ 32 more rows
#> # ℹ 1 more variable: stack.x[2:3] <dbl>

# glance cannot handle rqs objects like `mod3`--use a purrr
# `map`-based workflow instead
```
