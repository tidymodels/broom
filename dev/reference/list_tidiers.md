# Tidying methods for lists / returned values that are not S3 objects

Broom tidies a number of lists that are effectively S3 objects without a
class attribute. For example,
[`stats::optim()`](https://rdrr.io/r/stats/optim.html),
[`base::svd()`](https://rdrr.io/r/base/svd.html) and
[`interp::interp()`](https://rdrr.io/pkg/interp/man/interp.html) produce
consistent output, but because they do not have a class attribute, they
cannot be handled by S3 dispatch.

## Usage

``` r
# S3 method for class 'list'
tidy(x, ...)

# S3 method for class 'list'
glance(x, ...)
```

## Arguments

- x:

  A list, potentially representing an object that can be tidied.

- ...:

  Additionally, arguments passed to the tidying function.

## Details

These functions look at the elements of a list and determine if there is
an appropriate tidying method to apply to the list. Those tidiers are
themselves are implemented as functions of the form `tidy_<function>` or
`glance_<function>` and are not exported (but they are documented!).

If no appropriate tidying method is found, throws an error.

## See also

Other list tidiers:
[`glance_optim()`](https://broom.tidymodels.org/dev/reference/glance_optim.md),
[`tidy_irlba()`](https://broom.tidymodels.org/dev/reference/tidy_irlba.md),
[`tidy_optim()`](https://broom.tidymodels.org/dev/reference/tidy_optim.md),
[`tidy_svd()`](https://broom.tidymodels.org/dev/reference/tidy_svd.md),
[`tidy_xyz()`](https://broom.tidymodels.org/dev/reference/tidy_xyz.md)
