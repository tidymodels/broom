# Augment data with information from a(n) polr object

Augment accepts a model object and a dataset and adds information about
each observation in the dataset. Most commonly, this includes predicted
values in the `.fitted` column, residuals in the `.resid` column, and
standard errors for the fitted values in a `.se.fit` column. New columns
always begin with a `.` prefix to avoid overwriting columns in the
original dataset.

Users may pass data to augment via either the `data` argument or the
`newdata` argument. If the user passes data to the `data` argument, it
**must** be exactly the data that was used to fit the model object. Pass
datasets to `newdata` to augment data that was not used during model
fitting. This still requires that at least all predictor variable
columns used to fit the model are present. If the original outcome
variable used to fit the model is not included in `newdata`, then no
`.resid` column will be included in the output.

Augment will often behave differently depending on whether `data` or
`newdata` is given. This is because there is often information
associated with training observations (such as influences or related)
measures that is not meaningfully defined for new observations.

For convenience, many augment methods provide default `data` arguments,
so that `augment(fit)` will return the augmented training data. In these
cases, augment tries to reconstruct the original data based on the model
object with varying degrees of success.

The augmented dataset is always returned as a
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with the **same number of rows** as the passed dataset. This means that
the passed data must be coercible to a tibble. If a predictor enters the
model as part of a matrix of covariates, such as when the model formula
uses [`splines::ns()`](https://rdrr.io/r/splines/ns.html),
[`stats::poly()`](https://rdrr.io/r/stats/poly.html), or
[`survival::Surv()`](https://rdrr.io/pkg/survival/man/Surv.html), it is
represented as a matrix column.

We are in the process of defining behaviors for models fit with various
`na.action` arguments, but make no guarantees about behavior when data
is missing at this time.

## Usage

``` r
# S3 method for class 'polr'
augment(
  x,
  data = model.frame(x),
  newdata = NULL,
  type.predict = c("class"),
  ...
)
```

## Arguments

- x:

  A `polr` object returned from
  [`MASS::polr()`](https://rdrr.io/pkg/MASS/man/polr.html).

- data:

  A [base::data.frame](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing the original data that was used to produce the object `x`.
  Defaults to `stats::model.frame(x)` so that `augment(my_fit)` returns
  the augmented original data. **Do not** pass new data to the `data`
  argument. Augment will report information such as influence and cooks
  distance for data passed to the `data` argument. These measures are
  only defined for the original training data.

- newdata:

  A [`base::data.frame()`](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing all the original predictors used to create `x`. Defaults to
  `NULL`, indicating that nothing has been passed to `newdata`. If
  `newdata` is specified, the `data` argument will be ignored.

- type.predict:

  Which type of prediction to compute, passed to
  `MASS:::predict.polr()`. Only supports `"class"` at the moment.

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

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`MASS::polr()`](https://rdrr.io/pkg/MASS/man/polr.html)

Other ordinal tidiers:
[`augment.clm()`](https://broom.tidymodels.org/dev/reference/augment.clm.md),
[`glance.clm()`](https://broom.tidymodels.org/dev/reference/glance.clm.md),
[`glance.clmm()`](https://broom.tidymodels.org/dev/reference/glance.clmm.md),
[`glance.polr()`](https://broom.tidymodels.org/dev/reference/glance.polr.md),
[`glance.svyolr()`](https://broom.tidymodels.org/dev/reference/glance.svyolr.md),
[`tidy.clm()`](https://broom.tidymodels.org/dev/reference/tidy.clm.md),
[`tidy.clmm()`](https://broom.tidymodels.org/dev/reference/tidy.clmm.md),
[`tidy.polr()`](https://broom.tidymodels.org/dev/reference/tidy.polr.md),
[`tidy.svyolr()`](https://broom.tidymodels.org/dev/reference/tidy.svyolr.md)

## Examples

``` r
# load libraries for models and data
library(MASS)

# fit model
fit <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)

# summarize model fit with tidiers
tidy(fit, exponentiate = TRUE, conf.int = TRUE)
#> 
#> Re-fitting to get Hessian
#> # A tibble: 8 × 7
#>   term        estimate std.error statistic conf.low conf.high coef.type
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>     <dbl> <chr>    
#> 1 InflMedium     1.76     0.105       5.41    1.44      2.16  coeffici…
#> 2 InflHigh       3.63     0.127      10.1     2.83      4.66  coeffici…
#> 3 TypeApartm…    0.564    0.119      -4.80    0.446     0.712 coeffici…
#> 4 TypeAtrium     0.693    0.155      -2.36    0.511     0.940 coeffici…
#> 5 TypeTerrace    0.336    0.151      -7.20    0.249     0.451 coeffici…
#> 6 ContHigh       1.43     0.0955      3.77    1.19      1.73  coeffici…
#> 7 Low|Medium     0.609    0.125      -3.97   NA        NA     scale    
#> 8 Medium|High    2.00     0.125       5.50   NA        NA     scale    

glance(fit)
#> # A tibble: 1 × 7
#>     edf logLik   AIC   BIC deviance df.residual  nobs
#>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1     8 -1740. 3495. 3539.    3479.        1673  1681
augment(fit, type.predict = "class")
#> # A tibble: 72 × 6
#>    Sat    Infl   Type      Cont  `(weights)` .fitted
#>    <ord>  <fct>  <fct>     <fct>       <int> <fct>  
#>  1 Low    Low    Tower     Low            21 Low    
#>  2 Medium Low    Tower     Low            21 Low    
#>  3 High   Low    Tower     Low            28 Low    
#>  4 Low    Medium Tower     Low            34 High   
#>  5 Medium Medium Tower     Low            22 High   
#>  6 High   Medium Tower     Low            36 High   
#>  7 Low    High   Tower     Low            10 High   
#>  8 Medium High   Tower     Low            11 High   
#>  9 High   High   Tower     Low            36 High   
#> 10 Low    Low    Apartment Low            61 Low    
#> # ℹ 62 more rows

fit2 <- polr(factor(gear) ~ am + mpg + qsec, data = mtcars)

tidy(fit, p.values = TRUE)
#> 
#> Re-fitting to get Hessian
#> p-values can presently only be returned for models that contain no
#> categorical variables with more than two levels.
#> # A tibble: 8 × 6
#>   term          estimate std.error statistic p.value coef.type  
#>   <chr>            <dbl>     <dbl>     <dbl> <lgl>   <chr>      
#> 1 InflMedium       0.566    0.105       5.41 NA      coefficient
#> 2 InflHigh         1.29     0.127      10.1  NA      coefficient
#> 3 TypeApartment   -0.572    0.119      -4.80 NA      coefficient
#> 4 TypeAtrium      -0.366    0.155      -2.36 NA      coefficient
#> 5 TypeTerrace     -1.09     0.151      -7.20 NA      coefficient
#> 6 ContHigh         0.360    0.0955      3.77 NA      coefficient
#> 7 Low|Medium      -0.496    0.125      -3.97 NA      scale      
#> 8 Medium|High      0.691    0.125       5.50 NA      scale      
```
