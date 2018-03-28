broom 0.4.4
-----------

* Fixed gam tidiers to work with "Gam" objects, due to an update in gam 1.15. This fixes failing CRAN tests
* Improved test coverage (thanks to #267 from Derek Chiu)

broom 0.4.3
-----------

* Changed the deprecated `dplyr::failwith` to `purrr::possibly`
* `augment` and `glance` on NULLs now return an empty data frame
* Deprecated the `inflate()` function in favor of `tidyr::crossing`
* Fixed confidence intervals in the gmm tidier (thanks to #242 from David Hugh-Jones)
* Fixed a bug in bootstrap tidiers (thanks to #167 from Jeremy Biesanz)
* Fixed tidy.lm with `quick = TRUE` to return terms as character rather than factor (thanks to #191 from Matteo Sostero)
* Added tidiers for `ivreg` objects from the AER package (thanks to #245 from David Hugh-Jones)
* Added tidiers for `survdiff` objects from the survival package (thanks to #147 from Michał Bojanowski)
* Added tidiers for `emmeans` from the emmeans package (thanks to #252 from Matthew Kay)
* Added tidiers for `speedlm` and `speedglm` from the speedglm package (thanks to #248 from David Hugh-Jones)
* Added tidiers for `muhaz` objects from the muhaz package (thanks to #251 from Andreas Bender)
* Added tidiers for `decompose` and `stl` objects from stats (thanks to #165 from Aaron Jacobs)

broom 0.4.2
-----------

* Added tidiers for `lsmobj` and `ref.grid` objects from the lsmeans package
* Added tidiers for `betareg` objects from the betareg package
* Added tidiers for `lmRob` and `glmRob` objects from the robust package
* Added tidiers for `brms` objects from the brms package (thanks to #149 from Paul Buerkner)
* Fixed tidiers for orcutt 2.0
* Changed `tidy.glmnet` to filter out rows where estimate == 0.
* Updates to `rstanarm` tidiers (thanks to #177 from Jonah Gabry)
* Fixed issue with survival package 2.40-1 (thanks to #180 from Marcus Walz)

broom 0.4.1
-----------

* Added AppVeyor, codecov.io, and code of conduct
* Changed name of "NA's" column in summaryDefault output to "na"
* Fixed `tidy.TukeyHSD` to include `term` column. Also added `separate.levels` argument, with option to separate `comparison` into `level1` and `level2`
* Fixed `tidy.manova` to use correct column name for test (previously, always `pillai`)
* Added `kde_tidiers` to tidy kernel density estimates
* Added `orcutt_tidiers` to tidy the results of `cochrane.orcutt` orcutt package
* Added `tidy.dist` to tidy the distance matrix output of `dist` from the stats package
* Added `tidy` and `glance` for `lmodel2` objects from the lmodel2 package
* Added tidiers for `poLCA` objects from the poLCA package
* Added tidiers for sparse matrices from the Matrix package
* Added tidiers for `prcomp` objects
* Added tidiers for `Mclust` objects from the Mclust package
* Added tidiers for `acf` objects
* Fixed to be compatible with dplyr 0.5, which is being submitted to CRAN

broom 0.4.0
-----------

* Added tidiers for geeglm, nlrq, roc, boot, bgterm, kappa, binWidth, binDesign, rcorr, stanfit, rjags, gamlss, and mle2 objects.
* Added `tidy` methods for lists, including u, d, v lists from `svd`, and x, y, z lists used by `image` and `persp`
* Added `quick` argument to `tidy.lm`, `tidy.nls`, and `tidy.biglm`, to create a smaller and faster version of the output.
* Changed `rowwise_df_tidiers` to allow the original data to be saved as a list column, then provided as a column name to `augment`. This required removing `data` from the `augment` S3 signature. Also added `tests-rowwise.R`
* Fixed various issues in ANOVA output
* Fixed various issues in lme4 output
* Fixed issues in tests caused by dev version of ggplot2

broom 0.3.7
-----------

* Added tidiers for "plm" (panel linear model) objects from the plm package.
* Added `tidy.coeftest` for coeftest objects from the lmtest package.
* Set up `tidy.lm` to work with "mlm" (multiple linear model) objects (those with multiple response columns).
* Added `tidy` and `glance` for "biglm" and "bigglm" objects from the biglm package.
* Fixed bug in `tidy.coxph` when one-row matrices are returned 
* Added `tidy.power.htest`
* Added `tidy` and `glance` for `summaryDefault` objects
* Added tidiers for "lme" (linear mixed effects models) from the nlme package
* Added `tidy` and `glance` for `multinom` objects from the nnet package.

broom 0.3.6
-----------

* Fixed bug in `tidy.pairwise.htest`, which now can handle cases where the grouping variable is numeric.
* Added `tidy.aovlist` method. This added `stringr` package to IMPORTS to trim whitespace from the beginning and end of the `term` and `stratum` columns. This also required adjusting `tidy.aov` so that it could handle strata that are missing p-values.
* Set up `glance.lm` to work with `aov` objects along with `lm` objects.
* Added `tidy` and `glance` for matrix objects, with `tidy.matrix` converting a matrix to a data frame with rownames included, and `glance.matrix` returning the same result as `glance.data.frame`.
* Changed DESCRIPTION Authors@R to new format

broom 0.3.5
-----------

* Fixed small bug in `felm` where the `.fitted` and `.resid` columns were matrices rather than vectors.
* Added tidiers for `rlm` (robust linear model) and `gam` (generalized additive model) objects, including adjustments to "lm" tidiers in order to handle them. See `?rlm_tidiers` and `?gam_tidiers` for more.
* Removed rownames from `tidy.cv.glmnet` output

broom 0.3.4
-----------

* The behavior of `augment`, particularly with regard to missing data and the `na.exclude` argument, has through the use of the `augment_columns` function been made consistent across the following models:
    * `lm`
    * `glm`
    * `nls`
    * `merMod` (`lme4`)
    * `survreg` (`survival`)
    * `coxph` (`survival`)

    Unit tests in `tests/testthat/test-augment.R` were added to ensure consistency across these models.
* `tidy`, `augment` and `glance` methods were added for `rowwise_df` objects, and are set up to apply across their rows. This allows for simple patterns such as:
      
        regressions <- mtcars %>% group_by(cyl) %>% do(mod = lm(mpg ~ wt, .))
        regressions %>% tidy(mod)
        regressions %>% augment(mod)
    
    See `?rowwise_df_tidiers` for more.
* Added `tidy` and `glance` methods for `Arima` objects, and `tidy` for `pairwise.htest` objects.
* Fixes for CRAN: change package description to title case, removed NOTES, mostly by adding `globals.R` to declare global variables.
* This is the original version published on CRAN.


broom 0.3
---------

* Tidiers have been added for S3 objects from the following packages:
    * `lme4`
    * `glmnet`
    * `survival`
    * `zoo`
    * `felm`
    * `MASS` (`ridgelm` objects)
* `tidy` and `glance` methods for data.frames have also been added, and `augment.data.frame` produces an error (rather than returning the same data.frame).
* `stderror` has been changed to `std.error` (affects many functions) to be consistent with broom's naming conventions for columns.
* A function `bootstrap` has been added based on [this example](https://github.com/hadley/dplyr/issues/269), to perform the common use case of bootstrapping models.

broom 0.2
---------

* Added "augment" S3 generic and various implementations. "augment" does something different from tidy: it adds columns to the original dataset, including predictions, residuals, or cluster assignments. This was originally described as "fortify" in ggplot2.
* Added "glance" S3 generic and various implementations. "glance" produces a *one-row* data frame summary, which is necessary for tidy outputs with values like R^2 or F-statistics.
* Re-wrote intro broom vignette/README to introduce all three methods.
* Wrote a new kmeans vignette.
* Added tidying methods for multcomp, sp, and map objects (from fortify-multcomp, fortify-sp, and fortify-map from ggplot2).
* Because this integrates substantial amounts of ggplot2 code (with permission), added Hadley Wickham as an author in DESCRIPTION.
