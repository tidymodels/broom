# Augment data with information from a(n) stl object

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
# S3 method for class 'stl'
augment(x, data = NULL, weights = TRUE, ...)
```

## Arguments

- x:

  An `stl` object returned from
  [`stats::stl()`](https://rdrr.io/r/stats/stl.html).

- data:

  Ignored, included for consistency with the augment generic signature
  only.

- weights:

  Logical indicating whether or not to include the robust weights in the
  output.

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

A [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with one row for each observation in the original times series:

- `.seasonal`:

  The seasonal component of the decomposition.

- `.trend`:

  The trend component of the decomposition.

- `.remainder`:

  The remainder, or "random" component of the decomposition.

- `.weight`:

  The final robust weights, if requested.

- `.seasadj`:

  The seasonally adjusted (or "deseasonalised") series.

## See also

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`stats::stl()`](https://rdrr.io/r/stats/stl.html)

Other decompose tidiers:
[`augment.decomposed.ts()`](https://broom.tidymodels.org/dev/reference/augment.decomposed.ts.md)
