# Tidy a(n) ergm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

The methods should work with any model that conforms to the ergm class,
such as those produced from weighted networks by the ergm.count package.

## Usage

``` r
# S3 method for class 'ergm'
tidy(x, conf.int = FALSE, conf.level = 0.95, exponentiate = FALSE, ...)
```

## Arguments

- x:

  An `ergm` object returned from a call to
  [`ergm::ergm()`](https://rdrr.io/pkg/ergm/man/ergm.html).

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

  Additional arguments to pass to
  [`ergm::summary()`](https://rdrr.io/pkg/ergm/man/summary.formula.html).
  **Cautionary note**: Misspecified arguments may be silently ignored.

## Value

A [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
with one row for each coefficient in the exponential random graph model,
with columns:

- term:

  The term in the model being estimated and tested

- estimate:

  The estimated coefficient

- std.error:

  The standard error

- mcmc.error:

  The MCMC error

- p.value:

  The two-sided p-value

## References

Hunter DR, Handcock MS, Butts CT, Goodreau SM, Morris M (2008b). ergm: A
Package to Fit, Simulate and Diagnose Exponential-Family Models for
Networks. *Journal of Statistical Software*, 24(3).
<https://www.jstatsoft.org/v24/i03/>.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`ergm::ergm()`](https://rdrr.io/pkg/ergm/man/ergm.html),
[`ergm::control.ergm()`](https://rdrr.io/pkg/ergm/man/control.ergm.html),
[`ergm::summary()`](https://rdrr.io/pkg/ergm/man/summary.formula.html)

Other ergm tidiers:
[`glance.ergm()`](https://broom.tidymodels.org/dev/reference/glance.ergm.md)

## Examples

``` r
# load libraries for models and data
library(ergm)
#> 
#> ‘ergm’ 4.10.1 (2025-08-26), part of the Statnet Project
#> * ‘news(package="ergm")’ for changes since last version
#> * ‘citation("ergm")’ for citation information
#> * ‘https://statnet.org’ for help, support, and other information
#> ‘ergm’ 4 is a major update that introduces some
#> backwards-incompatible changes. Please type
#> ‘news(package="ergm")’ for a list of major changes.
#> 
#> Attaching package: ‘ergm’
#> The following object is masked from ‘package:btergm’:
#> 
#>     gof

# load the Florentine marriage network data
data(florentine)

# fit a model where the propensity to form ties between
# families depends on the absolute difference in wealth
gest <- ergm(flomarriage ~ edges + absdiff("wealth"))
#> Starting maximum pseudolikelihood estimation (MPLE):
#> Obtaining the responsible dyads.
#> Evaluating the predictor and response matrix.
#> Maximizing the pseudolikelihood.
#> Finished MPLE.
#> Evaluating log-likelihood at the estimate. 
#> 

# show terms, coefficient estimates and errors
tidy(gest)
#> # A tibble: 2 × 6
#>   term           estimate std.error mcmc.error statistic      p.value
#>   <chr>             <dbl>     <dbl>      <dbl>     <dbl>        <dbl>
#> 1 edges           -2.30     0.402            0     -5.73 0.0000000102
#> 2 absdiff.wealth   0.0155   0.00616          0      2.52 0.0117      

# show coefficients as odds ratios with a 99% CI
tidy(gest, exponentiate = TRUE, conf.int = TRUE, conf.level = 0.99)
#> Warning: Coefficients will be exponentiated, but the model didn't use a `log`
#> or `logit` link.
#> # A tibble: 2 × 8
#>   term         estimate std.error mcmc.error statistic p.value conf.low
#>   <chr>           <dbl>     <dbl>      <dbl>     <dbl>   <dbl>    <dbl>
#> 1 edges           0.100   0.402            0     -5.73 1.02e-8   0.0355
#> 2 absdiff.wea…    1.02    0.00616          0      2.52 1.17e-2   1.000 
#> # ℹ 1 more variable: conf.high <dbl>

# take a look at likelihood measures and other
# control parameters used during MCMC estimation
glance(gest)
#> # A tibble: 1 × 5
#>   independence iterations logLik   AIC   BIC
#>   <lgl>             <int>  <dbl> <dbl> <dbl>
#> 1 TRUE                  4  -51.0  106.  112.
glance(gest, deviance = TRUE)
#> # A tibble: 1 × 9
#>   independence iterations logLik null.deviance df.null
#>   <lgl>             <int>  <dbl> <logLik>        <dbl>
#> 1 TRUE                  4  -51.0 166.3553          120
#> # ℹ 4 more variables: residual.deviance <dbl>, df.residual <dbl>,
#> #   AIC <dbl>, BIC <dbl>
glance(gest, mcmc = TRUE)
#> Though `glance()` was supplied `mcmc = TRUE`, the model was not fitted
#> using MCMC,
#> ℹ The corresponding columns will be omitted.
#> # A tibble: 1 × 5
#>   independence iterations logLik   AIC   BIC
#>   <lgl>             <int>  <dbl> <dbl> <dbl>
#> 1 TRUE                  4  -51.0  106.  112.
```
