# Augment data with information from a(n) lmrob object

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
# S3 method for class 'lmrob'
augment(x, data = model.frame(x), newdata = NULL, se_fit = FALSE, ...)
```

## Arguments

- x:

  A `lmrob` object returned from
  [`robustbase::lmrob()`](https://rdrr.io/pkg/robustbase/man/lmrob.html).

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

## Details

For tidiers for robust models from the MASS package see
[`tidy.rlm()`](https://broom.tidymodels.org/dev/reference/tidy.rlm.md).

## See also

[`robustbase::lmrob()`](https://rdrr.io/pkg/robustbase/man/lmrob.html)

Other robustbase tidiers:
[`augment.glmrob()`](https://broom.tidymodels.org/dev/reference/augment.robustbase.glmrob.md),
[`glance.lmrob()`](https://broom.tidymodels.org/dev/reference/glance.robustbase.lmrob.md),
[`tidy.glmrob()`](https://broom.tidymodels.org/dev/reference/tidy.robustbase.glmrob.md),
[`tidy.lmrob()`](https://broom.tidymodels.org/dev/reference/tidy.robustbase.lmrob.md)

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
if (requireNamespace("robustbase", quietly = TRUE)) {
  # load libraries for models and data
  library(robustbase)

  data(coleman)
  set.seed(0)

  m <- lmrob(Y ~ ., data = coleman)
  tidy(m)
  augment(m)
  glance(m)

  data(carrots)

  Rfit <- glmrob(cbind(success, total - success) ~ logdose + block,
    family = binomial, data = carrots, method = "Mqle",
    control = glmrobMqle.control(tcc = 1.2)
  )

  tidy(Rfit)
  augment(Rfit)
}
#> # A tibble: 24 × 5
#>    cbind(success, total - succ…¹ [,""] logdose block .fitted .resid[,1]
#>                            <int> <int>   <dbl> <fct>   <dbl>      <dbl>
#>  1                            10    25    1.52 B1     -0.726      10.7 
#>  2                            16    26    1.64 B1     -0.972      17.0 
#>  3                             8    42    1.76 B1     -1.22        9.22
#>  4                             6    36    1.88 B1     -1.46        7.46
#>  5                             9    26    2    B1     -1.71       10.7 
#>  6                             9    33    2.12 B1     -1.96       11.0 
#>  7                             1    31    2.24 B1     -2.20        3.20
#>  8                             2    26    2.36 B1     -2.45        4.45
#>  9                            17    21    1.52 B2     -0.491      17.5 
#> 10                            10    30    1.64 B2     -0.737      10.7 
#> # ℹ 14 more rows
#> # ℹ abbreviated name: ¹​`cbind(success, total - success)`[,"success"]
#> # ℹ 1 more variable: .resid[2] <dbl>
```
