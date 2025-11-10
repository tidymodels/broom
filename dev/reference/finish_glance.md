# (Deprecated) Add logLik, AIC, BIC, and other common measurements to a glance of a prediction

This function is now deprecated in favor of using custom logic and the
appropriate [`nobs()`](https://rdrr.io/r/stats/nobs.html) method.

## Usage

``` r
finish_glance(ret, x)
```

## Arguments

- ret:

  a one-row data frame (a partially complete glance)

- x:

  the prediction model

## Value

a one-row data frame with additional columns added, such as

- logLik:

  log likelihoods

- AIC:

  Akaike Information Criterion

- BIC:

  Bayesian Information Criterion

- deviance:

  deviance

- df.residual:

  residual degrees of freedom

## See also

Other deprecated:
[`bootstrap()`](https://broom.tidymodels.org/dev/reference/bootstrap.md),
[`confint_tidy()`](https://broom.tidymodels.org/dev/reference/confint_tidy.md),
[`data.frame_tidiers`](https://broom.tidymodels.org/dev/reference/data.frame_tidiers.md),
[`fix_data_frame()`](https://broom.tidymodels.org/dev/reference/fix_data_frame.md),
[`summary_tidiers`](https://broom.tidymodels.org/dev/reference/summary_tidiers.md),
[`tidy.density()`](https://broom.tidymodels.org/dev/reference/tidy.density.md),
[`tidy.dist()`](https://broom.tidymodels.org/dev/reference/tidy.dist.md),
[`tidy.ftable()`](https://broom.tidymodels.org/dev/reference/tidy.ftable.md),
[`tidy.numeric()`](https://broom.tidymodels.org/dev/reference/vector_tidiers.md)
