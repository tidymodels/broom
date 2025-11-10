# Tidy a(n) smooth.spine object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'smooth.spline'
glance(x, ...)
```

## Arguments

- x:

  A `smooth.spline` object returned from
  [`stats::smooth.spline()`](https://rdrr.io/r/stats/smooth.spline.html).

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
[`stats::smooth.spline()`](https://rdrr.io/r/stats/smooth.spline.html)

Other smoothing spline tidiers:
[`augment.smooth.spline()`](https://broom.tidymodels.org/dev/reference/augment.smooth.spline.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- crit:

  Minimized criterion

- cv.crit:

  Cross-validation score

- df:

  Degrees of freedom used by the model.

- lambda:

  Choice of lambda corresponding to \`spar\`.

- nobs:

  Number of observations used.

- pen.crit:

  Penalized criterion.

- spar:

  Smoothing parameter.

## Examples

``` r
if (FALSE) {

# fit model
spl <- smooth.spline(mtcars$wt, mtcars$mpg, df = 4)

# summarize model fit with tidiers
augment(spl, mtcars)

# calls original columns x and y
augment(spl)

library(ggplot2)
ggplot(augment(spl, mtcars), aes(wt, mpg)) +
  geom_point() +
  geom_line(aes(y = .fitted))
}
```
