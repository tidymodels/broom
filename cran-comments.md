broom 0.4.2
-----------

This is a resubmission now that orcutt 2.0 is on CRAN, which returns a different type of object.

Most important change is fixing behavior with the survival package update. My sincere apologies for taking so long to do so.

## Changes

* Changed `tidy.glmnet` to filter out rows where estimate == 0.
* Updates to `rstanarm` tidiers (thanks to #177 from Jonah Gabry)
* Repo moved; pointing URLs towards tidyverse/broom rather than dgrtwo/broom

### New tidiers

* Added tidiers for `lsmobj` and `ref.grid` objects from the lsmeans package
* Added tidiers for `betareg` objects from the betareg package
* Added tidiers for `lmRob` and `glmRob` objects from the robust package
* Added tidiers for `brms` objects from the brms package (thanks to #149 from Paul Buerkner)

### Bug fixes

* Fixed issue with survival package 2.40-1 (thanks to #180 from Marcus Walz)

## Test environments
* local OS X install, R 3.3.0
* ubuntu 12.04 (on travis-ci), R 3.3.0
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs.
