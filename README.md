broom: let's tidy up a bit
=====================



[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/broom)](https://CRAN.R-project.org/package=broom)
[![Travis-CI Build Status](https://travis-ci.org/tidyverse/broom.svg?branch=master)](https://travis-ci.org/tidyverse/broom)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/tidyverse/broom?branch=master&svg=true)](https://ci.appveyor.com/project/tidyverse/broom)
[![Coverage Status](https://img.shields.io/codecov/c/github/tidyverse/broom/master.svg)](https://codecov.io/github/tidyverse/broom?branch=master)

The broom package takes the messy output of built-in functions in R, such as `lm`, `nls`, or `t.test`, and turns them into tidy data frames.

The concept of "tidy data", [as introduced by Hadley Wickham](http://www.jstatsoft.org/v59/i10), offers a powerful framework for data manipulation and analysis. That paper makes a convincing statement of the problem this package tries to solve (emphasis mine):

> **While model inputs usually require tidy inputs, such attention to detail doesn't carry over to model outputs. Outputs such as predictions and estimated coefficients aren't always tidy. This makes it more difficult to combine results from multiple models.** For example, in R, the default representation of model coefficients is not tidy because it does not have an explicit variable that records the variable name for each estimate, they are instead recorded as row names. In R, row names must be unique, so combining coefficients from many models (e.g., from bootstrap resamples, or subgroups) requires workarounds to avoid losing important information. **This knocks you out of the flow of analysis and makes it harder to combine the results from multiple models. I'm not currently aware of any packages that resolve this problem.**

broom is an attempt to bridge the gap from untidy outputs of predictions and estimations to the tidy data we want to work with. It centers around three S3 methods, each of which take common objects produced by R statistical functions (`lm`, `t.test`, `nls`, etc) and convert them into a data frame. broom is particularly designed to work with Hadley's [dplyr](https://github.com/hadley/dplyr) package (see the "broom and dplyr" vignette for more).

broom should be distinguished from packages like [reshape2](https://CRAN.R-project.org/package=reshape2) and [tidyr](https://CRAN.R-project.org/package=tidyr), which rearrange and reshape data frames into different forms. Those packages perform critical tasks in tidy data analysis but focus on manipulating data frames in one specific format into another. In contrast, broom is designed to take format that is *not* in a data frame (sometimes not anywhere close) and convert it to a tidy data frame.

Tidying model outputs is not an exact science, and it's based on a judgment of the kinds of values a data scientist typically wants out of a tidy analysis (for instance, estimates, test statistics, and p-values). You may lose some of the information in the original object that you wanted, or keep more information than you need. If you think the tidy output for a model should be changed, or if you're missing a tidying function for an S3 class that you'd like, I strongly encourage you to [open an issue](http://github.com/tidyverse/broom/issues) or a pull request.

Installation and Documentation
------------

The broom package is available on CRAN:

    install.packages("broom")

You can also install the development version of the broom package using [devtools](https://github.com/hadley/devtools):

```
library(devtools)
install_github("tidyverse/broom")
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
##      37.285       -5.344
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
##     Min      1Q  Median      3Q     Max 
## -4.5432 -2.3647 -0.1252  1.4096  6.8727 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  37.2851     1.8776  19.858  < 2e-16 ***
## wt           -5.3445     0.5591  -9.559 1.29e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.046 on 30 degrees of freedom
## Multiple R-squared:  0.7528,	Adjusted R-squared:  0.7446 
## F-statistic: 91.38 on 1 and 30 DF,  p-value: 1.294e-10
```



This summary output is useful enough if you just want to read it. However, converting it to a data frame that contains all the same information, so that you can combine it with other models or do further analysis, is not trivial. You have to do `coef(summary(lmfit))` to get a matrix of coefficients, the terms are still stored in row names, and the column names are inconsistent with other packages (e.g. `Pr(>|t|)` compared to `p.value`).

Instead, you can use the `tidy` function, from the broom package, on the fit:



```r
library(broom)
tidy(lmfit)
```

```
##          term  estimate std.error statistic      p.value
## 1 (Intercept) 37.285126  1.877627 19.857575 8.241799e-19
## 2          wt -5.344472  0.559101 -9.559044 1.293959e-10
```

This gives you a data.frame representation. Note that the row names have been moved into a column called `term`, and the column names are simple and consistent (and can be accessed using `$`).

Instead of viewing the coefficients, you might be interested in the fitted values and residuals for each of the original points in the regression. For this, use `augment`, which augments the original data with information from the model:



```r
head(augment(lmfit))
```

```
##           .rownames  mpg    wt  .fitted   .se.fit     .resid       .hat
## 1         Mazda RX4 21.0 2.620 23.28261 0.6335798 -2.2826106 0.04326896
## 2     Mazda RX4 Wag 21.0 2.875 21.91977 0.5714319 -0.9197704 0.03519677
## 3        Datsun 710 22.8 2.320 24.88595 0.7359177 -2.0859521 0.05837573
## 4    Hornet 4 Drive 21.4 3.215 20.10265 0.5384424  1.2973499 0.03125017
## 5 Hornet Sportabout 18.7 3.440 18.90014 0.5526562 -0.2001440 0.03292182
## 6           Valiant 18.1 3.460 18.79325 0.5552829 -0.6932545 0.03323551
##     .sigma      .cooksd  .std.resid
## 1 3.067494 1.327407e-02 -0.76616765
## 2 3.093068 1.723963e-03 -0.30743051
## 3 3.072127 1.543937e-02 -0.70575249
## 4 3.088268 3.020558e-03  0.43275114
## 5 3.097722 7.599578e-05 -0.06681879
## 6 3.095184 9.210650e-04 -0.23148309
```

Note that each of the new columns begins with a `.` (to avoid overwriting any of the original columns).

Finally, several summary statistics are computed for the entire regression, such as R^2 and the F-statistic. These can be accessed with the `glance` function:



```r
glance(lmfit)
```

```
##   r.squared adj.r.squared    sigma statistic      p.value df    logLik
## 1 0.7528328     0.7445939 3.045882  91.37533 1.293959e-10  2 -80.01471
##        AIC      BIC deviance df.residual
## 1 166.0294 170.4266 278.3219          30
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
##          term estimate std.error statistic     p.value
## 1 (Intercept) 12.04037  4.509706  2.669879 0.007587858
## 2          wt -4.02397  1.436416 -2.801396 0.005088198
```


```r
head(augment(glmfit))
```

```
##           .rownames am    wt    .fitted   .se.fit     .resid       .hat
## 1         Mazda RX4  1 2.620  1.4975684 0.9175750  0.6353854 0.12577908
## 2     Mazda RX4 Wag  1 2.875  0.4714561 0.6761141  0.9848344 0.10816226
## 3        Datsun 710  1 2.320  2.7047594 1.2799233  0.3598458 0.09628500
## 4    Hornet 4 Drive  0 3.215 -0.8966937 0.6012064 -0.8271767 0.07438175
## 5 Hornet Sportabout  0 3.440 -1.8020869 0.7486164 -0.5525972 0.06812194
## 6           Valiant  0 3.460 -1.8825663 0.7669573 -0.5323012 0.06744101
##      .sigma     .cooksd .std.resid
## 1 0.8033182 0.018405616  0.6795582
## 2 0.7897742 0.042434911  1.0428463
## 3 0.8101256 0.003942789  0.3785304
## 4 0.7973421 0.017706938 -0.8597702
## 5 0.8061915 0.006469973 -0.5724389
## 6 0.8067014 0.005901376 -0.5512128
```


```r
glance(glmfit)
```

```
##   null.deviance df.null    logLik      AIC      BIC deviance df.residual
## 1      43.22973      31 -9.588042 23.17608 26.10756 19.17608          30
```

Note that the statistics computed by `glance` are different for `glm` objects than for `lm` (e.g. deviance rather than R^2):

These functions also work on other fits, such as nonlinear models (`nls`):



```r
nlsfit <- nls(mpg ~ k / wt + b, mtcars, start=list(k=1, b=0))
tidy(nlsfit)
```

```
##   term  estimate std.error statistic      p.value
## 1    k 45.829488  4.249155 10.785554 7.639162e-12
## 2    b  4.386254  1.536418  2.854858 7.737378e-03
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
##    .fitted     .resid
## 1 21.87843 -0.8784251
## 2 20.32695  0.6730544
## 3 24.14034 -1.3403437
## 4 18.64115  2.7588507
## 5 17.70878  0.9912203
## 6 17.63177  0.4682291
```


```r
glance(nlsfit)
```

```
##     sigma isConv      finTol    logLik      AIC      BIC deviance
## 1 2.77405   TRUE 2.87694e-08 -77.02329 160.0466 164.4438 230.8606
##   df.residual
## 1          30
```

### Hypothesis testing

The `tidy` function can also be applied to `htest` objects, such as those output by popular built-in functions like `t.test`, `cor.test`, and `wilcox.test`.



```r
tt <- t.test(wt ~ am, mtcars)
tidy(tt)
```

```
##   estimate estimate1 estimate2 statistic     p.value parameter  conf.low
## 1 1.357895  3.768895     2.411  5.493905 6.27202e-06  29.23352 0.8525632
##   conf.high                  method alternative
## 1  1.863226 Welch Two Sample t-test   two.sided
```

Some cases might have fewer columns (for example, no confidence interval):



```r
wt <- wilcox.test(wt ~ am, mtcars)
tidy(wt)
```

```
##   statistic      p.value                                            method
## 1     230.5 4.347026e-05 Wilcoxon rank sum test with continuity correction
##   alternative
## 1   two.sided
```

Since the `tidy` output is already only one row, `glance` returns the same output:



```r
glance(tt)
```

```
##   estimate estimate1 estimate2 statistic     p.value parameter  conf.low
## 1 1.357895  3.768895     2.411  5.493905 6.27202e-06  29.23352 0.8525632
##   conf.high                  method alternative
## 1  1.863226 Welch Two Sample t-test   two.sided
```


```r
glance(wt)
```

```
##   statistic      p.value                                            method
## 1     230.5 4.347026e-05 Wilcoxon rank sum test with continuity correction
##   alternative
## 1   two.sided
```

There is no `augment` function for `htest` objects, since there is no meaningful sense in which a hypothesis test produces output about each initial data point.

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
* `boot`
* `gam`
* `survival`
* `lfe`
* `zoo`
* `multcomp`
* `sp`
* `maps`

A full list of the `tidy`, `augment` and `glance` methods available for each class is as follows:


|Class                    |`tidy` |`glance` |`augment` |
|:------------------------|:------|:--------|:---------|
|aareg                    |x      |x        |          |
|acf                      |x      |         |          |
|anova                    |x      |         |          |
|aov                      |x      |         |          |
|aovlist                  |x      |         |          |
|Arima                    |x      |x        |          |
|betareg                  |x      |x        |x         |
|biglm                    |x      |x        |          |
|binDesign                |x      |x        |          |
|binWidth                 |x      |         |          |
|boot                     |x      |         |          |
|brmsfit                  |x      |         |          |
|btergm                   |x      |         |          |
|cch                      |x      |x        |          |
|character                |x      |         |          |
|cld                      |x      |         |          |
|coeftest                 |x      |         |          |
|confint.glht             |x      |         |          |
|coxph                    |x      |x        |x         |
|cv.glmnet                |x      |x        |          |
|data.frame               |x      |x        |x         |
|default                  |x      |x        |x         |
|density                  |x      |         |          |
|dgCMatrix                |x      |         |          |
|dgTMatrix                |x      |         |          |
|dist                     |x      |         |          |
|ergm                     |x      |x        |          |
|felm                     |x      |x        |x         |
|fitdistr                 |x      |x        |          |
|ftable                   |x      |         |          |
|gam                      |x      |x        |          |
|gamlss                   |x      |         |          |
|geeglm                   |x      |         |          |
|glht                     |x      |         |          |
|glmnet                   |x      |x        |          |
|glmRob                   |x      |x        |x         |
|gmm                      |x      |x        |          |
|htest                    |x      |x        |          |
|kappa                    |x      |         |          |
|kde                      |x      |         |          |
|kmeans                   |x      |x        |x         |
|Line                     |x      |         |          |
|Lines                    |x      |         |          |
|list                     |x      |x        |          |
|lm                       |x      |x        |x         |
|lme                      |x      |x        |x         |
|lmodel2                  |x      |x        |          |
|lmRob                    |x      |x        |x         |
|logical                  |x      |         |          |
|lsmobj                   |x      |         |          |
|manova                   |x      |         |          |
|map                      |x      |         |          |
|matrix                   |x      |x        |          |
|Mclust                   |x      |x        |x         |
|merMod                   |x      |x        |x         |
|mle2                     |x      |         |          |
|multinom                 |x      |x        |          |
|nlrq                     |x      |x        |x         |
|nls                      |x      |x        |x         |
|NULL                     |x      |x        |x         |
|numeric                  |x      |         |          |
|pairwise.htest           |x      |         |          |
|plm                      |x      |x        |x         |
|poLCA                    |x      |x        |x         |
|Polygon                  |x      |         |          |
|Polygons                 |x      |         |          |
|power.htest              |x      |         |          |
|prcomp                   |x      |         |x         |
|pyears                   |x      |x        |          |
|rcorr                    |x      |         |          |
|ref.grid                 |x      |         |          |
|ridgelm                  |x      |x        |          |
|rjags                    |x      |         |          |
|roc                      |x      |         |          |
|rowwise_df               |x      |x        |x         |
|rq                       |x      |x        |x         |
|rqs                      |x      |x        |x         |
|sparseMatrix             |x      |         |          |
|SpatialLinesDataFrame    |x      |         |          |
|SpatialPolygons          |x      |         |          |
|SpatialPolygonsDataFrame |x      |         |          |
|spec                     |x      |         |          |
|stanfit                  |x      |         |          |
|stanreg                  |x      |x        |          |
|summary.glht             |x      |         |          |
|summary.lm               |x      |x        |          |
|summaryDefault           |x      |x        |          |
|survexp                  |x      |x        |          |
|survfit                  |x      |x        |          |
|survreg                  |x      |x        |x         |
|table                    |x      |         |          |
|tbl_df                   |x      |x        |x         |
|ts                       |x      |         |          |
|TukeyHSD                 |x      |         |          |
|zoo                      |x      |         |          |

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

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
