# Tidy a(n) kmeans object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'kmeans'
tidy(x, col.names = colnames(x$centers), ...)
```

## Arguments

- x:

  A `kmeans` object created by
  [`stats::kmeans()`](https://rdrr.io/r/stats/kmeans.html).

- col.names:

  Dimension names. Defaults to the names of the variables in x. Set to
  NULL to get names `x1, x2, ...`.

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
[`stats::kmeans()`](https://rdrr.io/r/stats/kmeans.html)

Other kmeans tidiers:
[`augment.kmeans()`](https://broom.tidymodels.org/dev/reference/augment.kmeans.md),
[`glance.kmeans()`](https://broom.tidymodels.org/dev/reference/glance.kmeans.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- cluster:

  A factor describing the cluster from 1:k.

- size:

  Number of points assigned to cluster.

- withinss:

  The within-cluster sum of squares.

## Examples

``` r
if (FALSE) {

library(cluster)
library(modeldata)
library(dplyr)

data(hpc_data)

x <- hpc_data[, 2:5]

fit <- pam(x, k = 4)

tidy(fit)
glance(fit)
augment(fit, x)
}
```
