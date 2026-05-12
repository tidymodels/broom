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
[`glance.anova()`](https://broom.tidymodels.org/reference/glance.anova.md),
[`glance.aov()`](https://broom.tidymodels.org/reference/glance.aov.md),
[`tidy.TukeyHSD()`](https://broom.tidymodels.org/reference/tidy.TukeyHSD.md),
[`tidy.anova()`](https://broom.tidymodels.org/reference/tidy.anova.md),
[`tidy.aov()`](https://broom.tidymodels.org/reference/tidy.aov.md),
[`tidy.aovlist()`](https://broom.tidymodels.org/reference/tidy.aovlist.md)

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
#>   term         df  pillai statistic num.df den.df  p.value
#>   <chr>     <dbl>   <dbl>     <dbl>  <dbl>  <dbl>    <dbl>
#> 1 block         5  0.909      2.00      10     24  0.0796 
#> 2 N             1  0.601      8.29       2     11  0.00638
#> 3 P             1  0.237      1.71       2     11  0.226  
#> 4 K             1  0.343      2.87       2     11  0.0993 
#> 5 N:P           1  0.104      0.642      2     11  0.545  
#> 6 N:K           1  0.214      1.50       2     11  0.266  
#> 7 P:K           1  0.0705     0.417      2     11  0.669  
#> 8 Residuals    12 NA         NA         NA     NA NA      
```
