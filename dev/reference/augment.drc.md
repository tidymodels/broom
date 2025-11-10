# Augment data with information from a(n) drc object

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
# S3 method for class 'drc'
augment(
  x,
  data = NULL,
  newdata = NULL,
  se_fit = FALSE,
  conf.int = FALSE,
  conf.level = 0.95,
  ...
)
```

## Arguments

- x:

  A `drc` object produced by a call to
  [`drc::drm()`](https://rdrr.io/pkg/drc/man/drm.html).

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

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

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

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`drc::drm()`](https://rdrr.io/pkg/drc/man/drm.html)

Other drc tidiers:
[`glance.drc()`](https://broom.tidymodels.org/dev/reference/glance.drc.md),
[`tidy.drc()`](https://broom.tidymodels.org/dev/reference/tidy.drc.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .cooksd:

  Cooks distance.

- .fitted:

  Fitted or predicted value.

- .lower:

  Lower bound on interval for fitted values.

- .resid:

  The difference between observed and fitted values.

- .se.fit:

  Standard errors of fitted values.

- .upper:

  Upper bound on interval for fitted values.

## Examples

``` r
# load libraries for models and data
library(drc)
#> 
#> 'drc' has been loaded.
#> Please cite R and 'drc' if used for a publication,
#> for references type 'citation()' and 'citation('drc')'.
#> 
#> Attaching package: ‘drc’
#> The following objects are masked from ‘package:stats’:
#> 
#>     gaussian, getInitial

# fit model
mod <- drm(dead / total ~ conc, type,
  weights = total, data = selenium, fct = LL.2(), type = "binomial"
)

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 8 × 6
#>   term  curve estimate std.error statistic  p.value
#>   <chr> <chr>    <dbl>     <dbl>     <dbl>    <dbl>
#> 1 b     1       -1.50      0.155     -9.67 2.01e-22
#> 2 b     2       -0.843     0.139     -6.06 1.35e- 9
#> 3 b     3       -2.16      0.138    -15.7  1.65e-55
#> 4 b     4       -1.45      0.169     -8.62 3.41e-18
#> 5 e     1      252.       13.8       18.2  1.16e-74
#> 6 e     2      378.       39.4        9.61 3.53e-22
#> 7 e     3      120.        5.91      20.3  1.14e-91
#> 8 e     4       88.8       8.62      10.3  3.28e-25
tidy(mod, conf.int = TRUE)
#> # A tibble: 8 × 8
#>   term  curve estimate std.error statistic  p.value conf.low conf.high
#>   <chr> <chr>    <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 b     1       -1.50      0.155     -9.67 2.01e-22    -1.81    -1.20 
#> 2 b     2       -0.843     0.139     -6.06 1.35e- 9    -1.12    -0.571
#> 3 b     3       -2.16      0.138    -15.7  1.65e-55    -2.43    -1.89 
#> 4 b     4       -1.45      0.169     -8.62 3.41e-18    -1.78    -1.12 
#> 5 e     1      252.       13.8       18.2  1.16e-74   225.     279.   
#> 6 e     2      378.       39.4        9.61 3.53e-22   301.     456.   
#> 7 e     3      120.        5.91      20.3  1.14e-91   108.     131.   
#> 8 e     4       88.8       8.62      10.3  3.28e-25    71.9    106.   

glance(mod)
#> # A tibble: 1 × 4
#>     AIC   BIC logLik    df.residual
#>   <dbl> <dbl> <logLik>        <int>
#> 1  768.  778. -376.2099          17

augment(mod, selenium)
#> # A tibble: 25 × 7
#>     type  conc total  dead .fitted  .resid    .cooksd
#>    <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>      <dbl>
#>  1     1     0   151     3   0      0.0199 0         
#>  2     1   100   146    40   0.199  0.0748 0.0000909 
#>  3     1   200   116    31   0.414 -0.146  0.000104  
#>  4     1   300   159    85   0.565 -0.0302 0.00000516
#>  5     1   400   150   102   0.667  0.0133 0.00000220
#>  6     1   500   140   112   0.737  0.0633 0.0000720 
#>  7     2     0   141     2   0      0.0142 0         
#>  8     2   100   153    30   0.246 -0.0495 0.000168  
#>  9     2   200   142    59   0.369  0.0468 0.0000347 
#> 10     2   300   139    82   0.451  0.139  0.0000430 
#> # ℹ 15 more rows
```
