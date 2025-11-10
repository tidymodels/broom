# Augment data with information from a(n) glm object

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
# S3 method for class 'glm'
augment(
  x,
  data = model.frame(x),
  newdata = NULL,
  type.predict = c("link", "response", "terms"),
  type.residuals = c("deviance", "pearson"),
  se_fit = FALSE,
  ...
)
```

## Arguments

- x:

  A `glm` object returned from
  [`stats::glm()`](https://rdrr.io/r/stats/glm.html).

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
  [`stats::predict.glm()`](https://rdrr.io/r/stats/predict.glm.html)
  `type` argument. Defaults to `"link"`.

- type.residuals:

  Passed to
  [`stats::residuals.glm()`](https://rdrr.io/r/stats/glm.summaries.html)
  and to
  [`stats::rstandard.glm()`](https://rdrr.io/r/stats/influence.measures.html)
  `type` arguments. Defaults to `"deviance"`.

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

If the weights for any of the observations in the model are 0, then
columns ".infl" and ".hat" in the result will be 0 for those
observations.

A `.resid` column is not calculated when data is specified via the
`newdata` argument.

## See also

[`stats::glm()`](https://rdrr.io/r/stats/glm.html)

Other lm tidiers:
[`augment.lm()`](https://broom.tidymodels.org/dev/reference/augment.lm.md),
[`glance.glm()`](https://broom.tidymodels.org/dev/reference/glance.glm.md),
[`glance.lm()`](https://broom.tidymodels.org/dev/reference/glance.lm.md),
[`glance.summary.lm()`](https://broom.tidymodels.org/dev/reference/glance.summary.lm.md),
[`glance.svyglm()`](https://broom.tidymodels.org/dev/reference/glance.svyglm.md),
[`tidy.glm()`](https://broom.tidymodels.org/dev/reference/tidy.glm.md),
[`tidy.lm()`](https://broom.tidymodels.org/dev/reference/tidy.lm.md),
[`tidy.lm.beta()`](https://broom.tidymodels.org/dev/reference/tidy.lm.beta.md),
[`tidy.mlm()`](https://broom.tidymodels.org/dev/reference/tidy.mlm.md),
[`tidy.summary.lm()`](https://broom.tidymodels.org/dev/reference/tidy.summary.lm.md)

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

- .std.resid:

  Standardised residuals.
