broom 0.3.7
-----------

## Changes

* Added tidiers for "plm" (panel linear model) objects from the plm package.
* Added `tidy.coeftest` for coeftest objects from the lmtest package.
* Set up `tidy.lm` to work with "mlm" (multiple linear model) objects (those with multiple response columns).
* Added `tidy` and `glance` for "biglm" and "bigglm" objects from the biglm package.
* Fixed bug in `tidy.coxph` when one-row matrices are returned 
* Added `tidy.power.htest`
* Added `tidy` and `glance` for `summaryDefault` objects
* Added tidiers for "lme" (linear mixed effects models) from the nlme package
* Added `tidy` and `glance` for `multinom` objects from the nnet package.

## Test environments
* local OS X install, R 3.2.0
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. There was one NOTE:

    Possibly mis-spelled words in DESCRIPTION:
      dplyr (17:21)
      ggplot (17:38)
      tidyr (17:28)

These are the names of packages and are correctly spelled.

## Reverse dependencies
Broom has one reverse dependency, radiant. I ran R CMD check on radiant 0.1.83 with broom 0.3.7 and it showed no ERRORs, WARNINGs, or NOTEs.
