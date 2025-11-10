# Ensure an object is a data frame, with rownames moved into a column

This function is deprecated as of broom 0.7.0 and will be removed from a
future release. Please see
[`tibble::as_tibble`](https://tibble.tidyverse.org/reference/as_tibble.html).

## Usage

``` r
fix_data_frame(x, newnames = NULL, newcol = "term")
```

## Arguments

- x:

  a data.frame or matrix

- newnames:

  new column names, not including the rownames

- newcol:

  the name of the new rownames column

## Value

a data.frame, with rownames moved into a column and new column names
assigned

## See also

Other deprecated:
[`bootstrap()`](https://broom.tidymodels.org/dev/reference/bootstrap.md),
[`confint_tidy()`](https://broom.tidymodels.org/dev/reference/confint_tidy.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`finish_glance()`](https://broom.tidymodels.org/dev/reference/finish_glance.md),
[`summary_tidiers`](https://broom.tidymodels.org/dev/reference/summary_tidiers.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.dist()`](https://broom.tidymodels.org/dev/reference/tidy.dist.md),
[`tidy.ftable()`](https://broom.tidymodels.org/dev/reference/tidy.ftable.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)
