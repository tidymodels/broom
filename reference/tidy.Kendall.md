# Tidy a(n) Kendall object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'Kendall'
tidy(x, ...)
```

## Arguments

- x:

  A `Kendall` object returned from a call to
  [`Kendall::Kendall()`](https://rdrr.io/pkg/Kendall/man/Kendall.html),
  [`Kendall::MannKendall()`](https://rdrr.io/pkg/Kendall/man/MannKendall.html),
  or
  [`Kendall::SeasonalMannKendall()`](https://rdrr.io/pkg/Kendall/man/SeasonalMannKendall.html).

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
[`Kendall::Kendall()`](https://rdrr.io/pkg/Kendall/man/Kendall.html),
[`Kendall::MannKendall()`](https://rdrr.io/pkg/Kendall/man/MannKendall.html),
[`Kendall::SeasonalMannKendall()`](https://rdrr.io/pkg/Kendall/man/SeasonalMannKendall.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- kendall_score:

  Kendall score.

- p.value:

  The two-sided p-value associated with the observed statistic.

- var_kendall_score:

  Variance of the kendall_score.

- statistic:

  Kendall's tau statistic

- denominator:

  The denominator, which is tau=kendall_score/denominator.

## Examples

``` r
# load libraries for models and data
library(Kendall)

A <- c(2.5, 2.5, 2.5, 2.5, 5, 6.5, 6.5, 10, 10, 10, 10, 10, 14, 14, 14, 16, 17)
B <- c(1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2)

# fit models and summarize results
f_res <- Kendall(A, B)
tidy(f_res)
#> # A tibble: 1 × 5
#>   statistic p.value kendall_score denominator var_kendall_score
#>       <dbl>   <dbl>         <dbl>       <dbl>             <dbl>
#> 1     0.408  0.0754            34        83.4              345.

s_res <- MannKendall(B)
tidy(s_res)
#> # A tibble: 1 × 5
#>   statistic p.value kendall_score denominator var_kendall_score
#>       <dbl>   <dbl>         <dbl>       <dbl>             <dbl>
#> 1     0.354   0.102            32        90.3               360

t_res <- SeasonalMannKendall(ts(A))
tidy(t_res)
#> # A tibble: 1 × 5
#>   statistic     p.value kendall_score denominator var_kendall_score
#>       <dbl>       <dbl>         <dbl>       <dbl>             <dbl>
#> 1     0.924 0.000000935           116        126.              559.
```
