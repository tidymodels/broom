# Tidy a(n) boot object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'boot'
tidy(
  x,
  conf.int = FALSE,
  conf.level = 0.95,
  conf.method = c("perc", "bca", "basic", "norm"),
  exponentiate = FALSE,
  ...
)
```

## Arguments

- x:

  A [`boot::boot()`](https://rdrr.io/pkg/boot/man/boot.html) object.

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- conf.method:

  Passed to the `type` argument of
  [`boot::boot.ci()`](https://rdrr.io/pkg/boot/man/boot.ci.html).
  Defaults to `"perc"`. The allowed types are `"perc"`, `"basic"`,
  `"bca"`, and `"norm"`. Does not support `"stud"` or `"all"`.

- exponentiate:

  Logical indicating whether or not to exponentiate the the coefficient
  estimates. This is typical for logistic and multinomial regressions,
  but a bad idea if there is no log or logit link. Defaults to `FALSE`.

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

If weights were provided to the `boot` function, an `estimate` column is
included showing the weighted bootstrap estimate, and the standard error
is of that estimate.

If there are no original statistics in the "boot" object, such as with a
call to `tsboot` with `orig.t = FALSE`, the `original` and `statistic`
columns are omitted, and only `estimate` and `std.error` columns shown.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`boot::boot()`](https://rdrr.io/pkg/boot/man/boot.html),
[`boot::tsboot()`](https://rdrr.io/pkg/boot/man/tsboot.html),
[`boot::boot.ci()`](https://rdrr.io/pkg/boot/man/boot.ci.html),
[`rsample::bootstraps()`](https://rsample.tidymodels.org/reference/bootstraps.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- bias:

  Bias of the statistic.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

- statistic:

  Original value of the statistic.

## Examples

``` r
# load modeling library
library(boot)
#> 
#> Attaching package: ‘boot’
#> The following object is masked from ‘package:speedglm’:
#> 
#>     control
#> The following object is masked from ‘package:robustbase’:
#> 
#>     salinity
#> The following object is masked from ‘package:car’:
#> 
#>     logit
#> The following object is masked from ‘package:survival’:
#> 
#>     aml

clotting <- data.frame(
  u = c(5, 10, 15, 20, 30, 40, 60, 80, 100),
  lot1 = c(118, 58, 42, 35, 27, 25, 21, 19, 18),
  lot2 = c(69, 35, 26, 21, 18, 16, 13, 12, 12)
)

# fit models
g1 <- glm(lot2 ~ log(u), data = clotting, family = Gamma)

bootfun <- function(d, i) {
  coef(update(g1, data = d[i, ]))
}

bootres <- boot(clotting, bootfun, R = 999)

# summarize model fits with tidiers
tidy(g1, conf.int = TRUE)
#> # A tibble: 2 × 7
#>   term        estimate std.error statistic   p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
#> 1 (Intercept)  -0.0239  0.00133      -18.0   4.00e-7  -0.0265   -0.0213
#> 2 log(u)        0.0236  0.000577      40.9   1.36e-9   0.0225    0.0247
tidy(bootres, conf.int = TRUE)
#> # A tibble: 2 × 6
#>   term        statistic      bias std.error conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
#> 1 (Intercept)   -0.0239 -0.00170    0.00336  -0.0328   -0.0222
#> 2 log(u)         0.0236  0.000503   0.00107   0.0227    0.0265
```
