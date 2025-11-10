# Augment data with information from a(n) htest object

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
# S3 method for class 'htest'
augment(x, ...)
```

## Arguments

- x:

  An `htest` objected, such as those created by
  [`stats::cor.test()`](https://rdrr.io/r/stats/cor.test.html),
  [`stats::t.test()`](https://rdrr.io/r/stats/t.test.html),
  [`stats::wilcox.test()`](https://rdrr.io/r/stats/wilcox.test.html),
  [`stats::chisq.test()`](https://rdrr.io/r/stats/chisq.test.html), etc.

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

See [`stats::chisq.test()`](https://rdrr.io/r/stats/chisq.test.html) for
more details on how residuals are computed.

## See also

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`stats::chisq.test()`](https://rdrr.io/r/stats/chisq.test.html)

Other htest tidiers:
[`tidy.htest()`](https://broom.tidymodels.org/dev/reference/tidy.htest.md),
[`tidy.pairwise.htest()`](https://broom.tidymodels.org/dev/reference/tidy.pairwise.htest.md),
[`tidy.power.htest()`](https://broom.tidymodels.org/dev/reference/tidy.power.htest.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- .observed:

  Observed count.

- .prop:

  Proportion of the total.

- .row.prop:

  Row proportion (2 dimensions table only).

- .col.prop:

  Column proportion (2 dimensions table only).

- .expected:

  Expected count under the null hypothesis.

- .resid:

  Pearson residuals.

- .std.resid:

  Standardized residual.

## Examples

``` r
tt <- t.test(rnorm(10))

tidy(tt)
#> # A tibble: 1 × 8
#>   estimate statistic p.value parameter conf.low conf.high method       
#>      <dbl>     <dbl>   <dbl>     <dbl>    <dbl>     <dbl> <chr>        
#> 1    0.698      2.18  0.0573         9  -0.0269      1.42 One Sample t…
#> # ℹ 1 more variable: alternative <chr>

# the glance output will be the same for each of the below tests
glance(tt)
#> # A tibble: 1 × 8
#>   estimate statistic p.value parameter conf.low conf.high method       
#>      <dbl>     <dbl>   <dbl>     <dbl>    <dbl>     <dbl> <chr>        
#> 1    0.698      2.18  0.0573         9  -0.0269      1.42 One Sample t…
#> # ℹ 1 more variable: alternative <chr>

tt <- t.test(mpg ~ am, data = mtcars)

tidy(tt)
#> # A tibble: 1 × 10
#>   estimate estimate1 estimate2 statistic p.value parameter conf.low
#>      <dbl>     <dbl>     <dbl>     <dbl>   <dbl>     <dbl>    <dbl>
#> 1    -7.24      17.1      24.4     -3.77 0.00137      18.3    -11.3
#> # ℹ 3 more variables: conf.high <dbl>, method <chr>, alternative <chr>

wt <- wilcox.test(mpg ~ am, data = mtcars, conf.int = TRUE, exact = FALSE)

tidy(wt)
#> # A tibble: 1 × 7
#>   estimate statistic p.value conf.low conf.high method      alternative
#>      <dbl>     <dbl>   <dbl>    <dbl>     <dbl> <chr>       <chr>      
#> 1    -6.80        42 0.00187    -11.7     -2.90 Wilcoxon r… two.sided  

ct <- cor.test(mtcars$wt, mtcars$mpg)

tidy(ct)
#> # A tibble: 1 × 8
#>   estimate statistic  p.value parameter conf.low conf.high method      
#>      <dbl>     <dbl>    <dbl>     <int>    <dbl>     <dbl> <chr>       
#> 1   -0.868     -9.56 1.29e-10        30   -0.934    -0.744 Pearson's p…
#> # ℹ 1 more variable: alternative <chr>

chit <- chisq.test(xtabs(Freq ~ Sex + Class, data = as.data.frame(Titanic)))

tidy(chit)
#> # A tibble: 1 × 4
#>   statistic  p.value parameter method                    
#>       <dbl>    <dbl>     <int> <chr>                     
#> 1      350. 1.56e-75         3 Pearson's Chi-squared test
augment(chit)
#> # A tibble: 8 × 9
#>   Sex    Class .observed  .prop .row.prop .col.prop .expected .resid
#>   <fct>  <fct>     <dbl>  <dbl>     <dbl>     <dbl>     <dbl>  <dbl>
#> 1 Male   1st         180 0.0818    0.104     0.554      256.   -4.73
#> 2 Female 1st         145 0.0659    0.309     0.446       69.4   9.07
#> 3 Male   2nd         179 0.0813    0.103     0.628      224.   -3.02
#> 4 Female 2nd         106 0.0482    0.226     0.372       60.9   5.79
#> 5 Male   3rd         510 0.232     0.295     0.722      555.   -1.92
#> 6 Female 3rd         196 0.0891    0.417     0.278      151.    3.68
#> 7 Male   Crew        862 0.392     0.498     0.974      696.    6.29
#> 8 Female Crew         23 0.0104    0.0489    0.0260     189.  -12.1 
#> # ℹ 1 more variable: .std.resid <dbl>
```
