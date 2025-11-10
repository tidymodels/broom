# Augment data with information from a(n) clm object

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
# S3 method for class 'clm'
augment(
  x,
  data = model.frame(x),
  newdata = NULL,
  type.predict = c("prob", "class"),
  ...
)
```

## Arguments

- x:

  A `clm` object returned from
  [`ordinal::clm()`](https://rdrr.io/pkg/ordinal/man/clm.html).

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

  Which type of prediction to compute, either `"prob"` or `"class"`,
  passed to
  [`ordinal::predict.clm()`](https://rdrr.io/pkg/ordinal/man/predict.html).
  Defaults to `"prob"`.

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

[tidy](https://generics.r-lib.org/reference/tidy.html),
[`ordinal::clm()`](https://rdrr.io/pkg/ordinal/man/clm.html),
[`ordinal::predict.clm()`](https://rdrr.io/pkg/ordinal/man/predict.html)

Other ordinal tidiers:
[`augment.polr()`](https://broom.tidymodels.org/dev/reference/augment.polr.md),
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
library(ordinal)
#> 
#> Attaching package: ‘ordinal’
#> The following object is masked from ‘package:dplyr’:
#> 
#>     slice

# fit model
fit <- clm(rating ~ temp * contact, data = wine)

# summarize model fit with tidiers
tidy(fit)
#> # A tibble: 7 × 6
#>   term                estimate std.error statistic  p.value coef.type
#>   <chr>                  <dbl>     <dbl>     <dbl>    <dbl> <chr>    
#> 1 1|2                   -1.41      0.545    -2.59  9.66e- 3 intercept
#> 2 2|3                    1.14      0.510     2.24  2.48e- 2 intercept
#> 3 3|4                    3.38      0.638     5.29  1.21e- 7 intercept
#> 4 4|5                    4.94      0.751     6.58  4.66e-11 intercept
#> 5 tempwarm               2.32      0.701     3.31  9.28e- 4 location 
#> 6 contactyes             1.35      0.660     2.04  4.13e- 2 location 
#> 7 tempwarm:contactyes    0.360     0.924     0.389 6.97e- 1 location 
tidy(fit, conf.int = TRUE, conf.level = 0.9)
#> # A tibble: 7 × 8
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 1|2            -1.41      0.545    -2.59  9.66e- 3   NA         NA   
#> 2 2|3             1.14      0.510     2.24  2.48e- 2   NA         NA   
#> 3 3|4             3.38      0.638     5.29  1.21e- 7   NA         NA   
#> 4 4|5             4.94      0.751     6.58  4.66e-11   NA         NA   
#> 5 tempwarm        2.32      0.701     3.31  9.28e- 4    1.20       3.52
#> 6 contactyes      1.35      0.660     2.04  4.13e- 2    0.284      2.47
#> 7 tempwarm:co…    0.360     0.924     0.389 6.97e- 1   -1.17       1.89
#> # ℹ 1 more variable: coef.type <chr>
tidy(fit, conf.int = TRUE, conf.type = "Wald", exponentiate = TRUE)
#> # A tibble: 7 × 8
#>   term         estimate std.error statistic  p.value conf.low conf.high
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 1|2             0.244     0.545    -2.59  9.66e- 3   0.0837     0.710
#> 2 2|3             3.14      0.510     2.24  2.48e- 2   1.16       8.52 
#> 3 3|4            29.3       0.638     5.29  1.21e- 7   8.38     102.   
#> 4 4|5           140.        0.751     6.58  4.66e-11  32.1      610.   
#> 5 tempwarm       10.2       0.701     3.31  9.28e- 4   2.58      40.2  
#> 6 contactyes      3.85      0.660     2.04  4.13e- 2   1.05      14.0  
#> 7 tempwarm:co…    1.43      0.924     0.389 6.97e- 1   0.234      8.76 
#> # ℹ 1 more variable: coef.type <chr>

glance(fit)
#> # A tibble: 1 × 6
#>     edf   AIC   BIC logLik   df.residual  nobs
#>   <int> <dbl> <dbl> <logLik>       <dbl> <dbl>
#> 1     7  187.  203. -86.4162          65    72
augment(fit, type.predict = "prob")
#> # A tibble: 72 × 4
#>    rating temp  contact .fitted
#>    <ord>  <fct> <fct>     <dbl>
#>  1 2      cold  no       0.562 
#>  2 3      cold  no       0.209 
#>  3 3      cold  yes      0.435 
#>  4 4      cold  yes      0.0894
#>  5 4      warm  no       0.190 
#>  6 4      warm  no       0.190 
#>  7 5      warm  yes      0.286 
#>  8 5      warm  yes      0.286 
#>  9 1      cold  no       0.196 
#> 10 2      cold  no       0.562 
#> # ℹ 62 more rows
augment(fit, type.predict = "class")
#> # A tibble: 72 × 4
#>    rating temp  contact .fitted
#>    <ord>  <fct> <fct>   <fct>  
#>  1 2      cold  no      2      
#>  2 3      cold  no      2      
#>  3 3      cold  yes     3      
#>  4 4      cold  yes     3      
#>  5 4      warm  no      3      
#>  6 4      warm  no      3      
#>  7 5      warm  yes     4      
#>  8 5      warm  yes     4      
#>  9 1      cold  no      2      
#> 10 2      cold  no      2      
#> # ℹ 62 more rows

# ...and again with another model specification
fit2 <- clm(rating ~ temp, nominal = ~contact, data = wine)

tidy(fit2)
#> # A tibble: 9 × 6
#>   term            estimate std.error statistic      p.value coef.type
#>   <chr>              <dbl>     <dbl>     <dbl>        <dbl> <chr>    
#> 1 1|2.(Intercept)    -1.32     0.562     -2.35 0.0186       intercept
#> 2 2|3.(Intercept)     1.25     0.475      2.63 0.00866      intercept
#> 3 3|4.(Intercept)     3.55     0.656      5.41 0.0000000625 intercept
#> 4 4|5.(Intercept)     4.66     0.860      5.42 0.0000000608 intercept
#> 5 1|2.contactyes     -1.62     1.16      -1.39 0.164        intercept
#> 6 2|3.contactyes     -1.51     0.591     -2.56 0.0105       intercept
#> 7 3|4.contactyes     -1.67     0.649     -2.58 0.00985      intercept
#> 8 4|5.contactyes     -1.05     0.897     -1.17 0.241        intercept
#> 9 tempwarm            2.52     0.535      4.71 0.00000250   location 
glance(fit2)
#> # A tibble: 1 × 6
#>     edf   AIC   BIC logLik    df.residual  nobs
#>   <int> <dbl> <dbl> <logLik>        <dbl> <dbl>
#> 1     9  190.  211. -86.20855          63    72
```
