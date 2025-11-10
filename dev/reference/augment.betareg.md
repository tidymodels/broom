# Augment data with information from a(n) betareg object

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
# S3 method for class 'betareg'
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

  A `betareg` object produced by a call to
  [`betareg::betareg()`](https://rdrr.io/pkg/betareg/man/betareg.html).

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
[`betareg::betareg()`](https://rdrr.io/pkg/betareg/man/betareg.html)

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
# load libraries for models and data
library(betareg)

# load dats
data("GasolineYield", package = "betareg")

# fit model
mod <- betareg(yield ~ batch + temp, data = GasolineYield)

mod
#> 
#> Call:
#> betareg(formula = yield ~ batch + temp, data = GasolineYield)
#> 
#> Coefficients (mean model with logit link):
#> (Intercept)       batch1       batch2       batch3       batch4  
#>    -6.15957      1.72773      1.32260      1.57231      1.05971  
#>      batch5       batch6       batch7       batch8       batch9  
#>     1.13375      1.04016      0.54369      0.49590      0.38579  
#>        temp  
#>     0.01097  
#> 
#> Phi coefficients (precision model with identity link):
#> (phi)  
#> 440.3  
#> 

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 12 × 6
#>    component term        estimate  std.error statistic   p.value
#>    <chr>     <chr>          <dbl>      <dbl>     <dbl>     <dbl>
#>  1 mean      (Intercept)  -6.16     0.182       -33.8  3.44e-250
#>  2 mean      batch1        1.73     0.101        17.1  2.59e- 65
#>  3 mean      batch2        1.32     0.118        11.2  3.34e- 29
#>  4 mean      batch3        1.57     0.116        13.5  8.81e- 42
#>  5 mean      batch4        1.06     0.102        10.4  4.06e- 25
#>  6 mean      batch5        1.13     0.104        11.0  6.52e- 28
#>  7 mean      batch6        1.04     0.106         9.81 1.03e- 22
#>  8 mean      batch7        0.544    0.109         4.98 6.29e-  7
#>  9 mean      batch8        0.496    0.109         4.55 5.30e-  6
#> 10 mean      batch9        0.386    0.119         3.25 1.14e-  3
#> 11 mean      temp          0.0110   0.000413     26.6  1.26e-155
#> 12 precision (phi)       440.     110.            4.00 6.29e-  5
tidy(mod, conf.int = TRUE)
#> # A tibble: 12 × 8
#>    component term       estimate std.error statistic   p.value conf.low
#>    <chr>     <chr>         <dbl>     <dbl>     <dbl>     <dbl>    <dbl>
#>  1 mean      (Intercep…  -6.16     1.82e-1    -33.8  3.44e-250  -6.52  
#>  2 mean      batch1       1.73     1.01e-1     17.1  2.59e- 65   1.53  
#>  3 mean      batch2       1.32     1.18e-1     11.2  3.34e- 29   1.09  
#>  4 mean      batch3       1.57     1.16e-1     13.5  8.81e- 42   1.34  
#>  5 mean      batch4       1.06     1.02e-1     10.4  4.06e- 25   0.859 
#>  6 mean      batch5       1.13     1.04e-1     11.0  6.52e- 28   0.931 
#>  7 mean      batch6       1.04     1.06e-1      9.81 1.03e- 22   0.832 
#>  8 mean      batch7       0.544    1.09e-1      4.98 6.29e-  7   0.330 
#>  9 mean      batch8       0.496    1.09e-1      4.55 5.30e-  6   0.282 
#> 10 mean      batch9       0.386    1.19e-1      3.25 1.14e-  3   0.153 
#> 11 mean      temp         0.0110   4.13e-4     26.6  1.26e-155   0.0102
#> 12 precision (phi)      440.       1.10e+2      4.00 6.29e-  5 225.    
#> # ℹ 1 more variable: conf.high <dbl>
tidy(mod, conf.int = TRUE, conf.level = .99)
#> # A tibble: 12 × 8
#>    component term       estimate std.error statistic   p.value conf.low
#>    <chr>     <chr>         <dbl>     <dbl>     <dbl>     <dbl>    <dbl>
#>  1 mean      (Intercep…  -6.16     1.82e-1    -33.8  3.44e-250 -6.63e+0
#>  2 mean      batch1       1.73     1.01e-1     17.1  2.59e- 65  1.47e+0
#>  3 mean      batch2       1.32     1.18e-1     11.2  3.34e- 29  1.02e+0
#>  4 mean      batch3       1.57     1.16e-1     13.5  8.81e- 42  1.27e+0
#>  5 mean      batch4       1.06     1.02e-1     10.4  4.06e- 25  7.96e-1
#>  6 mean      batch5       1.13     1.04e-1     11.0  6.52e- 28  8.67e-1
#>  7 mean      batch6       1.04     1.06e-1      9.81 1.03e- 22  7.67e-1
#>  8 mean      batch7       0.544    1.09e-1      4.98 6.29e-  7  2.63e-1
#>  9 mean      batch8       0.496    1.09e-1      4.55 5.30e-  6  2.15e-1
#> 10 mean      batch9       0.386    1.19e-1      3.25 1.14e-  3  8.03e-2
#> 11 mean      temp         0.0110   4.13e-4     26.6  1.26e-155  9.90e-3
#> 12 precision (phi)      440.       1.10e+2      4.00 6.29e-  5  1.57e+2
#> # ℹ 1 more variable: conf.high <dbl>

augment(mod)
#> # A tibble: 32 × 6
#>    yield batch  temp .fitted  .resid   .cooksd
#>    <dbl> <fct> <dbl>   <dbl>   <dbl>     <dbl>
#>  1 0.122 1       205  0.101   1.41   0.0791   
#>  2 0.223 1       275  0.195   1.44   0.0917   
#>  3 0.347 1       345  0.343   0.170  0.00155  
#>  4 0.457 1       407  0.508  -2.14   0.606    
#>  5 0.08  2       218  0.0797  0.0712 0.0000168
#>  6 0.131 2       273  0.137  -0.318  0.00731  
#>  7 0.266 2       347  0.263   0.169  0.00523  
#>  8 0.074 3       212  0.0943 -1.52   0.0805   
#>  9 0.182 3       272  0.167   0.831  0.0441   
#> 10 0.304 3       340  0.298   0.304  0.0170   
#> # ℹ 22 more rows

glance(mod)
#> # A tibble: 1 × 7
#>   pseudo.r.squared df.null logLik   AIC   BIC df.residual  nobs
#>              <dbl>   <dbl>  <dbl> <dbl> <dbl>       <int> <int>
#> 1            0.962      30   84.8 -146. -128.          20    32
```
