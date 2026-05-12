# Tidy a(n) glmnet object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'glmnet'
tidy(x, return_zeros = FALSE, ...)
```

## Arguments

- x:

  A `glmnet` object returned from
  [`glmnet::glmnet()`](https://rdrr.io/pkg/glmnet/man/glmnet.html).

- return_zeros:

  Logical indicating whether coefficients with value zero zero should be
  included in the results. Defaults to `FALSE`.

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

Note that while this representation of GLMs is much easier to plot and
combine than the default structure, it is also much more
memory-intensive. Do not use for large, sparse matrices.

No `augment` method is yet provided even though the model produces
predictions, because the input data is not tidy (it is a matrix that may
be very wide) and therefore combining predictions with it is not
logical. Furthermore, predictions make sense only with a specific choice
of lambda.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`glmnet::glmnet()`](https://rdrr.io/pkg/glmnet/man/glmnet.html)

Other glmnet tidiers:
[`glance.cv.glmnet()`](https://broom.tidymodels.org/dev/reference/glance.cv.glmnet.md),
[`glance.glmnet()`](https://broom.tidymodels.org/dev/reference/glance.glmnet.md),
[`tidy.cv.glmnet()`](https://broom.tidymodels.org/dev/reference/tidy.cv.glmnet.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- dev.ratio:

  Fraction of null deviance explained at each value of lambda.

- estimate:

  The estimated value of the regression term.

- lambda:

  Value of penalty parameter lambda.

- step:

  Which step of lambda choices was used.

- term:

  The name of the regression term.

## Examples

``` r
if (FALSE) {

# load libraries for models and data
library(glmnet)

set.seed(2014)
x <- matrix(rnorm(100 * 20), 100, 20)
y <- rnorm(100)
fit1 <- glmnet(x, y)

# summarize model fit with tidiers + visualization
tidy(fit1)
glance(fit1)

library(dplyr)
library(ggplot2)

tidied <- tidy(fit1) |> filter(term != "(Intercept)")

ggplot(tidied, aes(step, estimate, group = term)) +
  geom_line()

ggplot(tidied, aes(lambda, estimate, group = term)) +
  geom_line() +
  scale_x_log10()

ggplot(tidied, aes(lambda, dev.ratio)) +
  geom_line()

# works for other types of regressions as well, such as logistic
g2 <- sample(1:2, 100, replace = TRUE)
fit2 <- glmnet(x, g2, family = "binomial")
tidy(fit2)
}
```
