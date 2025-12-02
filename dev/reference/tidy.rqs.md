# Tidy a(n) rqs object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'rqs'
tidy(x, se.type = "rank", conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  An `rqs` object returned from
  [`quantreg::rq()`](https://rdrr.io/pkg/quantreg/man/rq.html).

- se.type:

  Character specifying the method to use to calculate standard errors.
  Passed to
  [`quantreg::summary.rq()`](https://rdrr.io/pkg/quantreg/man/summary.rq.html)
  `se` argument. Defaults to `"rank"`.

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- ...:

  Additional arguments passed to
  [`quantreg::summary.rqs()`](https://rdrr.io/pkg/quantreg/man/summary.rq.html)

## Details

If `se.type = "rank"` confidence intervals are calculated by
`summary.rq`. When only a single predictor is included in the model, no
confidence intervals are calculated and the confidence limits are set to
NA.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`quantreg::rq()`](https://rdrr.io/pkg/quantreg/man/rq.html)

Other quantreg tidiers:
[`augment.nlrq()`](https://broom.tidymodels.org/dev/reference/augment.nlrq.md),
[`augment.rq()`](https://broom.tidymodels.org/dev/reference/augment.rq.md),
[`augment.rqs()`](https://broom.tidymodels.org/dev/reference/augment.rqs.md),
[`glance.nlrq()`](https://broom.tidymodels.org/dev/reference/glance.nlrq.md),
[`glance.rq()`](https://broom.tidymodels.org/dev/reference/glance.rq.md),
[`tidy.nlrq()`](https://broom.tidymodels.org/dev/reference/tidy.nlrq.md),
[`tidy.rq()`](https://broom.tidymodels.org/dev/reference/tidy.rq.md)

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

- quantile:

  Linear conditional quantile.

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
#>  2         37                   80 -7.11e-15    37     0.5
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
#> 1 (Intercept)   -0.159 NA       NA          0.5
glance(mod2)
#> # A tibble: 1 × 5
#>     tau logLik      AIC   BIC df.residual
#>   <dbl> <logLik>  <dbl> <dbl>       <int>
#> 1   0.5 -75.59969  153.  155.          49
augment(mod2)
#> # A tibble: 50 × 5
#>    `rnorm(50)` `(weights)` .resid .fitted  .tau
#>          <dbl>       <dbl>  <dbl>   <dbl> <dbl>
#>  1       0.392      0.293   0.551  -0.159   0.5
#>  2      -0.547      0.669  -0.388  -0.159   0.5
#>  3      -0.468      0.408  -0.308  -0.159   0.5
#>  4      -1.11       0.664  -0.948  -0.159   0.5
#>  5       0.786      0.0497  0.945  -0.159   0.5
#>  6      -0.648      0.496  -0.489  -0.159   0.5
#>  7       1.07       0.785   1.23   -0.159   0.5
#>  8       0.362      0.906   0.522  -0.159   0.5
#>  9       1.92       0.0210  2.07   -0.159   0.5
#> 10       0.553      0.163   0.713  -0.159   0.5
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
#>  4         37                   80 0.5   -7.11 e-15    37  
#>  5         37                   75 0.25   1.05 e+ 1    26.5
#>  6         37                   75 0.5    5.43 e+ 0    31.6
#>  7         28                   62 0.25   9.00 e+ 0    19.0
#>  8         28                   62 0.5    7.63 e+ 0    20.4
#>  9         18                   62 0.25   1.000e+ 0    17.0
#> 10         18                   62 0.5   -1.22 e+ 0    19.2
#> # ℹ 32 more rows
#> # ℹ 1 more variable: stack.x[2:3] <dbl>

# glance cannot handle rqs objects like `mod3`--use a purrr
# `map`-based workflow instead
```
