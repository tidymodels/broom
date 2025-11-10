# Tidy a(n) mfx object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

The particular functions below provide generic tidy methods for objects
returned by the `mfx` package, preserving the calculated marginal
effects instead of the naive model coefficients. The returned tidy
tibble will also include an additional "atmean" column indicating how
the marginal effects were originally calculated (see Details below).

## Usage

``` r
# S3 method for class 'mfx'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)

# S3 method for class 'logitmfx'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)

# S3 method for class 'negbinmfx'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)

# S3 method for class 'poissonmfx'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)

# S3 method for class 'probitmfx'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `logitmfx`, `negbinmfx`, `poissonmfx`, or `probitmfx` object. (Note
  that `betamfx` objects receive their own set of tidiers.)

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

The `mfx` package provides methods for calculating marginal effects for
various generalized linear models (GLMs). Unlike standard linear models,
estimated model coefficients in a GLM cannot be directly interpreted as
marginal effects (i.e., the change in the response variable predicted
after a one unit change in one of the regressors). This is because the
estimated coefficients are multiplicative, dependent on both the link
function that was used for the estimation and any other variables that
were included in the model. When calculating marginal effects, users
must typically choose whether they want to use i) the average
observation in the data, or ii) the average of the sample marginal
effects. See
[`vignette("mfxarticle")`](https://cran.rstudio.com/web/packages/mfx/vignettes/mfxarticle.pdf)
from the `mfx` package for more details.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`mfx::logitmfx()`](https://rdrr.io/pkg/mfx/man/logitmfx.html),
[`mfx::negbinmfx()`](https://rdrr.io/pkg/mfx/man/negbinmfx.html),
[`mfx::poissonmfx()`](https://rdrr.io/pkg/mfx/man/poissonmfx.html),
[`mfx::probitmfx()`](https://rdrr.io/pkg/mfx/man/probitmfx.html)

Other mfx tidiers:
[`augment.betamfx()`](https://broom.tidymodels.org/dev/reference/augment.betamfx.md),
[`augment.mfx()`](https://broom.tidymodels.org/dev/reference/augment.mfx.md),
[`glance.betamfx()`](https://broom.tidymodels.org/dev/reference/glance.betamfx.md),
[`glance.mfx()`](https://broom.tidymodels.org/dev/reference/glance.mfx.md),
[`tidy.betamfx()`](https://broom.tidymodels.org/dev/reference/tidy.betamfx.md)

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

- atmean:

  TRUE if the marginal effects were originally calculated as the partial
  effects for the average observation. If FALSE, then these were instead
  calculated as average partial effects.

## Examples

``` r
# load libraries for models and data
library(mfx)

# get the marginal effects from a logit regression
mod_logmfx <- logitmfx(am ~ cyl + hp + wt, atmean = TRUE, data = mtcars)

tidy(mod_logmfx, conf.int = TRUE)
#> # A tibble: 3 × 8
#>   term  atmean estimate std.error statistic p.value conf.low conf.high
#>   <chr> <lgl>     <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 cyl   TRUE    0.0538    0.113       0.475   0.635 -0.178     0.286  
#> 2 hp    TRUE    0.00359   0.00290     1.24    0.216 -0.00236   0.00954
#> 3 wt    TRUE   -1.01      0.668      -1.51    0.131 -2.38      0.359  

# compare with the naive model coefficients of the same logit call
tidy(
  glm(am ~ cyl + hp + wt, family = binomial, data = mtcars),
  conf.int = TRUE
)
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
#> # A tibble: 4 × 7
#>   term        estimate std.error statistic p.value  conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>     <dbl>     <dbl>
#> 1 (Intercept)  19.7       8.12       2.43   0.0152   8.56      44.3   
#> 2 cyl           0.488     1.07       0.455  0.649   -1.53       3.12  
#> 3 hp            0.0326    0.0189     1.73   0.0840   0.00332    0.0884
#> 4 wt           -9.15      4.15      -2.20   0.0276 -21.4       -3.48  

augment(mod_logmfx)
#> # A tibble: 32 × 11
#>    .rownames         am   cyl    hp    wt .fitted  .resid   .hat .sigma
#>    <chr>          <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 Mazda RX4          1     6   110  2.62  2.24    0.449  0.278   0.595
#>  2 Mazda RX4 Wag      1     6   110  2.88 -0.0912  1.22   0.352   0.529
#>  3 Datsun 710         1     4    93  2.32  3.46    0.249  0.0960  0.602
#>  4 Hornet 4 Drive     0     6   110  3.22 -3.20   -0.282  0.0945  0.601
#>  5 Hornet Sporta…     0     8   175  3.44 -2.17   -0.466  0.220   0.595
#>  6 Valiant            0     6   105  3.46 -5.61   -0.0856 0.0221  0.604
#>  7 Duster 360         0     8   245  3.57 -1.07   -0.766  0.337   0.576
#>  8 Merc 240D          0     4    62  3.19 -5.51   -0.0897 0.0376  0.603
#>  9 Merc 230           0     4    95  3.15 -4.07   -0.184  0.122   0.603
#> 10 Merc 280           0     6   123  3.44 -4.84   -0.126  0.0375  0.603
#> # ℹ 22 more rows
#> # ℹ 2 more variables: .cooksd <dbl>, .std.resid <dbl>
glance(mod_logmfx)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          43.2      31  -4.92  17.8  23.7     9.84          28    32

# another example, this time using probit regression
mod_probmfx <- probitmfx(am ~ cyl + hp + wt, atmean = TRUE, data = mtcars)
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred

tidy(mod_probmfx, conf.int = TRUE)
#> # A tibble: 3 × 8
#>   term  atmean estimate std.error statistic p.value conf.low conf.high
#>   <chr> <lgl>     <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 cyl   TRUE    0.0616    0.112       0.548  0.583  -0.169     0.292  
#> 2 hp    TRUE    0.00383   0.00282     1.36   0.174  -0.00194   0.00960
#> 3 wt    TRUE   -1.06      0.594      -1.78   0.0753 -2.27      0.160  
augment(mod_probmfx)
#> # A tibble: 32 × 11
#>    .rownames         am   cyl    hp    wt .fitted  .resid   .hat .sigma
#>    <chr>          <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 Mazda RX4          1     6   110  2.62   1.21   0.490  0.308   0.585
#>  2 Mazda RX4 Wag      1     6   110  2.88  -0.129  1.27   0.249   0.526
#>  3 Datsun 710         1     4    93  2.32   1.85   0.256  0.134   0.594
#>  4 Hornet 4 Drive     0     6   110  3.22  -1.92  -0.237  0.116   0.594
#>  5 Hornet Sporta…     0     8   175  3.44  -1.25  -0.474  0.236   0.587
#>  6 Valiant            0     6   105  3.46  -3.30  -0.0312 0.0111  0.596
#>  7 Duster 360         0     8   245  3.57  -0.595 -0.804  0.285   0.567
#>  8 Merc 240D          0     4    62  3.19  -3.31  -0.0304 0.0179  0.596
#>  9 Merc 230           0     4    95  3.15  -2.47  -0.116  0.130   0.596
#> 10 Merc 280           0     6   123  3.44  -2.85  -0.0662 0.0315  0.596
#> # ℹ 22 more rows
#> # ℹ 2 more variables: .cooksd <dbl>, .std.resid <dbl>
glance(mod_probmfx)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          43.2      31  -4.80  17.6  23.5     9.59          28    32
```
