# Tidy a(n) epi.2by2 object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'epi.2by2'
tidy(x, parameters = c("moa", "stat"), ...)
```

## Arguments

- x:

  A `epi.2by2` object produced by a call to
  [`epiR::epi.2by2()`](https://rdrr.io/pkg/epiR/man/epi.2by2.html)

- parameters:

  Return measures of association (`moa`) or test statistics (`stat`),
  default is `moa` (measures of association)

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

The tibble has a column for each of the measures of association or tests
contained in `massoc` or `massoc.detail` when
[`epiR::epi.2by2()`](https://rdrr.io/pkg/epiR/man/epi.2by2.html) is
called.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`epiR::epi.2by2()`](https://rdrr.io/pkg/epiR/man/epi.2by2.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- df:

  Degrees of freedom used by this term in the model.

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- term:

  The name of the regression term.

- estimate:

  Estimated measure of association

## Examples

``` r
# load libraries for models and data
library(epiR)
#> Package epiR 2.0.88 is loaded
#> Type help(epi.about) for summary information
#> Type browseVignettes(package = 'epiR') to learn how to use epiR for applied epidemiological analyses
#> 

# generate data
dat <- matrix(c(13, 2163, 5, 3349), nrow = 2, byrow = TRUE)

rownames(dat) <- c("DF+", "DF-")
colnames(dat) <- c("FUS+", "FUS-")

# fit model
fit <- epi.2by2(
  dat = as.table(dat), method = "cross.sectional",
  conf.level = 0.95, units = 100, outcome = "as.columns"
)

# summarize model fit with tidiers
tidy(fit, parameters = "moa")
#> # A tibble: 16 × 4
#>    term                estimate conf.low conf.high
#>    <chr>                  <dbl>    <dbl>     <dbl>
#>  1 PR.strata.wald         4.01    1.43      11.2  
#>  2 PR.strata.taylor       4.01    1.43      11.2  
#>  3 PR.strata.score        4.01    1.49      10.8  
#>  4 PR.strata.koopman      4.01    1.49      10.8  
#>  5 OR.strata.wald         4.03    1.43      11.3  
#>  6 OR.strata.cfield       4.03   NA         NA    
#>  7 OR.strata.score        4.03    1.49      10.9  
#>  8 OR.strata.mle          4.02    1.34      14.4  
#>  9 ARisk.strata.wald      0.448   0.0992     0.797
#> 10 ARisk.strata.score     0.448   0.142      0.882
#> 11 NNT.strata.wald      223.    125.      1008.   
#> 12 NNT.strata.score     223.    113.       705.   
#> 13 AFRisk.strata.wald     0.750   0.329      0.907
#> 14 PARisk.strata.wald     0.176  -0.0225     0.375
#> 15 PARisk.strata.piri     0.176   0.0389     0.314
#> 16 PAFRisk.strata.wald    0.542   0.324      0.749
tidy(fit, parameters = "stat")
#> # A tibble: 5 × 4
#>   term               statistic    df p.value
#>   <chr>                  <dbl> <dbl>   <dbl>
#> 1 wald.strata.rr          2.64    NA 0.00825
#> 2 wald.strata.or          2.64    NA 0.00822
#> 3 chi2.strata.uncor       8.18     1 0.00424
#> 4 chi2.strata.yates       6.85     1 0.00885
#> 5 chi2.strata.fisher     NA       NA 0.00635
```
