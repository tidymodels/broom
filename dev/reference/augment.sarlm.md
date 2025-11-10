# Augment data with information from a(n) spatialreg object

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
# S3 method for class 'sarlm'
augment(x, data = x$X, ...)
```

## Arguments

- x:

  An object returned from
  [`spatialreg::lagsarlm()`](https://r-spatial.github.io/spatialreg/reference/ML_models.html)
  or
  [`spatialreg::errorsarlm()`](https://r-spatial.github.io/spatialreg/reference/ML_models.html).

- data:

  Ignored, but included for internal consistency. See the details below.

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

The predict method for sarlm objects assumes that the response is known.
See ?predict.sarlm for more discussion. As a result, since the original
data can be recovered from the fit object, this method currently does
not take in `data` or `newdata` arguments.

## See also

[`augment()`](https://generics.r-lib.org/reference/augment.html)

Other spatialreg tidiers:
[`glance.sarlm()`](https://broom.tidymodels.org/dev/reference/glance.sarlm.md),
[`tidy.sarlm()`](https://broom.tidymodels.org/dev/reference/tidy.sarlm.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .fitted:

  Fitted or predicted value.

- .resid:

  The difference between observed and fitted values.

## Examples

``` r

# load libraries for models and data
library(spatialreg)
#> Loading required package: spData
#> To access larger datasets in this package, install the
#> spDataLarge package with: `install.packages('spDataLarge',
#> repos='https://nowosad.github.io/drat/', type='source')`
#> Loading required package: sf
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE
library(spdep)
#> 
#> Attaching package: ‘spdep’
#> The following objects are masked from ‘package:spatialreg’:
#> 
#>     get.ClusterOption, get.VerboseOption,
#>     get.ZeroPolicyOption, get.coresOption, get.mcOption,
#>     set.ClusterOption, set.VerboseOption,
#>     set.ZeroPolicyOption, set.coresOption, set.mcOption

# load data
data(oldcol, package = "spdep")

listw <- nb2listw(COL.nb, style = "W")

# fit model
crime_sar <-
  lagsarlm(CRIME ~ INC + HOVAL,
    data = COL.OLD,
    listw = listw,
    method = "eigen"
  )

# summarize model fit with tidiers
tidy(crime_sar)
#> # A tibble: 4 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 rho            0.431    0.118       3.66 2.50e- 4
#> 2 (Intercept)   45.1      7.18        6.28 3.37e-10
#> 3 INC           -1.03     0.305      -3.38 7.23e- 4
#> 4 HOVAL         -0.266    0.0885     -3.00 2.66e- 3
tidy(crime_sar, conf.int = TRUE)
#> # A tibble: 4 × 7
#>   term        estimate std.error statistic  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 rho            0.431    0.118       3.66 2.50e- 4    0.200    0.662 
#> 2 (Intercept)   45.1      7.18        6.28 3.37e-10   31.0     59.1   
#> 3 INC           -1.03     0.305      -3.38 7.23e- 4   -1.63    -0.434 
#> 4 HOVAL         -0.266    0.0885     -3.00 2.66e- 3   -0.439   -0.0925
glance(crime_sar)
#> # A tibble: 1 × 6
#>   r.squared   AIC   BIC deviance logLik  nobs
#>       <dbl> <dbl> <dbl>    <dbl>  <dbl> <int>
#> 1     0.652  375.  384.    4679.  -182.    49
augment(crime_sar)
#> # A tibble: 49 × 6
#>    `(Intercept)`   INC HOVAL  CRIME .fitted .resid
#>            <dbl> <dbl> <dbl>  <dbl>   <dbl>  <dbl>
#>  1             1 21.2   44.6 18.8      22.6  -3.84
#>  2             1  4.48  33.2 32.4      46.6 -14.2 
#>  3             1 11.3   37.1 38.4      41.4  -2.97
#>  4             1  8.44  75    0.178    37.9 -37.7 
#>  5             1 19.5   80.5 15.7      14.2   1.54
#>  6             1 16.0   26.4 30.6      34.3  -3.66
#>  7             1 11.3   23.2 50.7      44.7   5.99
#>  8             1 16.0   28.8 26.1      38.4 -12.3 
#>  9             1  9.87  18   48.6      51.7  -3.12
#> 10             1 13.6   96.4 34.0      16.3  17.7 
#> # ℹ 39 more rows

# fit another model
crime_sem <- errorsarlm(CRIME ~ INC + HOVAL, data = COL.OLD, listw)

# summarize model fit with tidiers
tidy(crime_sem)
#> # A tibble: 4 × 5
#>   term        estimate std.error statistic   p.value
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
#> 1 (Intercept)   59.9      5.37       11.2  0        
#> 2 INC           -0.941    0.331      -2.85 0.00441  
#> 3 HOVAL         -0.302    0.0905     -3.34 0.000836 
#> 4 lambda         0.562    0.134       4.20 0.0000271
tidy(crime_sem, conf.int = TRUE)
#> # A tibble: 4 × 7
#>   term        estimate std.error statistic   p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
#> 1 (Intercept)   59.9      5.37       11.2  0           49.4      70.4  
#> 2 INC           -0.941    0.331      -2.85 0.00441     -1.59     -0.293
#> 3 HOVAL         -0.302    0.0905     -3.34 0.000836    -0.480    -0.125
#> 4 lambda         0.562    0.134       4.20 0.0000271    0.299     0.824
glance(crime_sem)
#> # A tibble: 1 × 6
#>   r.squared   AIC   BIC deviance logLik  nobs
#>       <dbl> <dbl> <dbl>    <dbl>  <dbl> <int>
#> 1     0.658  377.  386.    4683.  -183.    49
augment(crime_sem)
#> # A tibble: 49 × 6
#>    `(Intercept)`   INC HOVAL  CRIME .fitted  .resid
#>            <dbl> <dbl> <dbl>  <dbl>   <dbl>   <dbl>
#>  1             1 21.2   44.6 18.8      22.5  -3.70 
#>  2             1  4.48  33.2 32.4      44.9 -12.5  
#>  3             1 11.3   37.1 38.4      38.2   0.223
#>  4             1  8.44  75    0.178    35.0 -34.8  
#>  5             1 19.5   80.5 15.7      13.3   2.45 
#>  6             1 16.0   26.4 30.6      35.0  -4.33 
#>  7             1 11.3   23.2 50.7      42.3   8.41 
#>  8             1 16.0   28.8 26.1      39.4 -13.3  
#>  9             1  9.87  18   48.6      49.3  -0.721
#> 10             1 13.6   96.4 34.0      16.6  17.4  
#> # ℹ 39 more rows

# fit another model
crime_sac <- sacsarlm(CRIME ~ INC + HOVAL, data = COL.OLD, listw)

# summarize model fit with tidiers
tidy(crime_sac)
#> # A tibble: 5 × 5
#>   term        estimate std.error statistic    p.value
#>   <chr>          <dbl>     <dbl>     <dbl>      <dbl>
#> 1 rho            0.368    0.197      1.87  0.0613    
#> 2 (Intercept)   47.8      9.90       4.83  0.00000140
#> 3 INC           -1.03     0.326     -3.14  0.00167   
#> 4 HOVAL         -0.282    0.0900    -3.13  0.00176   
#> 5 lambda         0.167    0.297      0.562 0.574     
tidy(crime_sac, conf.int = TRUE)
#> # A tibble: 5 × 7
#>   term        estimate std.error statistic   p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
#> 1 rho            0.368    0.197      1.87    6.13e-2  -0.0174     0.754
#> 2 (Intercept)   47.8      9.90       4.83    1.40e-6  28.4       67.2  
#> 3 INC           -1.03     0.326     -3.14    1.67e-3  -1.67      -0.386
#> 4 HOVAL         -0.282    0.0900    -3.13    1.76e-3  -0.458     -0.105
#> 5 lambda         0.167    0.297      0.562   5.74e-1  -0.415      0.748
glance(crime_sac)
#> # A tibble: 1 × 6
#>   r.squared   AIC   BIC deviance logLik  nobs
#>       <dbl> <dbl> <dbl>    <dbl>  <dbl> <int>
#> 1     0.652  376.  388.    4685.  -182.    49
augment(crime_sac)
#> # A tibble: 49 × 6
#>    `(Intercept)`   INC HOVAL  CRIME .fitted .resid
#>            <dbl> <dbl> <dbl>  <dbl>   <dbl>  <dbl>
#>  1             1 21.2   44.6 18.8      22.2  -3.37
#>  2             1  4.48  33.2 32.4      46.4 -14.0 
#>  3             1 11.3   37.1 38.4      40.4  -2.00
#>  4             1  8.44  75    0.178    37.5 -37.3 
#>  5             1 19.5   80.5 15.7      13.5   2.25
#>  6             1 16.0   26.4 30.6      34.4  -3.74
#>  7             1 11.3   23.2 50.7      44.1   6.60
#>  8             1 16.0   28.8 26.1      39.0 -12.9 
#>  9             1  9.87  18   48.6      51.5  -2.93
#> 10             1 13.6   96.4 34.0      15.8  18.2 
#> # ℹ 39 more rows
```
