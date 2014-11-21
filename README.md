broom: let's tidy up a bit
=====================

The broom package takes the messy output of built-in functions in R, such as `lm`, `nls`, or `t.test`, and turns them into tidy data frames.

The concept of "tidy data", [as introduced by Hadley Wickham](http://www.jstatsoft.org/v59/i10), offers a powerful framework for data manipulation and analysis. That paper makes a convincing statement of the problem this package tries to solve (emphasis mine):

> **While model inputs usually require tidy inputs, such attention to detail doesn't carry over to model outputs. Outputs such as predictions and estimated coefficients aren't always tidy. This makes it more difficult to combine results from multiple models.** For example, in R, the default representation of model coefficients is not tidy because it does not have an explicit variable that records the variable name for each estimate, they are instead recorded as row names. In R, row names must be unique, so combining coefficients from many models (e.g., from bootstrap resamples, or subgroups) requires workarounds to avoid losing important information. **This knocks you out of the flow of analysis and makes it harder to combine the results from multiple models. I'm not currently aware of any packages that resolve this problem.**

broom is an attempt to bridge the gap from untidy outputs of predictions and estimations to the tidy data we want to work with. It centers around three S3 methods, each of which take common objects produced by R statistical functions (`lm`, `t.test`, `nls`, etc) and convert them into a data frame. broom is particularly designed to work with Hadley's [dplyr](https://github.com/hadley/dplyr) package (see the "broom and dplyr" vignette for more).

broom should be distinguished from packages like [reshape2](http://cran.r-project.org/web/packages/reshape2/reshape2.pdf) and [tidyr](https://github.com/hadley/tidyr), which rearrange and reshape data frames into different forms. Those packages perform critical tasks in tidy data analysis but focus on manipulating data frames in one specific format into another. In contrast, broom is designed to take format that is *not* in a data frame (sometimes not anywhere close) and convert it to a tidy data frame.

Tidying model outputs is not an exact science, and it's based on a judgment of the kinds of values a data scientist typically wants out of a tidy analysis (for instance, estimates, test statistics, and p-values). You may lose some of the information in the original object that you wanted, or keep more information than you need. If you think the tidy output for a model should be changed, or if you're missing a tidying function for an S3 class that you'd like, I strongly encourage you to [open an issue](http://github.com/dgrtwo/broom/issues) or a pull request.

### Available Tidiers

Currently broom provides tidying methods for many S3 objects from the built-in stats package, including

* `lm`
* `glm`
* `htest`
* `anova`
* `nls`
* `kmeans`
* `manova`
* `TukeyHSD`
* `arima`

It also provides methods for S3 objects in popular third-party packages, including

* `lme4`
* `glmnet`
* `survival`
* `lfe`
* `zoo`
* `multcomp`
* `sp`
* `maps`

Installation and Documentation
------------

You can install the broom package using [devtools](https://github.com/hadley/devtools)

```
library(devtools)
install_github("dgrtwo/broom")
```

For additional documentation, please browse the vignettes:

```
browseVignettes(package="broom")
```

Tidying functions
-----------------

This package provides three S3 methods that do three distinct kinds of tidying.

* `tidy`: constructs a data frame that summarizes the model's statistical findings. This includes coefficients and p-values for each term in a regression, per-cluster information in clustering applications, or per-test information for `multtest` functions.
* `augment`: add columns to the original data that was modeled. This includes predictions, residuals, and cluster assignments.
* `glance`: construct a concise *one-row* summary of the model. This typically contains values such as R^2, adjusted R^2, and residual standard error that are computed once for the entire model.

Note that some classes may have only one or two of these methods defined.

Consider as an illustrative example a linear fit on the built-in `mtcars` dataset.


```r
lmfit <- lm(mpg ~ wt, mtcars)
lmfit
```

```
## 
## Call:
## lm(formula = mpg ~ wt, data = mtcars)
## 
## Coefficients:
## (Intercept)           wt  
##       37.29        -5.34
```

```r
summary(lmfit)
```

```
## 
## Call:
## lm(formula = mpg ~ wt, data = mtcars)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.543 -2.365 -0.125  1.410  6.873 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   37.285      1.878   19.86  < 2e-16 ***
## wt            -5.344      0.559   -9.56  1.3e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.05 on 30 degrees of freedom
## Multiple R-squared:  0.753,	Adjusted R-squared:  0.745 
## F-statistic: 91.4 on 1 and 30 DF,  p-value: 1.29e-10
```

This summary output is useful enough if you just want to read it. However, converting it to a data frame that contains all the same information, so that you can combine it with other models or do further analysis, is not trivial. You have to do `coef(summary(lmfit))` to get a matrix of coefficients, the terms are still stored in row names, and the column names are inconsistent with other packages (e.g. `Pr(>|t|)` compared to `p.value`).

Instead, you can use the `tidy` function, from the broom package, on the fit:


```r
library(broom)
tidy(lmfit)
```

```
##          term estimate std.error statistic   p.value
## 1 (Intercept)   37.285   1.8776    19.858 8.242e-19
## 2          wt   -5.344   0.5591    -9.559 1.294e-10
```

This gives you a data.frame representation. Note that the row names have been moved into a column called `term`, and the column names are simple and consistent (and can be accessed using `$`).

Instead of viewing the coefficients, you might be interested in the fitted values and residuals for each of the original points in the regression. For this, use `augment`, which augments the original data with information from the model:


```r
head(augment(lmfit))
```

```
##           .rownames  mpg    wt    .hat .sigma   .cooksd .fitted  .resid
## 1         Mazda RX4 21.0 2.620 0.04327  3.067 0.0132741   23.28 -2.2826
## 2     Mazda RX4 Wag 21.0 2.875 0.03520  3.093 0.0017240   21.92 -0.9198
## 3        Datsun 710 22.8 2.320 0.05838  3.072 0.0154394   24.89 -2.0860
## 4    Hornet 4 Drive 21.4 3.215 0.03125  3.088 0.0030206   20.10  1.2973
## 5 Hornet Sportabout 18.7 3.440 0.03292  3.098 0.0000760   18.90 -0.2001
## 6           Valiant 18.1 3.460 0.03324  3.095 0.0009211   18.79 -0.6933
##   .stdresid
## 1  -0.76617
## 2  -0.30743
## 3  -0.70575
## 4   0.43275
## 5  -0.06682
## 6  -0.23148
```

Note that each of the new columns begins with a `.` (to avoid overwriting any of the original columns).

Finally, several summary statistics are computed for the entire regression, such as R^2 and the F-statistic. These can be accessed with the `glance` function:


```r
glance(lmfit)
```

```
##   r.squared adj.r.squared sigma statistic   p.value
## 1    0.7528        0.7446 3.046     91.38 1.294e-10
```

This distinction between the `tidy`, `augment` and `glance` functions is explored in a different context in the k-means vignette.

Other Examples
--------------

### Generalized linear and non-linear models

These functions apply equally well to the output from `glm`:


```r
glmfit <- glm(am ~ wt, mtcars, family="binomial")
tidy(glmfit)
```

```
##          term estimate std.error statistic  p.value
## 1 (Intercept)   12.040    4.510     2.670 0.007588
## 2          wt   -4.024    1.436    -2.801 0.005088
```

```r
head(augment(glmfit))
```

```
##           .rownames am    wt    .hat .sigma  .cooksd .fitted  .resid
## 1         Mazda RX4  1 2.620 0.12578 0.8033 0.018406  1.4976  0.6354
## 2     Mazda RX4 Wag  1 2.875 0.10816 0.7898 0.042435  0.4715  0.9848
## 3        Datsun 710  1 2.320 0.09628 0.8101 0.003943  2.7048  0.3598
## 4    Hornet 4 Drive  0 3.215 0.07438 0.7973 0.017707 -0.8967 -0.8272
## 5 Hornet Sportabout  0 3.440 0.06812 0.8062 0.006470 -1.8021 -0.5526
## 6           Valiant  0 3.460 0.06744 0.8067 0.005901 -1.8826 -0.5323
##   .stdresid
## 1    0.6796
## 2    1.0428
## 3    0.3785
## 4   -0.8598
## 5   -0.5724
## 6   -0.5512
```

```r
glance(glmfit)
```

```
##     aic deviance null.deviance df.residual df.null
## 1 23.18    19.18         43.23          30      31
```

Note that the statistics computed by `glance` are different for `glm` objects than for `lm` (e.g. deviance rather than R^2):

These functions also work on other fits, such as nonlinear models (`nls`):


```r
nlsfit <- nls(mpg ~ k / wt + b, mtcars, start=list(k=1, b=0))
tidy(nlsfit)
```

```
##   term estimate std.error statistic   p.value
## 1    k   45.829    4.249    10.786 7.639e-12
## 2    b    4.386    1.536     2.855 7.737e-03
```

```r
head(augment(nlsfit, mtcars))
```

```
##           .rownames  mpg cyl disp  hp drat    wt  qsec vs am gear carb
## 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## 6           Valiant 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
##   .fitted  .resid
## 1   21.88 -0.8784
## 2   20.33  0.6731
## 3   24.14 -1.3403
## 4   18.64  2.7589
## 5   17.71  0.9912
## 6   17.63  0.4682
```

```r
glance(nlsfit)
```

```
##   sigma isConv    finTol
## 1 2.774   TRUE 2.877e-08
```

### Hypothesis testing

The `tidy` function can also be applied to `htest` objects, such as those output by popular built-in functions like `t.test`, `cor.test`, and `wilcox.test`.


```r
tt <- t.test(wt ~ am, mtcars)
tidy(tt)
```

```
##   estimate estimate1 estimate2 statistic   p.value parameter conf.low
## t    1.358     3.769     2.411     5.494 6.272e-06     29.23   0.8526
##   conf.high
## t     1.863
```

Some cases might have fewer columns (for example, no confidence interval):


```r
wt <- wilcox.test(wt ~ am, mtcars)
tidy(wt)
```

```
##   statistic   p.value
## W     230.5 4.347e-05
```

Since the `tidy` output is already only one row, `glance` returns the same output:


```r
glance(tt)
```

```
##   estimate estimate1 estimate2 statistic   p.value parameter conf.low
## t    1.358     3.769     2.411     5.494 6.272e-06     29.23   0.8526
##   conf.high
## t     1.863
```

```r
glance(wt)
```

```
##   statistic   p.value
## W     230.5 4.347e-05
```

There is no `augment` function for `htest` objects, since there is no meaningful sense in which a hypothesis test produces output about each initial data point.

Conventions
------------

In order to maintain consistency, we attempt to follow some conventions regarding the structure of returned data.

### All functions

* The output of the `tidy`, `augment` and `glance` functions is *always* a data frame.
* The output never has rownames. This ensures that you can combine it with other tidy outputs without fear of losing information (since rownames in R cannot contain duplicates).
* Some column names are kept consistent, so that they can be combined across different models and so that you know what to expect (in contrast to asking "is it `pval` or `PValue`?" every time). The examples below are not all the possible column names, nor will all tidy output contain all or even any of these columns.

### tidy functions

* Each row in a `tidy` output typically represents some well-defined concept, such as one term in a regression, one test, or one cluster/class. This meaning varies across models but is usually self-evident. The one thing each row cannot represent is a point in the initial data (for that, use the `augment` method).
* Common column names include:
    * `term`: the term in a regression or model that is being estimated.
    * `p.value`: this spelling was chosen (over common alternatives such as `pvalue`, `PValue`, or `pval`) to be consistent with functions in R's built-in `stats` package
    * `statistic` a test statistic, usually the one used to compute the p-value. Combining these across many sub-groups is a reliable way to perform (e.g.) bootstrap hypothesis testing
    * `estimate` estimate of an effect size, slope, or other value
    * `std.error` standard error
    * `conf.low` the low end of a confidence interval on the `estimate`
    * `conf.high` the high end of a confidence interval on the `estimate`
    * `df` degrees of freedom

### augment functions

* `augment(model, data)` adds columns to the original data.
    * If the `data` argument is missing, `augment` attempts to reconstruct the data from the model (note that this may not always be possible, and usually won't contain columns not used in the model).
* Each row in an `augment` output matches the corresponding row in the original data.
* If the original data contained rownames, `augment` turns them into a column called `.rownames`.
* Newly added column names begin with `.` to avoid overwriting columns in the original data.
* Common column names include:
    * `.fitted`: the predicted values, on the same scale as the data.
    * `.resid`: residuals: the actual y values minus the fitted values
    * `.cluster`: cluster assignments

### glance functions

* `glance` always returns a one-row data frame.
    * The only exception is that `glance(NULL)` returns an empty data frame.
* We avoid including arguments that were *given* to the modeling function. For example, a `glm` glance output does not need to contain a field for `family`, since that is decided by the user calling `glm` rather than the modeling function itself.
* Common column names include:
    * `r.squared` the fraction of variance explained by the model
    * `adj.r.squared` R^2 adjusted based on the degrees of freedom
    * `sigma` the square root of the estimated variance of the residuals
