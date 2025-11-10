# (Deprecated) Tidy dist objects

(Deprecated) Tidy dist objects

## Usage

``` r
# S3 method for class 'dist'
tidy(x, diagonal = attr(x, "Diag"), upper = attr(x, "Upper"), ...)
```

## Arguments

- x:

  A `dist` object returned from
  [`stats::dist()`](https://rdrr.io/r/stats/dist.html).

- diagonal:

  Logical indicating whether or not to tidy the diagonal elements of the
  distance matrix. Defaults to whatever was based to the `diag` argument
  of [`stats::dist()`](https://rdrr.io/r/stats/dist.html).

- upper:

  Logical indicating whether or not to tidy the upper half of the
  distance matrix. Defaults to whatever was based to the `upper`
  argument of [`stats::dist()`](https://rdrr.io/r/stats/dist.html).

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

A [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with one row for each pair of items in the distance matrix, with
columns:

- item1:

  First item

- item2:

  Second item

- distance:

  Distance between items

## Details

If the distance matrix does not include an upper triangle and/or
diagonal, the tidied version will not either.

## See also

Other deprecated:
[`bootstrap()`](https://broom.tidymodels.org/dev/reference/bootstrap.md),
[`confint_tidy()`](https://broom.tidymodels.org/dev/reference/confint_tidy.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`finish_glance()`](https://broom.tidymodels.org/dev/reference/finish_glance.md),
[`fix_data_frame()`](https://broom.tidymodels.org/dev/reference/fix_data_frame.md),
[`summary_tidiers`](https://broom.tidymodels.org/dev/reference/summary_tidiers.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.ftable()`](https://broom.tidymodels.org/dev/reference/tidy.ftable.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)

## Examples

``` r
cars_dist <- dist(t(mtcars[, 1:4]))
cars_dist
#>             mpg        cyl       disp
#> cyl    89.32586                      
#> disp 1391.49546 1441.25177           
#> hp    824.37547  878.17652  656.64044

tidy(cars_dist)
#> # A tibble: 6 × 3
#>   item1 item2 distance
#>   <fct> <fct>    <dbl>
#> 1 mpg   cyl       89.3
#> 2 mpg   disp    1391. 
#> 3 mpg   hp       824. 
#> 4 cyl   disp    1441. 
#> 5 cyl   hp       878. 
#> 6 disp  hp       657. 
tidy(cars_dist, upper = TRUE)
#> # A tibble: 12 × 3
#>    item1 item2 distance
#>    <fct> <fct>    <dbl>
#>  1 mpg   cyl       89.3
#>  2 mpg   disp    1391. 
#>  3 mpg   hp       824. 
#>  4 cyl   mpg       89.3
#>  5 cyl   disp    1441. 
#>  6 cyl   hp       878. 
#>  7 disp  mpg     1391. 
#>  8 disp  cyl     1441. 
#>  9 disp  hp       657. 
#> 10 hp    mpg      824. 
#> 11 hp    cyl      878. 
#> 12 hp    disp     657. 
tidy(cars_dist, diagonal = TRUE)
#> # A tibble: 10 × 3
#>    item1 item2 distance
#>    <fct> <fct>    <dbl>
#>  1 mpg   mpg        0  
#>  2 mpg   cyl       89.3
#>  3 mpg   disp    1391. 
#>  4 mpg   hp       824. 
#>  5 cyl   cyl        0  
#>  6 cyl   disp    1441. 
#>  7 cyl   hp       878. 
#>  8 disp  disp       0  
#>  9 disp  hp       657. 
#> 10 hp    hp         0  
```
