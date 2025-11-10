# Glance at a(n) rq object

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
# S3 method for class 'rq'
glance(x, ...)
```

## Arguments

- x:

  An `rq` object returned from
  [`quantreg::rq()`](https://rdrr.io/pkg/quantreg/man/rq.html).

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

Only models with a single `tau` value may be passed. For multiple
values, please use a
[`purrr::map()`](https://purrr.tidyverse.org/reference/map.html)
workflow instead, e.g.

    taus |>
      map(function(tau_val) rq(y ~ x, tau = tau_val)) |>
      map_dfr(glance)

## See also

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`quantreg::rq()`](https://rdrr.io/pkg/quantreg/man/rq.html)

Other quantreg tidiers:
[`augment.nlrq()`](https://broom.tidymodels.org/dev/reference/augment.nlrq.md),
[`augment.rq()`](https://broom.tidymodels.org/dev/reference/augment.rq.md),
[`augment.rqs()`](https://broom.tidymodels.org/dev/reference/augment.rqs.md),
[`glance.nlrq()`](https://broom.tidymodels.org/dev/reference/glance.nlrq.md),
[`tidy.nlrq()`](https://broom.tidymodels.org/dev/reference/tidy.nlrq.md),
[`tidy.rq()`](https://broom.tidymodels.org/dev/reference/tidy.rq.md),
[`tidy.rqs()`](https://broom.tidymodels.org/dev/reference/tidy.rqs.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- df.residual:

  Residual degrees of freedom.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- tau:

  Quantile.

## Examples

``` r
# load modeling library and data
library(quantreg)

data(stackloss)

# median (l1) regression fit for the stackloss data.
mod1 <- rq(stack.loss ~ stack.x, .5)

# weighted sample median
mod2 <- rq(rnorm(50) ~ 1, weights = runif(50))

# summarize model fit with tidiers
tidy(mod1)
#> # A tibble: 4 × 5
#>   term              estimate conf.low conf.high   tau
#>   <chr>                <dbl>    <dbl>     <dbl> <dbl>
#> 1 (Intercept)       -39.7     -53.8    -24.5      0.5
#> 2 stack.xAir.Flow     0.832     0.509    1.17     0.5
#> 3 stack.xWater.Temp   0.574     0.272    3.04     0.5
#> 4 stack.xAcid.Conc.  -0.0609   -0.278    0.0153   0.5
glance(mod1)
#> # A tibble: 1 × 5
#>     tau logLik      AIC   BIC df.residual
#>   <dbl> <logLik>  <dbl> <dbl>       <int>
#> 1   0.5 -50.15272  108.  112.          17
augment(mod1)
#> # A tibble: 21 × 5
#>    stack.loss stack.x[,"Air.Flow"]    .resid .fitted  .tau
#>         <dbl>                <dbl>     <dbl>   <dbl> <dbl>
#>  1         42                   80  5.06e+ 0    36.9   0.5
#>  2         37                   80 -1.42e-14    37     0.5
#>  3         37                   75  5.43e+ 0    31.6   0.5
#>  4         28                   62  7.63e+ 0    20.4   0.5
#>  5         18                   62 -1.22e+ 0    19.2   0.5
#>  6         18                   62 -1.79e+ 0    19.8   0.5
#>  7         19                   62 -1.00e+ 0    20     0.5
#>  8         20                   62 -7.11e-15    20     0.5
#>  9         15                   58 -1.46e+ 0    16.5   0.5
#> 10         14                   58 -2.03e- 2    14.0   0.5
#> # ℹ 11 more rows
#> # ℹ 1 more variable: stack.x[2:3] <dbl>

tidy(mod2)
#> # A tibble: 1 × 5
#>   term        estimate conf.low conf.high   tau
#>   <chr>          <dbl> <lgl>    <lgl>     <dbl>
#> 1 (Intercept)   -0.170 NA       NA          0.5
glance(mod2)
#> # A tibble: 1 × 5
#>     tau logLik      AIC   BIC df.residual
#>   <dbl> <logLik>  <dbl> <dbl>       <int>
#> 1   0.5 -79.69325  161.  163.          49
augment(mod2)
#> # A tibble: 50 × 5
#>    `rnorm(50)` `(weights)` .resid .fitted  .tau
#>          <dbl>       <dbl>  <dbl>   <dbl> <dbl>
#>  1     0.458       0.660    0.628  -0.170   0.5
#>  2    -1.22        0.212   -1.05   -0.170   0.5
#>  3    -1.12        0.00527 -0.952  -0.170   0.5
#>  4     0.993       0.103    1.16   -0.170   0.5
#>  5    -1.83        0.287   -1.66   -0.170   0.5
#>  6     0.124       0.444    0.294  -0.170   0.5
#>  7     0.591       0.693    0.761  -0.170   0.5
#>  8     0.805       0.0209   0.975  -0.170   0.5
#>  9     0.00754     0.956    0.178  -0.170   0.5
#> 10    -1.82        0.804   -1.65   -0.170   0.5
#> # ℹ 40 more rows

# varying tau to generate an rqs object
mod3 <- rq(stack.loss ~ stack.x, tau = c(.25, .5))

tidy(mod3)
#> # A tibble: 8 × 5
#>   term                estimate conf.low conf.high   tau
#>   <chr>                  <dbl>    <dbl>     <dbl> <dbl>
#> 1 (Intercept)       -3.6  e+ 1  -59.0     -7.84    0.25
#> 2 stack.xAir.Flow    5.00 e- 1    0.229    0.970   0.25
#> 3 stack.xWater.Temp  1.000e+ 0    0.286    2.26    0.25
#> 4 stack.xAcid.Conc. -4.58 e-16   -0.643    0.0861  0.25
#> 5 (Intercept)       -3.97 e+ 1  -53.8    -24.5     0.5 
#> 6 stack.xAir.Flow    8.32 e- 1    0.509    1.17    0.5 
#> 7 stack.xWater.Temp  5.74 e- 1    0.272    3.04    0.5 
#> 8 stack.xAcid.Conc. -6.09 e- 2   -0.278    0.0153  0.5 
augment(mod3)
#> # A tibble: 42 × 5
#>    stack.loss stack.x[,"Air.Flow"] .tau      .resid .fitted
#>         <dbl>                <dbl> <chr>      <dbl>   <dbl>
#>  1         42                   80 0.25   1.10 e+ 1    31.0
#>  2         42                   80 0.5    5.06 e+ 0    36.9
#>  3         37                   80 0.25   6.00 e+ 0    31.0
#>  4         37                   80 0.5   -1.42 e-14    37  
#>  5         37                   75 0.25   1.05 e+ 1    26.5
#>  6         37                   75 0.5    5.43 e+ 0    31.6
#>  7         28                   62 0.25   9.00 e+ 0    19  
#>  8         28                   62 0.5    7.63 e+ 0    20.4
#>  9         18                   62 0.25   1.000e+ 0    17.0
#> 10         18                   62 0.5   -1.22 e+ 0    19.2
#> # ℹ 32 more rows
#> # ℹ 1 more variable: stack.x[2:3] <dbl>

# glance cannot handle rqs objects like `mod3`--use a purrr
# `map`-based workflow instead
```
