# Augment data with information from a(n) Mclust object

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
# S3 method for class 'Mclust'
augment(x, data = NULL, ...)
```

## Arguments

- x:

  An `Mclust` object return from
  [`mclust::Mclust()`](https://mclust-org.github.io/mclust/reference/Mclust.html).

- data:

  A [base::data.frame](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing the original data that was used to produce the object `x`.
  Defaults to `stats::model.frame(x)` so that `augment(my_fit)` returns
  the augmented original data. **Do not** pass new data to the `data`
  argument. Augment will report information such as influence and cooks
  distance for data passed to the `data` argument. These measures are
  only defined for the original training data.

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
[`mclust::Mclust()`](https://mclust-org.github.io/mclust/reference/Mclust.html)

Other mclust tidiers:
[`tidy.Mclust()`](https://broom.tidymodels.org/dev/reference/tidy.Mclust.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .class:

  Predicted class.

- .uncertainty:

  The uncertainty associated with the classification. Equal to one minus
  the model class probability.

## Examples

``` r
# load library for models and data
library(mclust)
#> Package 'mclust' version 6.1.2
#> Type 'citation("mclust")' for citing this R package in publications.

# load data manipulation libraries
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following object is masked from ‘package:mclust’:
#> 
#>     count
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
library(tibble)
library(purrr)
#> 
#> Attaching package: ‘purrr’
#> The following object is masked from ‘package:mclust’:
#> 
#>     map
library(tidyr)

set.seed(27)

centers <- tibble(
  cluster = factor(1:3),
  # number points in each cluster
  num_points = c(100, 150, 50),
  # x1 coordinate of cluster center
  x1 = c(5, 0, -3),
  # x2 coordinate of cluster center
  x2 = c(-1, 1, -2)
)

points <- centers |>
  mutate(
    x1 = map2(num_points, x1, rnorm),
    x2 = map2(num_points, x2, rnorm)
  ) |>
  select(-num_points, -cluster) |>
  unnest(c(x1, x2))

# fit model
m <- Mclust(points)

# summarize model fit with tidiers
tidy(m)
#> # A tibble: 3 × 6
#>   component  size proportion variance mean.x1 mean.x2
#>       <int> <int>      <dbl>    <dbl>   <dbl>   <dbl>
#> 1         1   101      0.335     1.12  5.01     -1.04
#> 2         2   150      0.503     1.12  0.0594    1.00
#> 3         3    49      0.161     1.12 -3.20     -2.06
augment(m, points)
#> # A tibble: 300 × 4
#>       x1     x2 .class .uncertainty
#>    <dbl>  <dbl> <fct>         <dbl>
#>  1  6.91 -2.74  1          3.98e-11
#>  2  6.14 -2.45  1          1.99e- 9
#>  3  4.24 -0.946 1          1.47e- 4
#>  4  3.54  0.287 1          2.94e- 2
#>  5  3.91  0.408 1          7.48e- 3
#>  6  5.30 -1.58  1          4.22e- 7
#>  7  5.01 -1.77  1          1.06e- 6
#>  8  6.16 -1.68  1          7.64e- 9
#>  9  7.13 -2.17  1          4.16e-11
#> 10  5.24 -2.42  1          1.16e- 7
#> # ℹ 290 more rows
glance(m)
#> # A tibble: 1 × 7
#>   model     G    BIC logLik    df hypvol  nobs
#>   <chr> <int>  <dbl>  <dbl> <dbl>  <dbl> <int>
#> 1 EII       3 -2402. -1175.     9     NA   300
```
