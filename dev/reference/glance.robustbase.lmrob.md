# Glance at a(n) lmrob object

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
# S3 method for class 'lmrob'
glance(x, ...)
```

## Arguments

- x:

  A `lmrob` object returned from
  [`robustbase::lmrob()`](https://rdrr.io/pkg/robustbase/man/lmrob.html).

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

[`robustbase::lmrob()`](https://rdrr.io/pkg/robustbase/man/lmrob.html)

Other robustbase tidiers:
[`augment.glmrob()`](https://broom.tidymodels.org/dev/reference/augment.robustbase.glmrob.md),
[`augment.lmrob()`](https://broom.tidymodels.org/dev/reference/augment.robustbase.lmrob.md),
[`tidy.glmrob()`](https://broom.tidymodels.org/dev/reference/tidy.robustbase.glmrob.md),
[`tidy.lmrob()`](https://broom.tidymodels.org/dev/reference/tidy.robustbase.lmrob.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- df.residual:

  Residual degrees of freedom.

- r.squared:

  R squared statistic, or the percent of variation explained by the
  model. Also known as the coefficient of determination.

- sigma:

  Estimated standard error of the residuals.

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
