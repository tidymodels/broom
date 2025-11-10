# Tidy a(n) confint.glht object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'confint.glht'
tidy(x, ...)
```

## Arguments

- x:

  A `confint.glht` object created by calling
  [`multcomp::confint.glht()`](https://rdrr.io/pkg/multcomp/man/methods.html)
  on a `glht` object created with
  [`multcomp::glht()`](https://rdrr.io/pkg/multcomp/man/glht.html).

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
[`multcomp::confint.glht()`](https://rdrr.io/pkg/multcomp/man/methods.html),
[`multcomp::glht()`](https://rdrr.io/pkg/multcomp/man/glht.html)

Other multcomp tidiers:
[`tidy.cld()`](https://broom.tidymodels.org/dev/reference/tidy.cld.md),
[`tidy.glht()`](https://broom.tidymodels.org/dev/reference/tidy.glht.md),
[`tidy.summary.glht()`](https://broom.tidymodels.org/dev/reference/tidy.summary.glht.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- contrast:

  Levels being compared.

- estimate:

  The estimated value of the regression term.

## Examples

``` r
# load libraries for models and data
library(multcomp)
library(ggplot2)

amod <- aov(breaks ~ wool + tension, data = warpbreaks)
wht <- glht(amod, linfct = mcp(tension = "Tukey"))

tidy(wht)
#> # A tibble: 3 × 7
#>   term    contrast null.value estimate std.error statistic adj.p.value
#>   <chr>   <chr>         <dbl>    <dbl>     <dbl>     <dbl>       <dbl>
#> 1 tension M - L             0   -10         3.87     -2.58     0.0336 
#> 2 tension H - L             0   -14.7       3.87     -3.80     0.00115
#> 3 tension H - M             0    -4.72      3.87     -1.22     0.447  

ggplot(wht, aes(lhs, estimate)) +
  geom_point()


CI <- confint(wht)

tidy(CI)
#> # A tibble: 3 × 5
#>   term    contrast estimate conf.low conf.high
#>   <chr>   <chr>       <dbl>    <dbl>     <dbl>
#> 1 tension M - L      -10       -19.4    -0.646
#> 2 tension H - L      -14.7     -24.1    -5.37 
#> 3 tension H - M       -4.72    -14.1     4.63 

ggplot(CI, aes(lhs, estimate, ymin = lwr, ymax = upr)) +
  geom_pointrange()


tidy(summary(wht))
#> # A tibble: 3 × 7
#>   term    contrast null.value estimate std.error statistic adj.p.value
#>   <chr>   <chr>         <dbl>    <dbl>     <dbl>     <dbl>       <dbl>
#> 1 tension M - L             0   -10         3.87     -2.58     0.0336 
#> 2 tension H - L             0   -14.7       3.87     -3.80     0.00115
#> 3 tension H - M             0    -4.72      3.87     -1.22     0.447  
ggplot(mapping = aes(lhs, estimate)) +
  geom_linerange(aes(ymin = lwr, ymax = upr), data = CI) +
  geom_point(aes(size = p), data = summary(wht)) +
  scale_size(trans = "reverse")


cld <- cld(wht)
tidy(cld)
#> # A tibble: 3 × 2
#>   tension letters
#>   <chr>   <chr>  
#> 1 L       a      
#> 2 M       b      
#> 3 H       b      
```
