# Tidy a(n) optim object masquerading as list

Broom tidies a number of lists that are effectively S3 objects without a
class attribute. For example,
[`stats::optim()`](https://rdrr.io/r/stats/optim.html),
[svd()](https://rdrr.io/r/base/svd.html) and
[`interp::interp()`](https://rdrr.io/pkg/interp/man/interp.html) produce
consistent output, but because they do not have a class attribute, they
cannot be handled by S3 dispatch.

These functions look at the elements of a list and determine if there is
an appropriate tidying method to apply to the list. Those tidiers are
implemented as functions of the form `tidy_<function>` or
`glance_<function>` and are not exported (but they are documented!).

If no appropriate tidying method is found, they throw an error.

## Usage

``` r
tidy_optim(x, ...)
```

## Arguments

- x:

  A list returned from
  [`stats::optim()`](https://rdrr.io/r/stats/optim.html).

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

## Note

This function assumes that the provided objective function is a negative
log-likelihood function. Results will be invalid if an incorrect
function is supplied.

tidy(o) glance(o)

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`stats::optim()`](https://rdrr.io/r/stats/optim.html)

Other list tidiers:
[`glance_optim()`](https://broom.tidymodels.org/dev/reference/glance_optim.md),
[`list_tidiers`](https://broom.tidymodels.org/dev/reference/list_tidiers.md),
[`tidy_irlba()`](https://broom.tidymodels.org/dev/reference/tidy_irlba.md),
[`tidy_svd()`](https://broom.tidymodels.org/dev/reference/tidy_svd.md),
[`tidy_xyz()`](https://broom.tidymodels.org/dev/reference/tidy_xyz.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- parameter:

  The parameter being modeled.

- std.error:

  The standard error of the regression term.

- value:

  The value/estimate of the component. Results from data reshaping.

`std.error` is only provided as a column if the Hessian is calculated.

## Examples

``` r
f <- function(x) (x[1] - 2)^2 + (x[2] - 3)^2 + (x[3] - 8)^2
o <- optim(c(1, 1, 1), f)
```
