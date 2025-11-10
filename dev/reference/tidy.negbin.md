# Tidy a(n) negbin object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'negbin'
tidy(x, conf.int = FALSE, conf.level = 0.95, exponentiate = FALSE, ...)
```

## Arguments

- x:

  A `glm.nb` object returned by
  [`MASS::glm.nb()`](https://rdrr.io/pkg/MASS/man/glm.nb.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- exponentiate:

  Logical indicating whether or not to exponentiate the the coefficient
  estimates. This is typical for logistic and multinomial regressions,
  but a bad idea if there is no log or logit link. Defaults to `FALSE`.

- ...:

  For [`tidy()`](https://generics.r-lib.org/reference/tidy.html),
  additional arguments passed to
  [`summary()`](https://rdrr.io/pkg/ergm/man/summary.formula.html).
  Otherwise ignored.

## See also

[`MASS::glm.nb()`](https://rdrr.io/pkg/MASS/man/glm.nb.html)

Other glm.nb tidiers:
[`glance.negbin()`](https://broom.tidymodels.org/dev/reference/glance.negbin.md)

## Examples

``` r
# load libraries for models and data
library(MASS)

# fit model
r <- glm.nb(Days ~ Sex / (Age + Eth * Lrn), data = quine)

# summarize model fit with tidiers
tidy(r)
#> # A tibble: 14 × 5
#>    term            estimate std.error statistic  p.value
#>    <chr>              <dbl>     <dbl>     <dbl>    <dbl>
#>  1 (Intercept)       3.02       0.297    10.2   2.89e-24
#>  2 SexM             -0.475      0.396    -1.20  2.29e- 1
#>  3 SexF:AgeF1       -0.709      0.323    -2.19  2.83e- 2
#>  4 SexM:AgeF1       -0.724      0.330    -2.19  2.85e- 2
#>  5 SexF:AgeF2       -0.615      0.371    -1.66  9.78e- 2
#>  6 SexM:AgeF2        0.628      0.274     2.30  2.17e- 2
#>  7 SexF:AgeF3       -0.342      0.327    -1.05  2.95e- 1
#>  8 SexM:AgeF3        1.15       0.314     3.67  2.46e- 4
#>  9 SexF:EthN        -0.0731     0.265    -0.276 7.83e- 1
#> 10 SexM:EthN        -0.679      0.256    -2.65  8.07e- 3
#> 11 SexF:LrnSL        0.944      0.322     2.93  3.43e- 3
#> 12 SexM:LrnSL        0.239      0.336     0.712 4.76e- 1
#> 13 SexF:EthN:LrnSL  -1.36       0.377    -3.60  3.16e- 4
#> 14 SexM:EthN:LrnSL   0.761      0.441     1.73  8.45e- 2
glance(r)
#> # A tibble: 1 × 8
#>   null.deviance df.null logLik     AIC   BIC deviance df.residual  nobs
#>           <dbl>   <int> <logLik> <dbl> <dbl>    <dbl>       <int> <int>
#> 1          235.     145 -531.51… 1093. 1138.     168.         132   146
```
