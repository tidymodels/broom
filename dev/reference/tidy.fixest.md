# Tidy a(n) fixest object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'fixest'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `fixest` object returned from any of the `fixest` estimators

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- ...:

  Additional arguments passed to `summary` and `confint`. Important
  arguments are `se` and `cluster`. Other arguments are `dof`,
  `exact_dof`, `forceCovariance`, and `keepBounded`. See
  [`summary.fixest`](https://lrberge.github.io/fixest/reference/summary.fixest.html).

## Details

The `fixest` package provides a family of functions for estimating
models with arbitrary numbers of fixed-effects, in both an OLS and a GLM
context. The package also supports robust (i.e. White) and clustered
standard error reporting via the generic `summary.fixest()` command. In
a similar vein, the
[`tidy()`](https://generics.r-lib.org/reference/tidy.html) method for
these models allows users to specify a desired standard error correction
either 1) implicitly via the supplied fixest object, or 2) explicitly as
part of the tidy call. See examples below.

Note that fixest confidence intervals are calculated assuming a normal
distribution – this assumes infinite degrees of freedom for the CI.
(This assumption is distinct from the degrees of freedom used to
calculate the standard errors. For more on degrees of freedom with
clusters and fixed effects, see
<https://github.com/lrberge/fixest/issues/6> and
<https://github.com/sgaure/lfe/issues/1#issuecomment-530646990>)

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`fixest::feglm()`](https://lrberge.github.io/fixest/reference/feglm.html),
[`fixest::fenegbin()`](https://lrberge.github.io/fixest/reference/femlm.html),
[`fixest::feNmlm()`](https://lrberge.github.io/fixest/reference/feNmlm.html),
[`fixest::femlm()`](https://lrberge.github.io/fixest/reference/femlm.html),
[`fixest::feols()`](https://lrberge.github.io/fixest/reference/feols.html),
[`fixest::fepois()`](https://lrberge.github.io/fixest/reference/feglm.html)

Other fixest tidiers:
[`augment.fixest()`](https://broom.tidymodels.org/dev/reference/augment.fixest.md)

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
# load libraries for models and data
library(fixest)

gravity <-
  feols(
    log(Euros) ~ log(dist_km) | Origin + Destination + Product + Year, trade
  )

tidy(gravity)
#> # A tibble: 1 × 5
#>   term         estimate std.error statistic p.value
#>   <chr>           <dbl>     <dbl>     <dbl>   <dbl>
#> 1 log(dist_km)    -2.17    0.0209     -104.       0
glance(gravity)
#> # A tibble: 1 × 9
#>   r.squared adj.r.squared within.r.squared pseudo.r.squared sigma  nobs
#>       <dbl>         <dbl>            <dbl>            <dbl> <dbl> <int>
#> 1     0.706         0.705            0.219               NA  1.74 38325
#> # ℹ 3 more variables: AIC <dbl>, BIC <dbl>, logLik <dbl>
augment(gravity, trade)
#> # A tibble: 38,325 × 9
#>    .rownames Destination Origin Product  Year dist_km    Euros .fitted
#>    <chr>     <fct>       <fct>    <int> <dbl>   <dbl>    <dbl>   <dbl>
#>  1 1         LU          BE           1  2007    140.  2966697    14.1
#>  2 2         BE          LU           1  2007    140.  6755030    13.0
#>  3 3         LU          BE           2  2007    140. 57078782    16.9
#>  4 4         BE          LU           2  2007    140.  7117406    15.8
#>  5 5         LU          BE           3  2007    140. 17379821    16.3
#>  6 6         BE          LU           3  2007    140.  2622254    15.2
#>  7 7         LU          BE           4  2007    140. 64867588    17.4
#>  8 8         BE          LU           4  2007    140. 10731757    16.3
#>  9 9         LU          BE           5  2007    140.   330702    14.1
#> 10 10        BE          LU           5  2007    140.     7706    13.0
#> # ℹ 38,315 more rows
#> # ℹ 1 more variable: .resid <dbl>

# to get robust or clustered SEs, users can either:

# 1) specify the arguments directly in the `tidy()` call

tidy(gravity, conf.int = TRUE, cluster = c("Product", "Year"))
#> # A tibble: 1 × 7
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 log(dist_km)    -2.17    0.0760     -28.5 3.88e-10    -2.34     -2.00

tidy(gravity, conf.int = TRUE, se = "threeway")
#> # A tibble: 1 × 7
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 log(dist_km)    -2.17     0.175     -12.4  6.08e-9    -2.54     -1.79

# 2) or, feed tidy() a summary.fixest object that has already accepted
# these arguments

gravity_summ <- summary(gravity, cluster = c("Product", "Year"))

tidy(gravity_summ, conf.int = TRUE)
#> # A tibble: 1 × 7
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 log(dist_km)    -2.17    0.0760     -28.5 3.88e-10    -2.34     -2.00

# approach (1) is preferred.
```
