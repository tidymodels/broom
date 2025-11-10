# Tidy a(n) glmrob object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'glmrob'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `glmrob` object returned from
  [`robustbase::glmrob()`](https://rdrr.io/pkg/robustbase/man/glmrob.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

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

For tidiers for robust models from the MASS package see
[`tidy.rlm()`](https://broom.tidymodels.org/dev/reference/tidy.rlm.md).

## See also

[`robustbase::glmrob()`](https://rdrr.io/pkg/robustbase/man/glmrob.html)

Other robustbase tidiers:
[`augment.glmrob()`](https://broom.tidymodels.org/dev/reference/augment.robustbase.glmrob.md),
[`augment.lmrob()`](https://broom.tidymodels.org/dev/reference/augment.robustbase.lmrob.md),
[`glance.lmrob()`](https://broom.tidymodels.org/dev/reference/glance.robustbase.lmrob.md),
[`tidy.lmrob()`](https://broom.tidymodels.org/dev/reference/tidy.robustbase.lmrob.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- estimate:

  The estimated value of the regression term.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

## Examples

``` r
if (requireNamespace("robustbase", quietly = TRUE)) {
  # load libraries for models and data
  library(robustbase)

  data(coleman)
  set.seed(0)

  m <- lmrob(Y ~ ., data = coleman)
  tidy(m)
  augment(m)
  glance(m)

  data(carrots)

  Rfit <- glmrob(cbind(success, total - success) ~ logdose + block,
    family = binomial, data = carrots, method = "Mqle",
    control = glmrobMqle.control(tcc = 1.2)
  )

  tidy(Rfit)
  augment(Rfit)
}
#> # A tibble: 24 × 5
#>    cbind(success, total - succ…¹ [,""] logdose block .fitted .resid[,1]
#>                            <int> <int>   <dbl> <fct>   <dbl>      <dbl>
#>  1                            10    25    1.52 B1     -0.726      10.7 
#>  2                            16    26    1.64 B1     -0.972      17.0 
#>  3                             8    42    1.76 B1     -1.22        9.22
#>  4                             6    36    1.88 B1     -1.46        7.46
#>  5                             9    26    2    B1     -1.71       10.7 
#>  6                             9    33    2.12 B1     -1.96       11.0 
#>  7                             1    31    2.24 B1     -2.20        3.20
#>  8                             2    26    2.36 B1     -2.45        4.45
#>  9                            17    21    1.52 B2     -0.491      17.5 
#> 10                            10    30    1.64 B2     -0.737      10.7 
#> # ℹ 14 more rows
#> # ℹ abbreviated name: ¹​`cbind(success, total - success)`[,"success"]
#> # ℹ 1 more variable: .resid[2] <dbl>
```
