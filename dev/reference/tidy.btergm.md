# Tidy a(n) btergm object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

This method tidies the coefficients of a bootstrapped temporal
exponential random graph model estimated with the xergm. It simply
returns the coefficients and their confidence intervals.

## Usage

``` r
# S3 method for class 'btergm'
tidy(x, conf.level = 0.95, exponentiate = FALSE, ...)
```

## Arguments

- x:

  A [`btergm::btergm()`](https://rdrr.io/pkg/btergm/man/btergm.html)
  object.

- conf.level:

  Confidence level for confidence intervals. Defaults to 0.95.

- exponentiate:

  Logical indicating whether or not to exponentiate the the coefficient
  estimates. This is typical for logistic and multinomial regressions,
  but a bad idea if there is no log or logit link. Defaults to `FALSE`.

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

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`btergm::btergm()`](https://rdrr.io/pkg/btergm/man/btergm.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- estimate:

  The estimated value of the regression term.

- term:

  The name of the regression term.

## Examples

``` r
library(btergm)
#> Package:  btergm
#> Version:  1.11.1
#> Date:     2025-03-19
#> Authors:  Philip Leifeld (University of Manchester)
#>           Skyler J. Cranmer (The Ohio State University)
#>           Bruce A. Desmarais (Pennsylvania State University)
library(network)
#> 
#> ‘network’ 1.19.0 (2024-12-08), part of the Statnet Project
#> * ‘news(package="network")’ for changes since last version
#> * ‘citation("network")’ for citation information
#> * ‘https://statnet.org’ for help, support, and other information

set.seed(5)

# create 10 random networks with 10 actors
networks <- list()
for (i in 1:10) {
  mat <- matrix(rbinom(100, 1, .25), nrow = 10, ncol = 10)
  diag(mat) <- 0
  nw <- network(mat)
  networks[[i]] <- nw
}

# create 10 matrices as covariates
covariates <- list()
for (i in 1:10) {
  mat <- matrix(rnorm(100), nrow = 10, ncol = 10)
  covariates[[i]] <- mat
}

# fit the model
mod <- btergm(networks ~ edges + istar(2) + edgecov(covariates), R = 100)
#> 
#> Initial dimensions of the network and covariates:
#>                  t=1 t=2 t=3 t=4 t=5 t=6 t=7 t=8 t=9 t=10
#> networks (row)    10  10  10  10  10  10  10  10  10   10
#> networks (col)    10  10  10  10  10  10  10  10  10   10
#> covariates (row)  10  10  10  10  10  10  10  10  10   10
#> covariates (col)  10  10  10  10  10  10  10  10  10   10
#> 
#> All networks are conformable.
#> 
#> Dimensions of the network and covariates after adjustment:
#>                  t=1 t=2 t=3 t=4 t=5 t=6 t=7 t=8 t=9 t=10
#> networks (row)    10  10  10  10  10  10  10  10  10   10
#> networks (col)    10  10  10  10  10  10  10  10  10   10
#> covariates (row)  10  10  10  10  10  10  10  10  10   10
#> covariates (col)  10  10  10  10  10  10  10  10  10   10
#> 
#> Starting pseudolikelihood estimation with 100 bootstrapping replications on a single computing core...
#> Done.

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 3 × 4
#>   term                    estimate conf.low conf.high
#>   <chr>                      <dbl>    <dbl>     <dbl>
#> 1 edges                    -1.23    -1.37      -1.01 
#> 2 istar2                    0.0837  -0.0571     0.165
#> 3 edgecov.covariates[[i]]  -0.0345  -0.177      0.112
```
