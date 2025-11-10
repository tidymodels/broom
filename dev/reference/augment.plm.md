# Augment data with information from a(n) plm object

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
# S3 method for class 'plm'
augment(x, data = model.frame(x), ...)
```

## Arguments

- x:

  A `plm` objected returned by
  [`plm::plm()`](https://rdrr.io/pkg/plm/man/plm.html).

- data:

  A [base::data.frame](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing the original data that was used to produce the object `x`.
  Defaults to `stats::model.frame(x)` so that `augment(my_fit)` returns
  the augmented original data. **Do not** pass new data to the `data`
  argument. Augment will report information such as influence and cooks
  distance for data passed to the `data` argument. These measures are
  only defined for the original training data.

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

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`plm::plm()`](https://rdrr.io/pkg/plm/man/plm.html)

Other plm tidiers:
[`glance.plm()`](https://broom.tidymodels.org/dev/reference/glance.plm.md),
[`tidy.plm()`](https://broom.tidymodels.org/dev/reference/tidy.plm.md)

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
library(plm)
#> 
#> Attaching package: ‘plm’
#> The following object is masked from ‘package:mlogit’:
#> 
#>     has.intercept
#> The following object is masked from ‘package:lfe’:
#> 
#>     sargan
#> The following objects are masked from ‘package:dplyr’:
#> 
#>     between, lag, lead

# load data
data("Produc", package = "plm")

# fit model
zz <- plm(log(gsp) ~ log(pcap) + log(pc) + log(emp) + unemp,
  data = Produc, index = c("state", "year")
)

# summarize model fit with tidiers
summary(zz)
#> Oneway (individual) effect Within Model
#> 
#> Call:
#> plm(formula = log(gsp) ~ log(pcap) + log(pc) + log(emp) + unemp, 
#>     data = Produc, index = c("state", "year"))
#> 
#> Balanced Panel: n = 48, T = 17, N = 816
#> 
#> Residuals:
#>      Min.   1st Qu.    Median   3rd Qu.      Max. 
#> -0.120456 -0.023741 -0.002041  0.018144  0.174718 
#> 
#> Coefficients:
#>              Estimate  Std. Error t-value  Pr(>|t|)    
#> log(pcap) -0.02614965  0.02900158 -0.9017    0.3675    
#> log(pc)    0.29200693  0.02511967 11.6246 < 2.2e-16 ***
#> log(emp)   0.76815947  0.03009174 25.5273 < 2.2e-16 ***
#> unemp     -0.00529774  0.00098873 -5.3582 1.114e-07 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Total Sum of Squares:    18.941
#> Residual Sum of Squares: 1.1112
#> R-Squared:      0.94134
#> Adj. R-Squared: 0.93742
#> F-statistic: 3064.81 on 4 and 764 DF, p-value: < 2.22e-16

tidy(zz)
#> # A tibble: 4 × 5
#>   term      estimate std.error statistic   p.value
#>   <chr>        <dbl>     <dbl>     <dbl>     <dbl>
#> 1 log(pcap) -0.0261   0.0290      -0.902 3.68e-  1
#> 2 log(pc)    0.292    0.0251      11.6   7.08e- 29
#> 3 log(emp)   0.768    0.0301      25.5   2.02e-104
#> 4 unemp     -0.00530  0.000989    -5.36  1.11e-  7
tidy(zz, conf.int = TRUE)
#> # A tibble: 4 × 7
#>   term      estimate std.error statistic   p.value conf.low conf.high
#>   <chr>        <dbl>     <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
#> 1 log(pcap) -0.0261   0.0290      -0.902 3.68e-  1 -0.0830    0.0307 
#> 2 log(pc)    0.292    0.0251      11.6   7.08e- 29  0.243     0.341  
#> 3 log(emp)   0.768    0.0301      25.5   2.02e-104  0.709     0.827  
#> 4 unemp     -0.00530  0.000989    -5.36  1.11e-  7 -0.00724  -0.00336
tidy(zz, conf.int = TRUE, conf.level = 0.9)
#> # A tibble: 4 × 7
#>   term      estimate std.error statistic   p.value conf.low conf.high
#>   <chr>        <dbl>     <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
#> 1 log(pcap) -0.0261   0.0290      -0.902 3.68e-  1 -0.0739    0.0216 
#> 2 log(pc)    0.292    0.0251      11.6   7.08e- 29  0.251     0.333  
#> 3 log(emp)   0.768    0.0301      25.5   2.02e-104  0.719     0.818  
#> 4 unemp     -0.00530  0.000989    -5.36  1.11e-  7 -0.00692  -0.00367

augment(zz)
#> # A tibble: 816 × 7
#>    log.gsp.  log.pcap. log.pc.   log.emp.  unemp   .fitted .resid      
#>    <pseries> <pseries> <pseries> <pseries> <pseri>   <dbl> <pseries>   
#>  1 10.25478  9.617981  10.48553  6.918201  4.7        10.3 -0.046561413
#>  2 10.28790  9.648720  10.52675  6.929419  5.2        10.3 -0.030640422
#>  3 10.35147  9.678618  10.56283  6.977561  4.7        10.4 -0.016454312
#>  4 10.41721  9.705418  10.59873  7.034828  3.9        10.4 -0.008726974
#>  5 10.42671  9.726910  10.64679  7.064588  5.5        10.5 -0.027084312
#>  6 10.42240  9.759401  10.69130  7.052202  7.7        10.4 -0.022368930
#>  7 10.48470  9.783175  10.82420  7.095893  6.8        10.5 -0.036587629
#>  8 10.53111  9.804326  10.84125  7.146142  7.4        10.6 -0.030020604
#>  9 10.59573  9.824430  10.87055  7.197810  6.3        10.6 -0.018942497
#> 10 10.62082  9.845937  10.90643  7.216709  7.1        10.6 -0.014057170
#> # ℹ 806 more rows
glance(zz)
#> # A tibble: 1 × 7
#>   r.squared adj.r.squared statistic p.value deviance df.residual  nobs
#>       <dbl>         <dbl>     <dbl>   <dbl>    <dbl>       <int> <int>
#> 1     0.941         0.937     3065.       0     1.11         764   816
```
