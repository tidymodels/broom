# Tidy a(n) margins object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'margins'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `margins` object returned from
  [`margins::margins()`](https://rdrr.io/pkg/margins/man/margins.html).

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

The `margins` package provides a way to obtain coefficient marginal
effects for a variety of (non-linear) models, such as logit or models
with multiway interaction terms. Note that the
[`glance.margins()`](https://broom.tidymodels.org/dev/reference/glance.margins.md)
method requires rerunning the underlying model again, which can take
some time. Similarly, an `augment.margins()` method is not currently
supported, but users can simply run the underlying model to obtain the
same information.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`margins::margins()`](https://rdrr.io/pkg/margins/man/margins.html)

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
library(margins)

# example 1: logit model
mod_log <- glm(am ~ cyl + hp + wt, data = mtcars, family = binomial)

# get tidied "naive" model coefficients
tidy(mod_log)
#> # A tibble: 4 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)  19.7       8.12       2.43   0.0152
#> 2 cyl           0.488     1.07       0.455  0.649 
#> 3 hp            0.0326    0.0189     1.73   0.0840
#> 4 wt           -9.15      4.15      -2.20   0.0276

# convert to marginal effects with margins()
marg_log <- margins(mod_log)

# get tidied marginal effects
tidy(marg_log)
#> # A tibble: 3 × 5
#>   term  estimate std.error statistic  p.value
#>   <chr>    <dbl>     <dbl>     <dbl>    <dbl>
#> 1 cyl    0.0215   0.0470       0.457 0.648   
#> 2 hp     0.00143  0.000618     2.32  0.0204  
#> 3 wt    -0.403    0.115       -3.49  0.000487
tidy(marg_log, conf.int = TRUE)
#> # A tibble: 3 × 7
#>   term  estimate std.error statistic  p.value  conf.low conf.high
#>   <chr>    <dbl>     <dbl>     <dbl>    <dbl>     <dbl>     <dbl>
#> 1 cyl    0.0215   0.0470       0.457 0.648    -0.0706     0.114  
#> 2 hp     0.00143  0.000618     2.32  0.0204    0.000222   0.00265
#> 3 wt    -0.403    0.115       -3.49  0.000487 -0.629     -0.176  

# requires running the underlying model again. quick for this example
glance(marg_log)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          43.2      31  -4.92  17.8  23.7     9.84          28    32

# augmenting `margins` outputs isn't supported, but
# you can get the same info by running on the underlying model
augment(mod_log)
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

# example 2: threeway interaction terms
mod_ie <- lm(mpg ~ wt * cyl * disp, data = mtcars)

# get tidied "naive" model coefficients
tidy(mod_ie)
#> # A tibble: 8 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept) 108.      23.3          4.62 0.000109
#> 2 wt          -24.8      8.47        -2.92 0.00744 
#> 3 cyl         -10.8      4.34        -2.49 0.0201  
#> 4 disp         -0.593    0.213       -2.79 0.0102  
#> 5 wt:cyl        2.91     1.42         2.05 0.0514  
#> 6 wt:disp       0.184    0.0685       2.69 0.0127  
#> 7 cyl:disp      0.0752   0.0268       2.81 0.00979 
#> 8 wt:cyl:disp  -0.0233   0.00861     -2.71 0.0123  

# convert to marginal effects with margins()
marg_ie0 <- margins(mod_ie)
# get tidied marginal effects
tidy(marg_ie0)
#> # A tibble: 3 × 5
#>   term  estimate std.error statistic p.value
#>   <chr>    <dbl>     <dbl>     <dbl>   <dbl>
#> 1 cyl    -3.85      1.46       -2.65 0.00812
#> 2 disp   -0.0295    0.0174     -1.70 0.0900 
#> 3 wt     -2.01      1.17       -1.72 0.0859 
glance(marg_ie0)
#> # A tibble: 1 × 12
#>   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl>
#> 1     0.896         0.865  2.21      29.4 2.75e-10     7  -66.2  150.
#> # ℹ 4 more variables: BIC <dbl>, deviance <dbl>, df.residual <int>,
#> #   nobs <int>

# marginal effects evaluated at specific values of a variable (here: cyl)
marg_ie1 <- margins(mod_ie, at = list(cyl = c(4,6,8)))

# summarize model fit with tidiers
tidy(marg_ie1)
#> # A tibble: 9 × 7
#>   term  at.variable at.value  estimate std.error statistic p.value
#>   <chr> <chr>          <dbl>     <dbl>     <dbl>     <dbl>   <dbl>
#> 1 cyl   cyl                4 -3.85        1.46     -2.65   0.00812
#> 2 cyl   cyl                6 -3.85        1.46     -2.65   0.00811
#> 3 cyl   cyl                8 -3.85        1.46     -2.65   0.00812
#> 4 disp  cyl                4  0.000978    0.0314    0.0312 0.975  
#> 5 disp  cyl                6  0.00134     0.0182    0.0737 0.941  
#> 6 disp  cyl                8  0.00170     0.0120    0.141  0.888  
#> 7 wt    cyl                4  7.91        5.06      1.56   0.118  
#> 8 wt    cyl                6  2.96        2.52      1.18   0.239  
#> 9 wt    cyl                8 -1.98        2.40     -0.825  0.409  

# marginal effects of one interaction variable (here: wt), modulated at
# specific values of the two other interaction variables (here: cyl and drat)
marg_ie2 <- margins(mod_ie,
                    variables = "wt",
                    at = list(cyl = c(4,6,8), drat = c(3, 3.5, 4)))

# summarize model fit with tidiers
tidy(marg_ie2)
#> # A tibble: 18 × 7
#>    term  at.variable at.value estimate std.error statistic p.value
#>    <chr> <chr>          <dbl>    <dbl>     <dbl>     <dbl>   <dbl>
#>  1 wt    cyl              4       7.91      5.06     1.56    0.118
#>  2 wt    drat             3       7.91      5.06     1.56    0.118
#>  3 wt    cyl              4       7.91      5.06     1.56    0.118
#>  4 wt    drat             3.5     7.91      5.06     1.56    0.118
#>  5 wt    cyl              4       7.91      5.06     1.56    0.118
#>  6 wt    drat             4       7.91      5.06     1.56    0.118
#>  7 wt    cyl              6       2.96      2.52     1.18    0.239
#>  8 wt    drat             3       2.96      2.52     1.18    0.239
#>  9 wt    cyl              6       2.96      2.52     1.18    0.239
#> 10 wt    drat             3.5     2.96      2.52     1.18    0.239
#> 11 wt    cyl              6       2.96      2.52     1.18    0.239
#> 12 wt    drat             4       2.96      2.52     1.18    0.239
#> 13 wt    cyl              8      -1.98      2.40    -0.825   0.409
#> 14 wt    drat             3      -1.98      2.40    -0.825   0.409
#> 15 wt    cyl              8      -1.98      2.40    -0.825   0.409
#> 16 wt    drat             3.5    -1.98      2.40    -0.825   0.409
#> 17 wt    cyl              8      -1.98      2.40    -0.825   0.409
#> 18 wt    drat             4      -1.98      2.40    -0.825   0.409
```
