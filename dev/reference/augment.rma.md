# Augment data with information from a(n) rma object

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
# S3 method for class 'rma'
augment(x, interval = c("prediction", "confidence"), ...)
```

## Arguments

- x:

  An `rma` object such as those created by
  [`metafor::rma()`](https://wviechtb.github.io/metafor/reference/rma.uni.html),
  [`metafor::rma.uni()`](https://wviechtb.github.io/metafor/reference/rma.uni.html),
  [`metafor::rma.glmm()`](https://wviechtb.github.io/metafor/reference/rma.glmm.html),
  [`metafor::rma.mh()`](https://wviechtb.github.io/metafor/reference/rma.mh.html),
  [`metafor::rma.mv()`](https://wviechtb.github.io/metafor/reference/rma.mv.html),
  or
  [`metafor::rma.peto()`](https://wviechtb.github.io/metafor/reference/rma.peto.html).

- interval:

  For `rma.mv` models, should prediction intervals (`"prediction"`,
  default) or confidence intervals (`"confidence"`) intervals be
  returned? For `rma.uni` models, prediction intervals are always
  returned. For `rma.mh` and `rma.peto` models, confidence intervals are
  always returned.

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

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .fitted:

  Fitted or predicted value.

- .lower:

  Lower bound on interval for fitted values.

- .moderator:

  In meta-analysis, the moderators used to calculate the predicted
  values.

- .moderator.level:

  In meta-analysis, the level of the moderators used to calculate the
  predicted values.

- .resid:

  The difference between observed and fitted values.

- .se.fit:

  Standard errors of fitted values.

- .upper:

  Upper bound on interval for fitted values.

- .observed:

  The observed values for the individual studies

## Examples

``` r
# load modeling library
library(metafor)
#> Loading required package: metadat
#> Loading required package: numDeriv
#> 
#> Loading the 'metafor' package (version 4.8-0). For an
#> introduction to the package please type: help(metafor)
#> 
#> Attaching package: ‘metafor’
#> The following object is masked from ‘package:car’:
#> 
#>     vif
#> The following object is masked from ‘package:fixest’:
#> 
#>     se
#> The following object is masked from ‘package:mclust’:
#> 
#>     hc

# generate data and fit
df <-
  escalc(
    measure = "RR",
    ai = tpos,
    bi = tneg,
    ci = cpos,
    di = cneg,
    data = dat.bcg
  )

meta_analysis <- rma(yi, vi, data = df, method = "EB")

# summarize model fit with tidiers
augment(meta_analysis)
#> # A tibble: 13 × 6
#>    .observed  .fitted .se.fit .lower   .upper  .resid
#>        <dbl>    <dbl>   <dbl>  <dbl>    <dbl>   <dbl>
#>  1   -0.889  -0.801    0.411  -1.61   0.00524 -0.174 
#>  2   -1.59   -1.26     0.354  -1.95  -0.561   -0.870 
#>  3   -1.35   -0.990    0.437  -1.85  -0.134   -0.633 
#>  4   -1.44   -1.40     0.138  -1.67  -1.13    -0.727 
#>  5   -0.218  -0.287    0.212  -0.701  0.128    0.497 
#>  6   -0.786  -0.785    0.0823 -0.946 -0.623   -0.0711
#>  7   -1.62   -1.25     0.370  -1.97  -0.523   -0.906 
#>  8    0.0120  0.00301  0.0626 -0.120  0.126    0.727 
#>  9   -0.469  -0.506    0.221  -0.939 -0.0740   0.246 
#> 10   -1.37   -1.25     0.246  -1.73  -0.767   -0.656 
#> 11   -0.339  -0.353    0.110  -0.568 -0.139    0.376 
#> 12    0.446  -0.281    0.460  -1.18   0.621    1.16  
#> 13   -0.0173 -0.145    0.244  -0.623  0.333    0.698 
```
