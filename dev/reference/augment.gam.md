# Augment data with information from a(n) gam object

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
# S3 method for class 'gam'
augment(
  x,
  data = model.frame(x),
  newdata = NULL,
  type.predict,
  type.residuals,
  ...
)
```

## Arguments

- x:

  A `gam` object returned from a call to
  [`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html).

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
  argument of the
  [`stats::predict()`](https://rdrr.io/r/stats/predict.html) generic.
  Allowed arguments vary with model class, so be sure to read the
  `predict.my_class` documentation.

- type.residuals:

  Character indicating type of residuals to use. Passed to the `type`
  argument of
  [`stats::residuals()`](https://rdrr.io/r/stats/residuals.html)
  generic. Allowed arguments vary with model class, so be sure to read
  the `residuals.my_class` documentation.

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

For additional details on Cook's distance, see
[`stats::cooks.distance()`](https://rdrr.io/r/stats/influence.measures.html).

## See also

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html)

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

## Examples

``` r
# load libraries for models and data
library(mgcv)
#> Loading required package: nlme
#> 
#> Attaching package: ‘nlme’
#> The following object is masked from ‘package:dplyr’:
#> 
#>     collapse
#> This is mgcv 1.9-3. For overview type 'help("mgcv-package")'.
#> 
#> Attaching package: ‘mgcv’
#> The following object is masked from ‘package:mclust’:
#> 
#>     mvn

# fit model
g <- gam(mpg ~ s(hp) + am + qsec, data = mtcars)

# summarize model fit with tidiers
tidy(g)
#> # A tibble: 1 × 5
#>   term    edf ref.df statistic p.value
#>   <chr> <dbl>  <dbl>     <dbl>   <dbl>
#> 1 s(hp)  2.36   3.02      6.34 0.00218
tidy(g, parametric = TRUE)
#> # A tibble: 3 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)  16.7        9.83      1.70  0.101  
#> 2 am            4.37       1.56      2.81  0.00918
#> 3 qsec          0.0904     0.525     0.172 0.865  
glance(g)
#> # A tibble: 1 × 9
#>      df logLik   AIC   BIC deviance df.residual  nobs adj.r.squared
#>   <dbl>  <dbl> <dbl> <dbl>    <dbl>       <dbl> <int>         <dbl>
#> 1  5.36  -74.4  162.  171.     196.        26.6    32         0.797
#> # ℹ 1 more variable: npar <int>
augment(g)
#> # A tibble: 32 × 11
#>    .rownames        mpg    am  qsec    hp .fitted .se.fit .resid   .hat
#>    <chr>          <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 Mazda RX4       21       1  16.5   110    24.3   1.03  -3.25  0.145 
#>  2 Mazda RX4 Wag   21       1  17.0   110    24.3   0.925 -3.30  0.116 
#>  3 Datsun 710      22.8     1  18.6    93    26.0   0.894 -3.22  0.109 
#>  4 Hornet 4 Drive  21.4     0  19.4   110    20.2   0.827  1.25  0.0930
#>  5 Hornet Sporta…  18.7     0  17.0   175    15.7   0.815  3.02  0.0902
#>  6 Valiant         18.1     0  20.2   105    20.7   0.914 -2.56  0.113 
#>  7 Duster 360      14.3     0  15.8   245    12.7   1.11   1.63  0.167 
#>  8 Merc 240D       24.4     0  20      62    25.0   1.45  -0.618 0.287 
#>  9 Merc 230        22.8     0  22.9    95    21.8   1.81   0.959 0.446 
#> 10 Merc 280        19.2     0  18.3   123    19.0   0.864  0.211 0.102 
#> # ℹ 22 more rows
#> # ℹ 2 more variables: .sigma <lgl>, .cooksd <dbl>
```
