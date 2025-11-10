# Augment data with information from a(n) mlogit object

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
# S3 method for class 'mlogit'
augment(x, data = x$model, ...)
```

## Arguments

- x:

  an object returned from
  [`mlogit::mlogit()`](https://rdrr.io/pkg/mlogit/man/mlogit.html).

- data:

  Not currently used

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

At the moment this only works on the estimation dataset. Need to set it
up to predict on another dataset.

## See also

[`augment()`](https://generics.r-lib.org/reference/augment.html)

Other mlogit tidiers:
[`glance.mlogit()`](https://broom.tidymodels.org/dev/reference/glance.mlogit.md),
[`tidy.mlogit()`](https://broom.tidymodels.org/dev/reference/tidy.mlogit.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .fitted:

  Fitted or predicted value.

- .probability:

  Class probability of modal class.

- .resid:

  The difference between observed and fitted values.

## Examples

``` r
# load libraries for models and data
library(mlogit)
#> Loading required package: dfidx
#> 
#> Attaching package: ‘mlogit’
#> The following object is masked from ‘package:lfe’:
#> 
#>     waldtest

data("Fishing", package = "mlogit")
Fish <- dfidx(Fishing, varying = 2:9, shape = "wide", choice = "mode")

# fit model
m <- mlogit(mode ~ price + catch | income, data = Fish)

# summarize model fit with tidiers
tidy(m)
#> # A tibble: 8 × 5
#>   term                  estimate std.error statistic  p.value
#>   <chr>                    <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept):boat     0.527     0.223         2.37  1.79e- 2
#> 2 (Intercept):charter  1.69      0.224         7.56  3.95e-14
#> 3 (Intercept):pier     0.778     0.220         3.53  4.18e- 4
#> 4 price               -0.0251    0.00173     -14.5   0       
#> 5 catch                0.358     0.110         3.26  1.12e- 3
#> 6 income:boat          0.0000894 0.0000501     1.79  7.40e- 2
#> 7 income:charter      -0.0000333 0.0000503    -0.661 5.08e- 1
#> 8 income:pier         -0.000128  0.0000506    -2.52  1.18e- 2
augment(m)
#> # A tibble: 4,728 × 9
#>       id alternative chosen price  catch income .probability .fitted
#>    <int> <fct>       <lgl>  <dbl>  <dbl>  <dbl>        <dbl>   <dbl>
#>  1     1 beach       FALSE  158.  0.0678  7083.      0.125    -3.94 
#>  2     1 boat        FALSE  158.  0.260   7083.      0.427    -2.71 
#>  3     1 charter     TRUE   183.  0.539   7083.      0.339    -2.94 
#>  4     1 pier        FALSE  158.  0.0503  7083.      0.109    -4.07 
#>  5     2 beach       FALSE   15.1 0.105   1250.      0.116    -0.342
#>  6     2 boat        FALSE   10.5 0.157   1250.      0.251     0.431
#>  7     2 charter     TRUE    34.5 0.467   1250.      0.423     0.952
#>  8     2 pier        FALSE   15.1 0.0451  1250.      0.210     0.255
#>  9     3 beach       FALSE  162.  0.533   3750.      0.00689  -3.87 
#> 10     3 boat        TRUE    24.3 0.241   3750.      0.465     0.338
#> # ℹ 4,718 more rows
#> # ℹ 1 more variable: .resid <dbl>
glance(m)
#> # A tibble: 1 × 6
#>   logLik  rho2 rho20   AIC   BIC  nobs
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <int>
#> 1 -1215. 0.189 0.258 2446.    NA  1182
```
