# Tidy a(n) manova object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'manova'
tidy(x, test = "Pillai", ...)
```

## Arguments

- x:

  A `manova` object return from
  [`stats::manova()`](https://rdrr.io/r/stats/manova.html).

- test:

  One of "Pillai" (Pillai's trace), "Wilks" (Wilk's lambda),
  "Hotelling-Lawley" (Hotelling-Lawley trace) or "Roy" (Roy's greatest
  root) indicating which test statistic should be used. Defaults to
  "Pillai".

- ...:

  Arguments passed on to
  [`stats::summary.manova`](https://rdrr.io/r/stats/summary.manova.html)

  `object`

  :   An object of class `"manova"` or an `aov` object with multiple
      responses.

  `intercept`

  :   logical. If `TRUE`, the intercept term is included in the table.

  `tol`

  :   tolerance to be used in deciding if the residuals are
      rank-deficient: see
      [`qr`](https://rdrr.io/pkg/Matrix/man/qr-methods.html).

## Details

Depending on which test statistic is specified only one of `pillai`,
`wilks`, `hl` or `roy` is included.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`stats::summary.manova()`](https://rdrr.io/r/stats/summary.manova.html)

Other anova tidiers:
[`glance.anova()`](https://broom.tidymodels.org/dev/reference/glance.anova.md),
[`glance.aov()`](https://broom.tidymodels.org/dev/reference/glance.aov.md),
[`tidy.TukeyHSD()`](https://broom.tidymodels.org/dev/reference/tidy.TukeyHSD.md),
[`tidy.anova()`](https://broom.tidymodels.org/dev/reference/tidy.anova.md),
[`tidy.aov()`](https://broom.tidymodels.org/dev/reference/tidy.aov.md),
[`tidy.aovlist()`](https://broom.tidymodels.org/dev/reference/tidy.aovlist.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- den.df:

  Degrees of freedom of the denominator.

- num.df:

  Degrees of freedom.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- term:

  The name of the regression term.

- pillai:

  Pillai's trace.

- wilks:

  Wilk's lambda.

- hl:

  Hotelling-Lawley trace.

- roy:

  Roy's greatest root.

## Examples

``` r
npk2 <- within(npk, foo <- rnorm(24))
m <- manova(cbind(yield, foo) ~ block + N * P * K, npk2)
tidy(m)
#> # A tibble: 8 × 7
#>   term         df  pillai statistic num.df den.df p.value
#>   <chr>     <dbl>   <dbl>     <dbl>  <dbl>  <dbl>   <dbl>
#> 1 block         5  0.786      1.56      10     24  0.181 
#> 2 N             1  0.506      5.64       2     11  0.0206
#> 3 P             1  0.0623     0.366      2     11  0.702 
#> 4 K             1  0.341      2.85       2     11  0.101 
#> 5 N:P           1  0.112      0.694      2     11  0.520 
#> 6 N:K           1  0.234      1.68       2     11  0.231 
#> 7 P:K           1  0.0334     0.190      2     11  0.830 
#> 8 Residuals    12 NA         NA         NA     NA NA     
```
