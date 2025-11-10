# (Deprecated) Tidy summaryDefault objects

Tidiers for summaryDefault objects have been deprecated as of broom
0.7.0 in favor of `skimr::skim()`.

## Usage

``` r
# S3 method for class 'summaryDefault'
tidy(x, ...)

# S3 method for class 'summaryDefault'
glance(x, ...)
```

## Arguments

- x:

  A `summaryDefault` object, created by calling
  [`summary()`](https://wviechtb.github.io/metafor/reference/print.rma.html)
  on a vector.

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

## Value

A one-row
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- minimum:

  Minimum value in original vector.

- q1:

  First quartile of original vector.

- median:

  Median of original vector.

- mean:

  Mean of original vector.

- q3:

  Third quartile of original vector.

- maximum:

  Maximum value in original vector.

- na:

  Number of `NA` values in original vector. Column present only when
  original vector had at least one `NA` entry.

## See also

Other deprecated:
[`bootstrap()`](https://broom.tidymodels.org/dev/reference/bootstrap.md),
[`confint_tidy()`](https://broom.tidymodels.org/dev/reference/confint_tidy.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`finish_glance()`](https://broom.tidymodels.org/dev/reference/finish_glance.md),
[`fix_data_frame()`](https://broom.tidymodels.org/dev/reference/fix_data_frame.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.dist()`](https://broom.tidymodels.org/dev/reference/tidy.dist.md),
[`tidy.ftable()`](https://broom.tidymodels.org/dev/reference/tidy.ftable.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)

Other deprecated:
[`bootstrap()`](https://broom.tidymodels.org/dev/reference/bootstrap.md),
[`confint_tidy()`](https://broom.tidymodels.org/dev/reference/confint_tidy.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`finish_glance()`](https://broom.tidymodels.org/dev/reference/finish_glance.md),
[`fix_data_frame()`](https://broom.tidymodels.org/dev/reference/fix_data_frame.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.dist()`](https://broom.tidymodels.org/dev/reference/tidy.dist.md),
[`tidy.ftable()`](https://broom.tidymodels.org/dev/reference/tidy.ftable.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)

## Examples

``` r
v <- rnorm(1000)
s <- summary(v)
s
#>      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
#> -2.809775 -0.641421  0.002774  0.009750  0.661719  3.241040 

tidy(s)
#> Warning: `tidy.summaryDefault()` is deprecated. Please use `skimr::skim()` instead.
#> # A tibble: 1 × 6
#>   minimum     q1  median    mean    q3 maximum
#>     <dbl>  <dbl>   <dbl>   <dbl> <dbl>   <dbl>
#> 1   -2.81 -0.641 0.00277 0.00975 0.662    3.24
glance(s)
#> Warning: `tidy.summaryDefault()` is deprecated. Please use `skimr::skim()` instead.
#> # A tibble: 1 × 6
#>   minimum     q1  median    mean    q3 maximum
#>     <dbl>  <dbl>   <dbl>   <dbl> <dbl>   <dbl>
#> 1   -2.81 -0.641 0.00277 0.00975 0.662    3.24

v2 <- c(v,NA)
tidy(summary(v2))
#> Warning: `tidy.summaryDefault()` is deprecated. Please use `skimr::skim()` instead.
#> # A tibble: 1 × 7
#>   minimum     q1  median    mean    q3 maximum    na
#>     <dbl>  <dbl>   <dbl>   <dbl> <dbl>   <dbl> <dbl>
#> 1   -2.81 -0.641 0.00277 0.00975 0.662    3.24     1
```
