
<!-- README.md is generated from README.Rmd. Please edit that file -->

# broom <img src="man/figures/logo.png" align="right" width="100" />

[![CRAN
status](https://www.r-pkg.org/badges/version/broom)](https://cran.r-project.org/package=broom)
[![R build
status](https://github.com/tidymodels/broom/workflows/.github/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/tidymodels/broom/actions)
[![Codecov test
coverage](https://codecov.io/gh/tidymodels/broom/branch/master/graph/badge.svg)](https://codecov.io/gh/tidymodels/broom?branch=master)

## Overview

`broom` summarizes key information about models in tidy `tibble()`s.
`broom` provides three verbs to make it convenient to interact with
model objects:

  - `tidy()` summarizes information about model components
  - `glance()` reports information about the entire model
  - `augment()` adds informations about observations to a dataset

For a detailed introduction, please see `vignette("broom")`.

`broom` tidies 100+ models from popular modelling packages and almost
all of the model objects in the `stats` package that comes with base R.
`vignette("available-methods")` lists method availability.

If you aren’t familiar with tidy data structures and want to know how
they can make your life easier, we highly recommend reading Hadley
Wickham’s [Tidy Data](http://www.jstatsoft.org/v59/i10).

## Installation

``` r
# we recommend installing the entire tidyverse 
# modeling set, which includes broom:
install.packages("tidymodels")

# alternatively, to install just broom:
install.packages("broom")

# to get the development version from GitHub:
install.packages("devtools")
devtools::install_github("tidymodels/broom")
```

If you find a bug, please file a minimal reproducible example in the
[issues](https://github.com/tidymodels/broom/issues).

## Usage

`tidy()` produces a `tibble()` where each row contains information about
an important component of the model. For regression models, this often
corresponds to regression coefficients. This is can be useful if you
want to inspect a model or create custom visualizations.

``` r
library(broom)

fit <- lm(Volume ~ Girth + Height, trees)
tidy(fit)
#> # A tibble: 3 x 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)  -58.0       8.64      -6.71 2.75e- 7
#> 2 Girth          4.71      0.264     17.8  8.22e-17
#> 3 Height         0.339     0.130      2.61 1.45e- 2
```

`glance()` returns a tibble with exactly one row of goodness of fitness
measures and related statistics. This is useful to check for model
misspecification and to compare many models.

``` r
glance(fit)
#> # A tibble: 1 x 12
#>   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
#> 1     0.948         0.944  3.88      255. 1.07e-18     2  -84.5  177.  183.
#> # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>
```

`augment` adds columns to a dataset, containing information such as
fitted values, residuals or cluster assignments. All columns added to a
dataset have `.` prefix to prevent existing columns from being
overwritten.

``` r
augment(fit, data = trees)
#> # A tibble: 31 x 9
#>    Girth Height Volume .fitted .resid .std.resid   .hat .sigma   .cooksd
#>    <dbl>  <dbl>  <dbl>   <dbl>  <dbl>      <dbl>  <dbl>  <dbl>     <dbl>
#>  1   8.3     70   10.3    4.84 -5.46      1.50   0.116    3.79 0.0978   
#>  2   8.6     65   10.3    4.55 -5.75      1.60   0.147    3.77 0.148    
#>  3   8.8     63   10.2    4.82 -5.38      1.53   0.177    3.78 0.167    
#>  4  10.5     72   16.4   15.9  -0.526     0.140  0.0592   3.95 0.000409 
#>  5  10.7     81   18.8   19.9   1.07     -0.294  0.121    3.95 0.00394  
#>  6  10.8     83   19.7   21.0   1.32     -0.370  0.156    3.94 0.00840  
#>  7  11       66   15.6   16.2   0.593    -0.162  0.115    3.95 0.00114  
#>  8  11       75   18.2   19.2   1.05     -0.277  0.0515   3.95 0.00138  
#>  9  11.1     80   22.6   21.4  -1.19      0.321  0.0920   3.95 0.00348  
#> 10  11.2     75   19.9   20.2   0.288    -0.0759 0.0480   3.95 0.0000968
#> # … with 21 more rows
```

### Contributing

We welcome contributions of all types\!

If you have never made a pull request to an R package before, `broom` is
an excellent place to start. Find an
[issue](https://github.com/tidymodels/broom/issues/) with the **Beginner
Friendly** tag and comment that you’d like to take it on and we’ll help
you get started.

We encourage typo corrections, bug reports, bug fixes and feature
requests. Feedback on the clarity of the documentation is especially
valuable.

If you are interested in adding tidier methods for new model objects,
please read [this
article](https://www.tidymodels.org/learn/develop/broom/) on the
tidymodels website.

We have a [Contributor Code of
Conduct](https://github.com/tidymodels/broom/blob/master/.github/CODE_OF_CONDUCT.md).
By participating in `broom` you agree to abide by its terms.
