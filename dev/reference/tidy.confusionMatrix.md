# Tidy a(n) confusionMatrix object

Tidy summarizes information about the components of a model. A model
component might be a single term in a regression, a single hypothesis, a
cluster, or a class. Exactly what tidy considers to be a model component
varies across models but is usually self-evident. If a model has several
distinct types of components, you will need to specify which components
to return.

## Usage

``` r
# S3 method for class 'confusionMatrix'
tidy(x, by_class = TRUE, ...)
```

## Arguments

- x:

  An object of class `confusionMatrix` created by a call to
  [`caret::confusionMatrix()`](https://rdrr.io/pkg/caret/man/confusionMatrix.html).

- by_class:

  Logical indicating whether or not to show performance measures broken
  down by class. Defaults to `TRUE`. When `by_class = FALSE` only
  returns a tibble with accuracy, kappa, and McNemar statistics.

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
[`caret::confusionMatrix()`](https://rdrr.io/pkg/caret/man/confusionMatrix.html)

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- class:

  The class under consideration.

- conf.high:

  Upper bound on the confidence interval for the estimate.

- conf.low:

  Lower bound on the confidence interval for the estimate.

- estimate:

  The estimated value of the regression term.

- term:

  The name of the regression term.

- p.value:

  P-value for accuracy and kappa statistics.

## Examples

``` r
# load libraries for models and data
library(caret)
#> Loading required package: lattice
#> 
#> Attaching package: ‘lattice’
#> The following object is masked from ‘package:boot’:
#> 
#>     melanoma
#> 
#> Attaching package: ‘caret’
#> The following object is masked from ‘package:survival’:
#> 
#>     cluster
#> The following object is masked from ‘package:purrr’:
#> 
#>     lift

set.seed(27)

# generate data
two_class_sample1 <- as.factor(sample(letters[1:2], 100, TRUE))
two_class_sample2 <- as.factor(sample(letters[1:2], 100, TRUE))

two_class_cm <- confusionMatrix(
  two_class_sample1,
  two_class_sample2
)

# summarize model fit with tidiers
tidy(two_class_cm)
#> # A tibble: 14 × 6
#>    term                 class estimate conf.low conf.high p.value
#>    <chr>                <chr>    <dbl>    <dbl>     <dbl>   <dbl>
#>  1 accuracy             NA      0.52      0.418     0.621   0.619
#>  2 kappa                NA      0.0295   NA        NA      NA    
#>  3 mcnemar              NA     NA        NA        NA       0.470
#>  4 sensitivity          a       0.604    NA        NA      NA    
#>  5 specificity          a       0.426    NA        NA      NA    
#>  6 pos_pred_value       a       0.542    NA        NA      NA    
#>  7 neg_pred_value       a       0.488    NA        NA      NA    
#>  8 precision            a       0.542    NA        NA      NA    
#>  9 recall               a       0.604    NA        NA      NA    
#> 10 f1                   a       0.571    NA        NA      NA    
#> 11 prevalence           a       0.53     NA        NA      NA    
#> 12 detection_rate       a       0.32     NA        NA      NA    
#> 13 detection_prevalence a       0.59     NA        NA      NA    
#> 14 balanced_accuracy    a       0.515    NA        NA      NA    
tidy(two_class_cm, by_class = FALSE)
#> # A tibble: 3 × 5
#>   term     estimate conf.low conf.high p.value
#>   <chr>       <dbl>    <dbl>     <dbl>   <dbl>
#> 1 accuracy   0.52      0.418     0.621   0.619
#> 2 kappa      0.0295   NA        NA      NA    
#> 3 mcnemar   NA        NA        NA       0.470

# multiclass example
six_class_sample1 <- as.factor(sample(letters[1:6], 100, TRUE))
six_class_sample2 <- as.factor(sample(letters[1:6], 100, TRUE))

six_class_cm <- confusionMatrix(
  six_class_sample1,
  six_class_sample2
)

# summarize model fit with tidiers
tidy(six_class_cm)
#> # A tibble: 69 × 6
#>    term           class estimate conf.low conf.high p.value
#>    <chr>          <chr>    <dbl>    <dbl>     <dbl>   <dbl>
#>  1 accuracy       NA      0.2       0.127     0.292   0.795
#>  2 kappa          NA      0.0351   NA        NA      NA    
#>  3 mcnemar        NA     NA        NA        NA       0.873
#>  4 sensitivity    a       0.2      NA        NA      NA    
#>  5 specificity    a       0.888    NA        NA      NA    
#>  6 pos_pred_value a       0.308    NA        NA      NA    
#>  7 neg_pred_value a       0.816    NA        NA      NA    
#>  8 precision      a       0.308    NA        NA      NA    
#>  9 recall         a       0.2      NA        NA      NA    
#> 10 f1             a       0.242    NA        NA      NA    
#> # ℹ 59 more rows
tidy(six_class_cm, by_class = FALSE)
#> # A tibble: 3 × 5
#>   term     estimate conf.low conf.high p.value
#>   <chr>       <dbl>    <dbl>     <dbl>   <dbl>
#> 1 accuracy   0.2       0.127     0.292   0.795
#> 2 kappa      0.0351   NA        NA      NA    
#> 3 mcnemar   NA        NA        NA       0.873
```
