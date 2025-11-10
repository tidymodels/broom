# Glance at a(n) fixest object

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
# S3 method for class 'fixest'
glance(x, ...)
```

## Arguments

- x:

  A `fixest` object returned from any of the `fixest` estimators

- ...:

  Additional arguments passed to `summary` and `confint`. Important
  arguments are `se` and `cluster`. Other arguments are `dof`,
  `exact_dof`, `forceCovariance`, and `keepBounded`. See
  [`summary.fixest`](https://lrberge.github.io/fixest/reference/summary.fixest.html).

## Note

All columns listed below will be returned, but some will be `NA`,
depending on the type of model estimated. `sigma`, `r.squared`,
`adj.r.squared`, and `within.r.squared` will be NA for any model other
than `feols`. `pseudo.r.squared` will be NA for `feols`.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- adj.r.squared:

  Adjusted R squared statistic, which is like the R squared statistic
  except taking degrees of freedom into account.

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- nobs:

  Number of observations used.

- pseudo.r.squared:

  Like the R squared statistic, but for situations when the R squared
  statistic isn't defined.

- r.squared:

  R squared statistic, or the percent of variation explained by the
  model. Also known as the coefficient of determination.

- sigma:

  Estimated standard error of the residuals.

- within.r.squared:

  R squared within fixed-effect groups.

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
