# Glance at a(n) Mclust object

Glance accepts a model object and returns a
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row of model summaries. The summaries are typically
goodness of fit measures, p-values for hypothesis tests on residuals, or
model convergence information.

Glance never returns information from the original call to the modeling
function. This includes the name of the modeling function or any
arguments passed to the modeling function.

Glance does not calculate summary measures. Rather, it farms out these
computations to appropriate methods and gathers the results together.
Sometimes a goodness of fit measure will be undefined. In these cases
the measure will be reported as `NA`.

Glance returns the same number of columns regardless of whether the
model matrix is rank-deficient or not. If so, entries in columns that no
longer have a well-defined value are filled in with an `NA` of the
appropriate type.

## Usage

``` r
# S3 method for class 'Mclust'
glance(x, ...)
```

## Arguments

- x:

  An `Mclust` object return from
  [`mclust::Mclust()`](https://mclust-org.github.io/mclust/reference/Mclust.html).

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
with exactly one row and columns:

- BIC:

  Bayesian Information Criterion for the model.

- df:

  Degrees of freedom used by the model.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- model:

  A string denoting the model type with optimal BIC

- G:

  Number mixture components in optimal model

- hypvol:

  If the other model contains a noise component, the value of the
  hypervolume parameter. Otherwise \`NA\`.

## Examples

``` r
# load library for models and data
library(mclust)

# load data manipulation libraries
library(dplyr)
library(tibble)
library(purrr)
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
#> Error in select(mutate(centers, x1 = map2(num_points, x1, rnorm), x2 = map2(num_points,     x2, rnorm)), -num_points, -cluster): unused arguments (-num_points, -cluster)

# fit model
m <- Mclust(points)
#> Error in as.vector(x, mode): cannot coerce type 'closure' to vector of type 'any'

# summarize model fit with tidiers
tidy(m)
#> Error: object 'm' not found
augment(m, points)
#> Error: object 'm' not found
glance(m)
#> Error: object 'm' not found
```
