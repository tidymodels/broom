# Tidy a(n) table object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

Deprecated. Please use
[`tibble::as_tibble()`](https://tibble.tidyverse.org/reference/as_tibble.html)
instead.

## Usage

``` r
# S3 method for class 'table'
tidy(x, ...)
```

## Arguments

- x:

  A [base::table](https://rdrr.io/r/base/table.html) object.

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
in long-form containing frequency information for the table in a `Freq`
column. The result is much like what you get from
[`tidyr::pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html).

## Details

Directly calls
[`tibble::as_tibble()`](https://tibble.tidyverse.org/reference/as_tibble.html)
on a [base::table](https://rdrr.io/r/base/table.html) object.

## See also

[`tibble::as_tibble.table()`](https://tibble.tidyverse.org/reference/as_tibble.html)
