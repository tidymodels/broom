# Augment data with information from a(n) felm object

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
# S3 method for class 'felm'
augment(x, data = model.frame(x), ...)
```

## Arguments

- x:

  A `felm` object returned from
  [`lfe::felm()`](https://rdrr.io/pkg/lfe/man/felm.html).

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
[`lfe::felm()`](https://rdrr.io/pkg/lfe/man/felm.html)

Other felm tidiers:
[`tidy.felm()`](https://broom.tidymodels.org/dev/reference/tidy.felm.md)

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
library(lfe)
#> Loading required package: Matrix
#> 
#> Attaching package: ‘Matrix’
#> The following objects are masked from ‘package:tidyr’:
#> 
#>     expand, pack, unpack
#> 
#> Attaching package: ‘lfe’
#> The following object is masked from ‘package:lmtest’:
#> 
#>     waldtest

# use built-in `airquality` dataset
head(airquality)
#>   Ozone Solar.R Wind Temp Month Day
#> 1    41     190  7.4   67     5   1
#> 2    36     118  8.0   72     5   2
#> 3    12     149 12.6   74     5   3
#> 4    18     313 11.5   62     5   4
#> 5    NA      NA 14.3   56     5   5
#> 6    28      NA 14.9   66     5   6

# no FEs; same as lm()
est0 <- felm(Ozone ~ Temp + Wind + Solar.R, airquality)

# summarize model fit with tidiers
tidy(est0)
#> # A tibble: 4 × 5
#>   term        estimate std.error statistic       p.value
#>   <chr>          <dbl>     <dbl>     <dbl>         <dbl>
#> 1 (Intercept) -64.3      23.1        -2.79 0.00623      
#> 2 Temp          1.65      0.254       6.52 0.00000000242
#> 3 Wind         -3.33      0.654      -5.09 0.00000152   
#> 4 Solar.R       0.0598    0.0232      2.58 0.0112       
augment(est0)
#> # A tibble: 111 × 7
#>    .rownames Ozone  Temp  Wind Solar.R .fitted  .resid
#>    <chr>     <int> <int> <dbl>   <int>   <dbl>   <dbl>
#>  1 1            41    67   7.4     190   33.0    7.95 
#>  2 2            36    72   8       118   35.0    1.00 
#>  3 3            12    74  12.6     149   24.8  -12.8  
#>  4 4            18    62  11.5     313   18.5   -0.475
#>  5 7            23    65   8.6     299   32.3   -9.26 
#>  6 8            19    59  13.8      99   -6.95  25.9  
#>  7 9             8    61  20.1      19  -29.4   37.4  
#>  8 12           16    69   9.7     256   32.6  -16.6  
#>  9 13           11    66   9.2     290   31.4  -20.4  
#> 10 14           14    68  10.9     274   28.1  -14.1  
#> # ℹ 101 more rows

# add month fixed effects
est1 <- felm(Ozone ~ Temp + Wind + Solar.R | Month, airquality)

# summarize model fit with tidiers
tidy(est1)
#> # A tibble: 3 × 5
#>   term    estimate std.error statistic     p.value
#>   <chr>      <dbl>     <dbl>     <dbl>       <dbl>
#> 1 Temp      1.88      0.341       5.50 0.000000274
#> 2 Wind     -3.11      0.660      -4.71 0.00000778 
#> 3 Solar.R   0.0522    0.0237      2.21 0.0296     
tidy(est1, fe = TRUE)
#> # A tibble: 8 × 7
#>   term    estimate std.error statistic     p.value     N  comp
#>   <chr>      <dbl>     <dbl>     <dbl>       <dbl> <int> <dbl>
#> 1 Temp      1.88      0.341       5.50 0.000000274    NA    NA
#> 2 Wind     -3.11      0.660      -4.71 0.00000778     NA    NA
#> 3 Solar.R   0.0522    0.0237      2.21 0.0296         NA    NA
#> 4 Month.5 -74.2       4.23      -17.5  2.00           24     1
#> 5 Month.6 -89.0       6.91      -12.9  2.00            9     1
#> 6 Month.7 -83.0       4.06      -20.4  2              26     1
#> 7 Month.8 -78.4       4.32      -18.2  2.00           23     1
#> 8 Month.9 -90.2       3.85      -23.4  2              29     1
augment(est1)
#> # A tibble: 111 × 8
#>    .rownames Ozone  Temp  Wind Solar.R Month .fitted .resid
#>    <chr>     <int> <int> <dbl>   <int> <int>   <dbl>  <dbl>
#>  1 1            41    67   7.4     190     5   38.3    2.69
#>  2 2            36    72   8       118     5   42.1   -6.07
#>  3 3            12    74  12.6     149     5   33.1  -21.1 
#>  4 4            18    62  11.5     313     5   22.6   -4.62
#>  5 7            23    65   8.6     299     5   36.5  -13.5 
#>  6 8            19    59  13.8      99     5   -1.33  20.3 
#>  7 9             8    61  20.1      19     5  -21.3   29.3 
#>  8 12           16    69   9.7     256     5   38.4  -22.4 
#>  9 13           11    66   9.2     290     5   36.1  -25.1 
#> 10 14           14    68  10.9     274     5   33.7  -19.7 
#> # ℹ 101 more rows
glance(est1)
#> # A tibble: 1 × 8
#>   r.squared adj.r.squared sigma statistic  p.value    df df.residual
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>       <dbl>
#> 1     0.637         0.612  20.7      25.8 4.57e-20   103         103
#> # ℹ 1 more variable: nobs <int>

# the "se.type" argument can be used to switch out different standard errors
# types on the fly. In turn, this can be useful exploring the effect of
# different error structures on model inference.
tidy(est1, se.type = "iid")
#> # A tibble: 3 × 5
#>   term    estimate std.error statistic     p.value
#>   <chr>      <dbl>     <dbl>     <dbl>       <dbl>
#> 1 Temp      1.88      0.341       5.50 0.000000274
#> 2 Wind     -3.11      0.660      -4.71 0.00000778 
#> 3 Solar.R   0.0522    0.0237      2.21 0.0296     
tidy(est1, se.type = "robust")
#> # A tibble: 3 × 5
#>   term    estimate std.error statistic     p.value
#>   <chr>      <dbl>     <dbl>     <dbl>       <dbl>
#> 1 Temp      1.88      0.344       5.45 0.000000344
#> 2 Wind     -3.11      0.903      -3.44 0.000834   
#> 3 Solar.R   0.0522    0.0226      2.31 0.0227     

# add clustered SEs (also by month)
est2 <- felm(Ozone ~ Temp + Wind + Solar.R | Month | 0 | Month, airquality)

# summarize model fit with tidiers
tidy(est2, conf.int = TRUE)
#> # A tibble: 3 × 7
#>   term    estimate std.error statistic  p.value conf.low conf.high
#>   <chr>      <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 Temp      1.88      0.182      10.3  0.000497   1.37       2.38 
#> 2 Wind     -3.11      1.31       -2.38 0.0760    -6.74       0.518
#> 3 Solar.R   0.0522    0.0408      1.28 0.270     -0.0611     0.166
tidy(est2, conf.int = TRUE, se.type = "cluster")
#> # A tibble: 3 × 7
#>   term    estimate std.error statistic  p.value conf.low conf.high
#>   <chr>      <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 Temp      1.88      0.182      10.3  0.000497   1.37       2.38 
#> 2 Wind     -3.11      1.31       -2.38 0.0760    -6.74       0.518
#> 3 Solar.R   0.0522    0.0408      1.28 0.270     -0.0611     0.166
tidy(est2, conf.int = TRUE, se.type = "robust")
#> # A tibble: 3 × 7
#>   term    estimate std.error statistic p.value conf.low conf.high
#>   <chr>      <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 Temp      1.88      0.344       5.45 0.00550   0.920      2.83 
#> 2 Wind     -3.11      0.903      -3.44 0.0262   -5.62      -0.602
#> 3 Solar.R   0.0522    0.0226      2.31 0.0817   -0.0104     0.115
tidy(est2, conf.int = TRUE, se.type = "iid")
#> # A tibble: 3 × 7
#>   term    estimate std.error statistic p.value conf.low conf.high
#>   <chr>      <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 Temp      1.88      0.341       5.50 0.00532   0.929      2.82 
#> 2 Wind     -3.11      0.660      -4.71 0.00924  -4.94      -1.28 
#> 3 Solar.R   0.0522    0.0237      2.21 0.0920   -0.0135     0.118
```
