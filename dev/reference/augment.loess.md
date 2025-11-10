# Tidy a(n) loess object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'loess'
augment(x, data = model.frame(x), newdata = NULL, se_fit = FALSE, ...)
```

## Arguments

- x:

  A `loess` objects returned by
  [`stats::loess()`](https://rdrr.io/r/stats/loess.html).

- data:

  A [base::data.frame](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing the original data that was used to produce the object `x`.
  Defaults to `stats::model.frame(x)` so that `augment(my_fit)` returns
  the augmented original data. **Do not** pass new data to the `data`
  argument. Augment will report information such as influence and cooks
  distance for data passed to the `data` argument. These measures are
  only defined for the original training data.

- newdata:

  A [`base::data.frame()`](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing all the original predictors used to create `x`. Defaults to
  `NULL`, indicating that nothing has been passed to `newdata`. If
  `newdata` is specified, the `data` argument will be ignored.

- se_fit:

  Logical indicating whether or not a `.se.fit` column should be added
  to the augmented output. For some models, this calculation can be
  somewhat time-consuming. Defaults to `FALSE`.

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

When the modeling was performed with `na.action = "na.omit"` (as is the
typical default), rows with NA in the initial data are omitted entirely
from the augmented data frame. When the modeling was performed with
`na.action = "na.exclude"`, one should provide the original data as a
second argument, at which point the augmented data will contain those
rows (typically with NAs in place of the new columns). If the original
data is not provided to
[`augment()`](https://generics.r-lib.org/reference/augment.html) and
`na.action = "na.exclude"`, a warning is raised and the incomplete rows
are dropped.

Note that `loess` objects by default will not predict on data outside of
a bounding hypercube defined by the training data unless the original
`loess` object was fit with
`control = loess.control(surface = \"direct\"))`. See
[`stats::predict.loess()`](https://rdrr.io/r/stats/predict.loess.html)
for details.

## See also

[stats::na.action](https://rdrr.io/r/stats/na.action.html)

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`stats::loess()`](https://rdrr.io/r/stats/loess.html),
[`stats::predict.loess()`](https://rdrr.io/r/stats/predict.loess.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .fitted:

  Fitted or predicted value.

- .resid:

  The difference between observed and fitted values.

- .se.fit:

  Standard errors of fitted values.

## Examples

``` r
lo <- loess(
  mpg ~ hp + wt,
  mtcars,
  control = loess.control(surface = "direct")
)

augment(lo)
#> # A tibble: 32 × 6
#>    .rownames           mpg    hp    wt .fitted  .resid
#>    <chr>             <dbl> <dbl> <dbl>   <dbl>   <dbl>
#>  1 Mazda RX4          21     110  2.62    21.4 -0.435 
#>  2 Mazda RX4 Wag      21     110  2.88    20.9  0.0976
#>  3 Datsun 710         22.8    93  2.32    24.7 -1.88  
#>  4 Hornet 4 Drive     21.4   110  3.22    19.6  1.76  
#>  5 Hornet Sportabout  18.7   175  3.44    16.7  2.02  
#>  6 Valiant            18.1   105  3.46    18.9 -0.833 
#>  7 Duster 360         14.3   245  3.57    14.9 -0.641 
#>  8 Merc 240D          24.4    62  3.19    25.1 -0.695 
#>  9 Merc 230           22.8    95  3.15    21.4  1.43  
#> 10 Merc 280           19.2   123  3.44    18.4  0.801 
#> # ℹ 22 more rows

# with all columns of original data
augment(lo, mtcars)
#> # A tibble: 32 × 14
#>    .rownames        mpg   cyl  disp    hp  drat    wt  qsec    vs    am
#>    <chr>          <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 Mazda RX4       21       6  160    110  3.9   2.62  16.5     0     1
#>  2 Mazda RX4 Wag   21       6  160    110  3.9   2.88  17.0     0     1
#>  3 Datsun 710      22.8     4  108     93  3.85  2.32  18.6     1     1
#>  4 Hornet 4 Drive  21.4     6  258    110  3.08  3.22  19.4     1     0
#>  5 Hornet Sporta…  18.7     8  360    175  3.15  3.44  17.0     0     0
#>  6 Valiant         18.1     6  225    105  2.76  3.46  20.2     1     0
#>  7 Duster 360      14.3     8  360    245  3.21  3.57  15.8     0     0
#>  8 Merc 240D       24.4     4  147.    62  3.69  3.19  20       1     0
#>  9 Merc 230        22.8     4  141.    95  3.92  3.15  22.9     1     0
#> 10 Merc 280        19.2     6  168.   123  3.92  3.44  18.3     1     0
#> # ℹ 22 more rows
#> # ℹ 4 more variables: gear <dbl>, carb <dbl>, .fitted <dbl>,
#> #   .resid <dbl>

# with a new dataset
augment(lo, newdata = head(mtcars))
#> # A tibble: 6 × 14
#>   .rownames   mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear
#>   <chr>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 Mazda RX4  21       6   160   110  3.9   2.62  16.5     0     1     4
#> 2 Mazda RX…  21       6   160   110  3.9   2.88  17.0     0     1     4
#> 3 Datsun 7…  22.8     4   108    93  3.85  2.32  18.6     1     1     4
#> 4 Hornet 4…  21.4     6   258   110  3.08  3.22  19.4     1     0     3
#> 5 Hornet S…  18.7     8   360   175  3.15  3.44  17.0     0     0     3
#> 6 Valiant    18.1     6   225   105  2.76  3.46  20.2     1     0     3
#> # ℹ 3 more variables: carb <dbl>, .fitted <dbl>, .resid <dbl>
```
