
<!-- README.md is generated from README.Rmd. Please edit that file -->
broom <img src="man/figures/logo.png" align="right" width="100" height="100" />
===============================================================================

[![CRAN status](https://www.r-pkg.org/badges/version/broom)](https://cran.r-project.org/package=broom) [![Travis-CI Build Status](https://travis-ci.org/tidyverse/broom.svg?branch=master)](https://travis-ci.org/tidyverse/broom) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/tidyverse/broom?branch=master&svg=true)](https://ci.appveyor.com/project/tidyverse/broom) [![Coverage Status](https://img.shields.io/codecov/c/github/tidyverse/broom/master.svg)](https://codecov.io/github/tidyverse/broom?branch=master)

Overview
--------

broom summarizes key information about models in tidy `tibble()`s. broom provides three verbs to make it convenient to interact with model objects:

-   `tidy()` summarizes information about model components
-   `glance()` reports information about the entire model
-   `augment()` adds informations about observations to a dataset

For a detailed introduction, please see `vignette("broom")`.

broom tidies 100+ models from popular modelling packages and almost all of the model objects in the `stats` package that comes with base R. `vignette("available-methods")` lists method availabilty.

If you aren't familiar with tidy data structures and want to know how they can make your life easier, we highly recommend reading Hadley Wickham's [Tidy Data](http://www.jstatsoft.org/v59/i10).

Installation
------------

``` r
# we recommend installing the entire tidyverse, which includes broom:
install.packages("tidyverse")

# alternatively, to install just broom:
install.packages("broom")

# to get the development version from GitHub:
install.packages("devtools")
devtools::install_github("tidyverse/broom")
```

If you find a bug, please file a minimal reproducible example in the [issues](https://github.com/tidyverse/broom/issues).

Usage
-----

`tidy()` produces a `tibble()` where each row contains information about an important component of the model. For regression models, this often corresponds to regression coefficients. This is can be useful if you want to inspect a model or create custom visualizations.

``` r
library(broom)

fit <- lm(Sepal.Width ~ Petal.Length + Petal.Width, iris)
tidy(fit)
#> # A tibble: 3 x 5
#>   term         estimate std.error statistic  p.value
#>   <chr>           <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)     3.59     0.0937     38.3  2.51e-78
#> 2 Petal.Length   -0.257    0.0669     -3.84 1.80e- 4
#> 3 Petal.Width     0.364    0.155       2.35 2.01e- 2
```

`glance()` returns a tibble with exactly one row of goodness of fitness measures and related statistics. This is useful to check for model misspecification and to compare many models.

``` r
glance(fit)
#> # A tibble: 1 x 11
#>   r.squared adj.r.squared sigma statistic p.value    df logLik   AIC   BIC
#> *     <dbl>         <dbl> <dbl>     <dbl>   <dbl> <int>  <dbl> <dbl> <dbl>
#> 1     0.213         0.202 0.389      19.9 2.24e-8     3  -69.8  148.  160.
#> # ... with 2 more variables: deviance <dbl>, df.residual <int>
```

`augment` adds columns to a dataset, containing information such as fitted values, residuals or cluster assignments. All columns added to a dataset have `.` prefix to prevent existing columns from being overwritten.

``` r
augment(fit, data = iris)
#> # A tibble: 150 x 12
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species .fitted
#>  *        <dbl>       <dbl>        <dbl>       <dbl> <fct>     <dbl>
#>  1          5.1         3.5          1.4         0.2 setosa     3.30
#>  2          4.9         3            1.4         0.2 setosa     3.30
#>  3          4.7         3.2          1.3         0.2 setosa     3.33
#>  4          4.6         3.1          1.5         0.2 setosa     3.27
#>  5          5           3.6          1.4         0.2 setosa     3.30
#>  6          5.4         3.9          1.7         0.4 setosa     3.30
#>  7          4.6         3.4          1.4         0.3 setosa     3.34
#>  8          5           3.4          1.5         0.2 setosa     3.27
#>  9          4.4         2.9          1.4         0.2 setosa     3.30
#> 10          4.9         3.1          1.5         0.1 setosa     3.24
#> # ... with 140 more rows, and 6 more variables: .se.fit <dbl>,
#> #   .resid <dbl>, .hat <dbl>, .sigma <dbl>, .cooksd <dbl>,
#> #   .std.resid <dbl>
```

### Contributing

We welcome contributions of all types!

If you have never made a pull request to an R package before, broom is an excellent place to start. Find an [issue](https://github.com/tidyverse/broom/issues/) with the **Beginner Friendly** tag and comment that you'd like to take it on and we'll help you get started.

We encourage typo corrections, bug reports, bug fixes and feature requests. Feedback on the clarity of the documentation is especially valuable.

If you are interested in adding new tidiers methods to broom, please read `vignette("adding-tidiers")`.

We have a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in broom you agree to abide by its terms.
