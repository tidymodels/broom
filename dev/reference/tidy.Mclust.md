# Tidy a(n) Mclust object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'Mclust'
tidy(x, ...)
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

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`mclust::Mclust()`](https://mclust-org.github.io/mclust/reference/Mclust.html)

Other mclust tidiers:
[`augment.Mclust()`](https://broom.tidymodels.org/dev/reference/augment.Mclust.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- proportion:

  The mixing proportion of each component

- size:

  Number of points assigned to cluster.

- mean:

  The mean for each component. In case of 2+ dimensional models, a
  column with the mean is added for each dimension. NA for noise
  component

- variance:

  In case of one-dimensional and spherical models, the variance for each
  component, omitted otherwise. NA for noise component

- component:

  Cluster id as a factor.

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
