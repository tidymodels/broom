# Tidy a(n) garch object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'garch'
glance(x, test = c("box-ljung-test", "jarque-bera-test"), ...)
```

## Arguments

- x:

  A `garch` object returned by
  [`tseries::garch()`](https://rdrr.io/pkg/tseries/man/garch.html).

- test:

  Character specification of which hypothesis test to use. The `garch`
  function reports 2 hypothesis tests: Jarque-Bera to residuals and
  Box-Ljung to squared residuals.

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

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`tseries::garch()`](https://rdrr.io/pkg/tseries/man/garch.html), \[\]

Other garch tidiers:
[`tidy.garch()`](https://broom.tidymodels.org/dev/reference/tidy.garch.md)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row and columns:

- AIC:

  Akaike's Information Criterion for the model.

- BIC:

  Bayesian Information Criterion for the model.

- logLik:

  The log-likelihood of the model. \[stats::logLik()\] may be a useful
  reference.

- method:

  Which method was used.

- nobs:

  Number of observations used.

- p.value:

  P-value corresponding to the test statistic.

- statistic:

  Test statistic.

- parameter:

  Parameter field in the htest, typically degrees of freedom.
