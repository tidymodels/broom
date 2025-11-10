# Tidiers for NULL inputs

`tidy(NULL)`, `glance(NULL)` and `augment(NULL)` all return an empty
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html).
This empty tibble can be treated a tibble with zero rows, making it
convenient to combine with other tibbles using functions like
[`purrr::map_df()`](https://purrr.tidyverse.org/reference/map_dfr.html)
on lists of potentially `NULL` objects.

## Usage

``` r
# S3 method for class '`NULL`'
tidy(x, ...)

# S3 method for class '`NULL`'
glance(x, ...)

# S3 method for class '`NULL`'
augment(x, ...)
```

## Arguments

- x:

  The value `NULL`.

- ...:

  Additional arguments (not used).

## Value

An empty
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html).

## See also

[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
