# Tidy a(n) TukeyHSD object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'TukeyHSD'
tidy(x, ...)
```

## Arguments

- x:

  A `TukeyHSD` object return from
  [`stats::TukeyHSD()`](https://rdrr.io/r/stats/TukeyHSD.html).

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
[`stats::TukeyHSD()`](https://rdrr.io/r/stats/TukeyHSD.html)

Other anova tidiers:
[`glance.anova()`](https://broom.tidymodels.org/dev/reference/glance.anova.md),
[`glance.aov()`](https://broom.tidymodels.org/dev/reference/glance.aov.md),
[`tidy.anova()`](https://broom.tidymodels.org/dev/reference/tidy.anova.md),
[`tidy.aov()`](https://broom.tidymodels.org/dev/reference/tidy.aov.md),
[`tidy.aovlist()`](https://broom.tidymodels.org/dev/reference/tidy.aovlist.md),
[`tidy.manova()`](https://broom.tidymodels.org/dev/reference/tidy.manova.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- adj.p.value:

  P-value adjusted for multiple comparisons.

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- contrast:

  Levels being compared.

- estimate:

  The estimated value of the regression term.

- null.value:

  Value to which the estimate is compared.

- term:

  The name of the regression term.

## Examples

``` r
fm1 <- aov(breaks ~ wool + tension, data = warpbreaks)
thsd <- TukeyHSD(fm1, "tension", ordered = TRUE)
tidy(thsd)
#> # A tibble: 3 × 7
#>   term    contrast null.value estimate conf.low conf.high adj.p.value
#>   <chr>   <chr>         <dbl>    <dbl>    <dbl>     <dbl>       <dbl>
#> 1 tension M-H               0     4.72   -4.63       14.1     0.447  
#> 2 tension L-H               0    14.7     5.37       24.1     0.00112
#> 3 tension L-M               0    10.0     0.647      19.4     0.0336 

# may include comparisons on multiple terms
fm2 <- aov(mpg ~ as.factor(gear) * as.factor(cyl), data = mtcars)
tidy(TukeyHSD(fm2))
#> # A tibble: 42 × 7
#>    term     contrast null.value estimate conf.low conf.high adj.p.value
#>    <chr>    <chr>         <dbl>    <dbl>    <dbl>     <dbl>       <dbl>
#>  1 as.fact… 4-3               0    8.43     5.19      11.7   0.00000297
#>  2 as.fact… 5-3               0    5.27     0.955      9.59  0.0147    
#>  3 as.fact… 5-4               0   -3.15    -7.60       1.30  0.201     
#>  4 as.fact… 6-4               0   -5.40    -9.45      -1.36  0.00748   
#>  5 as.fact… 8-4               0   -5.23    -8.60      -1.86  0.00201   
#>  6 as.fact… 8-6               0    0.172   -3.70       4.04  0.993     
#>  7 as.fact… 4:4-3:4           0    5.43    -6.65      17.5   0.832     
#>  8 as.fact… 5:4-3:4           0    6.70    -7.24      20.6   0.778     
#>  9 as.fact… 3:6-3:4           0   -1.75   -15.7       12.2   1.000     
#> 10 as.fact… 4:6-3:4           0   -1.75   -14.5       11.0   1.000     
#> # ℹ 32 more rows
```
