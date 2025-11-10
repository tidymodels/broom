# Tidy/glance a(n) htest object

For models that have only a single component, the
[`tidy()`](https://generics.r-lib.org/reference/tidy.html) and
[`glance()`](https://generics.r-lib.org/reference/glance.html) methods
are identical. Please see the documentation for both of those methods.

## Usage

``` r
# S3 method for class 'htest'
tidy(x, ...)

# S3 method for class 'htest'
glance(x, ...)
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

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`stats::cor.test()`](https://rdrr.io/r/stats/cor.test.html),
[`stats::t.test()`](https://rdrr.io/r/stats/t.test.html),
[`stats::wilcox.test()`](https://rdrr.io/r/stats/wilcox.test.html),
[`stats::chisq.test()`](https://rdrr.io/r/stats/chisq.test.html)

Other htest tidiers:
[`augment.htest()`](https://broom.tidymodels.org/dev/reference/augment.htest.md),
[`tidy.pairwise.htest()`](https://broom.tidymodels.org/dev/reference/tidy.pairwise.htest.md),
[`tidy.power.htest()`](https://broom.tidymodels.org/dev/reference/tidy.power.htest.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- alternative:

  Alternative hypothesis (character).

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- estimate:

  The estimated value of the regression term.

- estimate1:

  Sometimes two estimates are computed, such as in a two-sample t-test.

- estimate2:

  Sometimes two estimates are computed, such as in a two-sample t-test.

- method:

  Method used.

- p.value:

  The two-sided p-value associated with the observed statistic.

- parameter:

  The parameter being modeled.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

## Examples

``` r
tt <- t.test(rnorm(10))

tidy(tt)
#> # A tibble: 1 × 8
#>   estimate statistic p.value parameter conf.low conf.high method       
#>      <dbl>     <dbl>   <dbl>     <dbl>    <dbl>     <dbl> <chr>        
#> 1   -0.158    -0.479   0.644         9   -0.906     0.590 One Sample t…
#> # ℹ 1 more variable: alternative <chr>

# the glance output will be the same for each of the below tests
glance(tt)
#> # A tibble: 1 × 8
#>   estimate statistic p.value parameter conf.low conf.high method       
#>      <dbl>     <dbl>   <dbl>     <dbl>    <dbl>     <dbl> <chr>        
#> 1   -0.158    -0.479   0.644         9   -0.906     0.590 One Sample t…
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
