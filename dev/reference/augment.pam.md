# Augment data with information from a(n) pam object

Augment accepts a model object and a dataset and adds information about
each observation in the dataset. Most commonly, this includes predicted
values in the `.fitted` column, residuals in the `.resid` column, and
standard errors for the fitted values in a `.se.fit` column. New columns
always begin with a `.` prefix to avoid overwriting columns in the
original dataset.

Users may pass data to augment via either the `data` argument or the
`newdata` argument. If the user passes data to the `data` argument, it
**must** be exactly the data that was used to fit the model object. Pass
datasets to `newdata` to augment data that was not used during model
fitting. This still requires that at least all predictor variable
columns used to fit the model are present. If the original outcome
variable used to fit the model is not included in `newdata`, then no
`.resid` column will be included in the output.

Augment will often behave differently depending on whether `data` or
`newdata` is given. This is because there is often information
associated with training observations (such as influences or related)
measures that is not meaningfully defined for new observations.

For convenience, many augment methods provide default `data` arguments,
so that `augment(fit)` will return the augmented training data. In these
cases, augment tries to reconstruct the original data based on the model
object with varying degrees of success.

The augmented dataset is always returned as a
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with the **same number of rows** as the passed dataset. This means that
the passed data must be coercible to a tibble. If a predictor enters the
model as part of a matrix of covariates, such as when the model formula
uses [`splines::ns()`](https://rdrr.io/r/splines/ns.html),
[`stats::poly()`](https://rdrr.io/r/stats/poly.html), or
[`survival::Surv()`](https://rdrr.io/pkg/survival/man/Surv.html), it is
represented as a matrix column.

We are in the process of defining behaviors for models fit with various
`na.action` arguments, but make no guarantees about behavior when data
is missing at this time.

## Usage

``` r
# S3 method for class 'pam'
augment(x, data = NULL, ...)
```

## Arguments

- x:

  An `pam` object returned from
  [`cluster::pam()`](https://rdrr.io/pkg/cluster/man/pam.html)

- data:

  A [base::data.frame](https://rdrr.io/r/base/data.frame.html) or
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  containing the original data that was used to produce the object `x`.
  Defaults to `stats::model.frame(x)` so that `augment(my_fit)` returns
  the augmented original data. **Do not** pass new data to the `data`
  argument. Augment will report information such as influence and cooks
  distance for data passed to the `data` argument. These measures are
  only defined for the original training data.

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

[`augment()`](https://generics.r-lib.org/reference/augment.html),
[`cluster::pam()`](https://rdrr.io/pkg/cluster/man/pam.html)

Other pam tidiers:
[`glance.pam()`](https://broom.tidymodels.org/dev/reference/glance.pam.md),
[`tidy.pam()`](https://broom.tidymodels.org/dev/reference/tidy.pam.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- .cluster:

  Cluster assignment.

- .fitted:

  Fitted or predicted value.

- .resid:

  The difference between observed and fitted values.

## Examples

``` r
# load libraries for models and data
library(dplyr)
library(ggplot2)
library(cluster)
library(modeldata)
#> 
#> Attaching package: ‘modeldata’
#> The following object is masked from ‘package:datasets’:
#> 
#>     penguins
data(hpc_data)

x <- hpc_data[, 2:5]
p <- pam(x, k = 4)

# summarize model fit with tidiers + visualization
tidy(p)
#> # A tibble: 4 × 11
#>    size max.diss avg.diss diameter separation avg.width cluster
#>   <dbl>    <dbl>    <dbl>    <dbl>      <dbl>     <dbl> <fct>  
#> 1  3544   13865.     576.   15128.       93.6    0.711  1      
#> 2   412    3835.    1111.    5704.       93.2    0.398  2      
#> 3   236    3882.    1317.    5852.       93.2    0.516  3      
#> 4   139   42999.    5582.   46451.      151.     0.0843 4      
#> # ℹ 4 more variables: compounds <dbl>, input_fields <dbl>,
#> #   iterations <dbl>, num_pending <dbl>
glance(p)
#> # A tibble: 1 × 1
#>   avg.silhouette.width
#>                  <dbl>
#> 1                0.650
augment(p, x)
#> # A tibble: 4,331 × 5
#>    compounds input_fields iterations num_pending .cluster
#>        <dbl>        <dbl>      <dbl>       <dbl> <fct>   
#>  1       997          137         20           0 1       
#>  2        97          103         20           0 1       
#>  3       101           75         10           0 1       
#>  4        93           76         20           0 1       
#>  5       100           82         20           0 1       
#>  6       100           82         20           0 1       
#>  7       105           88         20           0 1       
#>  8        98           95         20           0 1       
#>  9       101           91         20           0 1       
#> 10        95           92         20           0 1       
#> # ℹ 4,321 more rows

augment(p, x) |>
  ggplot(aes(compounds, input_fields)) +
  geom_point(aes(color = .cluster)) +
  geom_text(aes(label = cluster), data = tidy(p), size = 10)
```
