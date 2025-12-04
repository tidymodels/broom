# Tidy a(n) mediate object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'mediate'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  A `mediate` object produced by a call to
  [`mediation::mediate()`](https://rdrr.io/pkg/mediation/man/mediate.html).

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to `FALSE`.

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

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

The tibble has four rows. The first two indicate the mediated effect in
the control and treatment groups, respectively. And the last two the
direct effect in each group.

## See also

[`tidy()`](https://generics.r-lib.org/reference/tidy.html),
[`mediation::mediate()`](https://rdrr.io/pkg/mediation/man/mediate.html)

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

- p.value:

  The two-sided p-value associated with the observed statistic.

- statistic:

  The value of a T-statistic to use in a hypothesis that the regression
  term is non-zero.

- std.error:

  The standard error of the regression term.

- term:

  The name of the regression term.

## Examples

``` r
# load libraries for models and data
library(mediation)
#> mediation: Causal Mediation Analysis
#> Version: 4.5.1
#> 
#> Attaching package: ‘mediation’
#> The following object is masked from ‘package:psych’:
#> 
#>     mediate

data("jobs", package = "mediation")

# fit models
b <- lm(job_seek ~ treat + econ_hard + sex + age, data = jobs)
c <- lm(depress2 ~ treat + job_seek + econ_hard + sex + age, data = jobs)
mod <- mediate(b, c, sims = 50, treat = "treat", mediator = "job_seek")

# summarize model fit with tidiers
tidy(mod)
#> # A tibble: 4 × 4
#>   term   estimate std.error p.value
#>   <chr>     <dbl>     <dbl>   <dbl>
#> 1 acme_0  -0.0152    0.0118    0.24
#> 2 acme_1  -0.0152    0.0118    0.24
#> 3 ade_0   -0.0305    0.0374    0.4 
#> 4 ade_1   -0.0305    0.0374    0.4 
tidy(mod, conf.int = TRUE)
#> # A tibble: 4 × 6
#>   term   estimate std.error p.value conf.low conf.high
#>   <chr>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 acme_0  -0.0152    0.0118    0.24  -0.0374   0.00808
#> 2 acme_1  -0.0152    0.0118    0.24  -0.0374   0.00808
#> 3 ade_0   -0.0305    0.0374    0.4   -0.104    0.0369 
#> 4 ade_1   -0.0305    0.0374    0.4   -0.104    0.0369 
tidy(mod, conf.int = TRUE, conf.level = .99)
#> # A tibble: 4 × 6
#>   term   estimate std.error p.value conf.low conf.high
#>   <chr>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 acme_0  -0.0152    0.0118    0.24  -0.0487    0.0103
#> 2 acme_1  -0.0152    0.0118    0.24  -0.0487    0.0103
#> 3 ade_0   -0.0305    0.0374    0.4   -0.122     0.0405
#> 4 ade_1   -0.0305    0.0374    0.4   -0.122     0.0405
```
