# Glance at a(n) rma object

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
# S3 method for class 'rma'
glance(x, ...)
```

## Arguments

- x:

  An `rma` object such as those created by
  [`metafor::rma()`](https://wviechtb.github.io/metafor/reference/rma.uni.html),
  [`metafor::rma.uni()`](https://wviechtb.github.io/metafor/reference/rma.uni.html),
  [`metafor::rma.glmm()`](https://wviechtb.github.io/metafor/reference/rma.glmm.html),
  [`metafor::rma.mh()`](https://wviechtb.github.io/metafor/reference/rma.mh.html),
  [`metafor::rma.mv()`](https://wviechtb.github.io/metafor/reference/rma.mv.html),
  or
  [`metafor::rma.peto()`](https://wviechtb.github.io/metafor/reference/rma.peto.html).

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

- cochran.qe:

  In meta-analysis, test statistic for the Cochran's Q_e test of
  residual heterogeneity.

- cochran.qm:

  In meta-analysis, test statistic for the Cochran's Q_m omnibus test of
  coefficients.

- df.residual:

  Residual degrees of freedom.

- h.squared:

  Value of the H-Squared statistic.

- i.squared:

  Value of the I-Squared statistic.

- measure:

  The measure used in the meta-analysis.

- method:

  Which method was used.

- nobs:

  Number of observations used.

- p.value.cochran.qe:

  In meta-analysis, p-value for the Cochran's Q_e test of residual
  heterogeneity.

- p.value.cochran.qm:

  In meta-analysis, p-value for the Cochran's Q_m omnibus test of
  coefficients.

- tau.squared:

  In meta-analysis, estimated amount of residual heterogeneity.

- tau.squared.se:

  In meta-analysis, standard error of residual heterogeneity.

## Examples

``` r
library(metafor)

df <-
  escalc(
    measure = "RR",
    ai = tpos,
    bi = tneg,
    ci = cpos,
    di = cneg,
    data = dat.bcg
  )

meta_analysis <- rma(yi, vi, data = df, method = "EB")

glance(meta_analysis)
#> # A tibble: 1 × 15
#>   i.squared h.squared tau.squared tau.squared.se cochran.qe
#>       <dbl>     <dbl>       <dbl>          <dbl>      <dbl>
#> 1      92.3      13.0       0.318          0.174       152.
#> # ℹ 10 more variables: p.value.cochran.qe <dbl>, cochran.qm <dbl>,
#> #   p.value.cochran.qm <dbl>, df.residual <int>, logLik <dbl>,
#> #   deviance <dbl>, AIC <dbl>, BIC <dbl>, AICc <dbl>, nobs <int>
```
