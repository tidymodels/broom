# Tidy a(n) plm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'plm'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `plm` objected returned by
  [`plm::plm()`](https://rdrr.io/pkg/plm/man/plm.html).

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

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`plm::plm()`](https://rdrr.io/pkg/plm/man/plm.html),
[`tidy.lm()`](https://broom.tidymodels.org/dev/reference/tidy.lm.md)

Other plm tidiers:
[`augment.plm()`](https://broom.tidymodels.org/dev/reference/augment.plm.md),
[`glance.plm()`](https://broom.tidymodels.org/dev/reference/glance.plm.md)

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
library(plm)

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
