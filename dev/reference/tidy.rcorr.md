# Tidy a(n) rcorr object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'rcorr'
tidy(x, diagonal = FALSE, ...)
```

## Arguments

- x:

  An `rcorr` object returned from
  [`Hmisc::rcorr()`](https://rdrr.io/pkg/Hmisc/man/rcorr.html).

- diagonal:

  Logical indicating whether or not to include diagonal elements of the
  correlation matrix, or the correlation of a column with itself. For
  the elements, `estimate` is always 1 and `p.value` is always `NA`.
  Defaults to `FALSE`.

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

Suppose the original data has columns A and B. In the correlation matrix
from `rcorr` there may be entries for both the `cor(A, B)` and
`cor(B, A)`. Only one of these pairs will ever be present in the tidy
output.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`Hmisc::rcorr()`](https://rdrr.io/pkg/Hmisc/man/rcorr.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- column1:

  Name or index of the first column being described.

- column2:

  Name or index of the second column being described.

- estimate:

  The estimated value of the regression term.

- p.value:

  The two-sided p-value associated with the observed statistic.

- n:

  Number of observations used to compute the correlation

## Examples

``` r
# load libraries for models and data
library(Hmisc)
#> 
#> Attaching package: ‘Hmisc’
#> The following object is masked from ‘package:psych’:
#> 
#>     describe
#> The following object is masked from ‘package:network’:
#> 
#>     is.discrete
#> The following object is masked from ‘package:survey’:
#> 
#>     deff
#> The following object is masked from ‘package:quantreg’:
#> 
#>     latex
#> The following objects are masked from ‘package:dplyr’:
#> 
#>     src, summarize
#> The following objects are masked from ‘package:base’:
#> 
#>     format.pval, units

mat <- replicate(52, rnorm(100))

# add some NAs
mat[sample(length(mat), 2000)] <- NA

# also, column names
colnames(mat) <- c(LETTERS, letters)

# fit model
rc <- rcorr(mat)

# summarize model fit with tidiers  + visualization
td <- tidy(rc)
td
#> # A tibble: 1,326 × 5
#>    column1 column2 estimate     n p.value
#>    <chr>   <chr>      <dbl> <int>   <dbl>
#>  1 B       A        -0.0954    40   0.558
#>  2 C       A        -0.137     38   0.413
#>  3 C       B         0.184     37   0.275
#>  4 D       A        -0.186     37   0.270
#>  5 D       B         0.0817    35   0.641
#>  6 D       C        -0.0192    35   0.913
#>  7 E       A        -0.0454    42   0.775
#>  8 E       B         0.153     45   0.314
#>  9 E       C        -0.0436    43   0.781
#> 10 E       D        -0.213     34   0.226
#> # ℹ 1,316 more rows

library(ggplot2)
ggplot(td, aes(p.value)) +
  geom_histogram(binwidth = .1)


ggplot(td, aes(estimate, p.value)) +
  geom_point() +
  scale_y_log10()
```
