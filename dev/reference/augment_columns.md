# Add fitted values, residuals, and other common outputs to an augment call

`augment_columns` is intended for use in the internals of `augment`
methods only and is exported for developers extending the broom package.
Please instead use
[`augment()`](https://generics.r-lib.org/reference/augment.html) to
appropriately make use of the functionality in `augment_columns()`.

## Usage

``` r
augment_columns(
  x,
  data,
  newdata = NULL,
  type,
  type.predict = type,
  type.residuals = type,
  se.fit = TRUE,
  ...
)
```

## Arguments

- x:

  a model

- data:

  original data onto which columns should be added

- newdata:

  new data to predict on, optional

- type:

  Type of prediction and residuals to compute

- type.predict:

  Type of prediction to compute; by default same as `type`

- type.residuals:

  Type of residuals to compute; by default same as `type`

- se.fit:

  Value to pass to predict's `se.fit`, or NULL for no value. Ignored for
  model types that do not accept an `se.fit` argument

- ...:

  extra arguments (not used)

## Details

Note that, in the case that a
[`residuals()`](https://rdrr.io/r/stats/residuals.html) or
[`influence()`](https://rdrr.io/r/stats/lm.influence.html) generic is
not implemented for the supplied model `x`, the function will fail
quietly.
