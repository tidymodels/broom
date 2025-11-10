# Set up bootstrap replicates of a dplyr operation

The `bootstrap()` function is deprecated and will be removed from an
upcoming release of broom. For tidy resampling, please use the rsample
package instead. Functionality is no longer supported for this method.

## Usage

``` r
bootstrap(df, m, by_group = FALSE)
```

## Arguments

- df:

  a data frame

- m:

  number of bootstrap replicates to perform

- by_group:

  If `TRUE`, then bootstrap within each group if `df` is a grouped
  tibble.

## Details

This code originates from Hadley Wickham (with a few small corrections)
here: <https://github.com/tidyverse/dplyr/issues/269>

## See also

Other deprecated:
[`confint_tidy()`](https://broom.tidymodels.org/dev/reference/confint_tidy.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`finish_glance()`](https://broom.tidymodels.org/dev/reference/finish_glance.md),
[`fix_data_frame()`](https://broom.tidymodels.org/dev/reference/fix_data_frame.md),
[`summary_tidiers`](https://broom.tidymodels.org/dev/reference/summary_tidiers.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.dist()`](https://broom.tidymodels.org/dev/reference/tidy.dist.md),
[`tidy.ftable()`](https://broom.tidymodels.org/dev/reference/tidy.ftable.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)
