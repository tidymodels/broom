# Glance at a(n) ergm object

Glance accepts a model object and returns a
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with exactly one row of model summaries. The summaries are typically
goodness of fit measures, p-values for hypothesis tests on residuals, or
model convergence information.

Glance never returns information from the original call to the modeling
function. This includes the name of the modeling function or any
arguments passed to the modeling function.

Glance does not calculate summary measures. Rather, it farms out these
computations to appropriate methods and gathers the results together.
Sometimes a goodness of fit measure will be undefined. In these cases
the measure will be reported as `NA`.

Glance returns the same number of columns regardless of whether the
model matrix is rank-deficient or not. If so, entries in columns that no
longer have a well-defined value are filled in with an `NA` of the
appropriate type.

## Usage

``` r
# S3 method for class 'ergm'
glance(x, deviance = FALSE, mcmc = FALSE, ...)
```

## Arguments

- x:

  An `ergm` object returned from a call to
  [`ergm::ergm()`](https://rdrr.io/pkg/ergm/man/ergm.html).

- deviance:

  Logical indicating whether or not to report null and residual deviance
  for the model, as well as degrees of freedom. Defaults to `FALSE`.

- mcmc:

  Logical indicating whether or not to report MCMC interval, burn-in and
  sample size used to estimate the model. Defaults to `FALSE`.

- ...:

  Additional arguments to pass to
  [`ergm::summary()`](https://rdrr.io/pkg/ergm/man/summary.formula.html).
  **Cautionary note**: Misspecified arguments may be silently ignored.

## Value

`glance.ergm` returns a one-row tibble with the columns

- independence:

  Whether the model assumed dyadic independence

- iterations:

  The number of MCMLE iterations performed before convergence

- logLik:

  If applicable, the log-likelihood associated with the model

- AIC:

  The Akaike Information Criterion

- BIC:

  The Bayesian Information Criterion

If `deviance = TRUE`, and if the model supports it, the tibble will also
contain the columns

- null.deviance:

  The null deviance of the model

- df.null:

  The degrees of freedom of the null deviance

- residual.deviance:

  The residual deviance of the model

- df.residual:

  The degrees of freedom of the residual deviance

## See also

[`glance()`](https://generics.r-lib.org/reference/glance.html),
[`ergm::ergm()`](https://rdrr.io/pkg/ergm/man/ergm.html),
[`ergm::summary.ergm()`](https://rdrr.io/pkg/ergm/man/summary.ergm.html)

Other ergm tidiers:
[`tidy.ergm()`](https://broom.tidymodels.org/dev/reference/tidy.ergm.md)
