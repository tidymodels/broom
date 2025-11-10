# Glance at a(n) negbin object

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
# S3 method for class 'negbin'
glance(x, ...)
```

## Arguments

- x:

  A `negbin` object returned by
  [`MASS::glm.nb()`](https://rdrr.io/pkg/MASS/man/glm.nb.html).

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

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`MASS::glm.nb()`](https://rdrr.io/pkg/MASS/man/glm.nb.html)

Other glm.nb tidiers:
[`tidy.negbin()`](https://broom.tidymodels.org/dev/reference/tidy.negbin.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- deviance:

  Deviance of the model.

- df.null:

  Degrees of freedom used by the null model.

- df.residual:

  Residual degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- null.deviance:

  Deviance of the null model.

## Examples

``` r
# load libraries for models and data
library(MASS)

# fit model
r <- glm.nb(Days ~ Sex / (Age + Eth * Lrn), data = quine)

# summarize model fit with tidiers
tidy(r)
#> # A tibble: 14 × 5
#>    term            estimate std.error statistic  p.value
#>    <chr>              <dbl>     <dbl>     <dbl>    <dbl>
#>  1 (Intercept)       3.02       0.297    10.2   2.89e-24
#>  2 SexM             -0.475      0.396    -1.20  2.29e- 1
#>  3 SexF:AgeF1       -0.709      0.323    -2.19  2.83e- 2
#>  4 SexM:AgeF1       -0.724      0.330    -2.19  2.85e- 2
#>  5 SexF:AgeF2       -0.615      0.371    -1.66  9.78e- 2
#>  6 SexM:AgeF2        0.628      0.274     2.30  2.17e- 2
#>  7 SexF:AgeF3       -0.342      0.327    -1.05  2.95e- 1
#>  8 SexM:AgeF3        1.15       0.314     3.67  2.46e- 4
#>  9 SexF:EthN        -0.0731     0.265    -0.276 7.83e- 1
#> 10 SexM:EthN        -0.679      0.256    -2.65  8.07e- 3
#> 11 SexF:LrnSL        0.944      0.322     2.93  3.43e- 3
#> 12 SexM:LrnSL        0.239      0.336     0.712 4.76e- 1
#> 13 SexF:EthN:LrnSL  -1.36       0.377    -3.60  3.16e- 4
#> 14 SexM:EthN:LrnSL   0.761      0.441     1.73  8.45e- 2
glance(r)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik     AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int> <logLik> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          235.     145 -531.51… 1093. 1138.     168.         132   146
```
