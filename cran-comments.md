broom 0.4.1
-----------

## Changes

* Fixed to be compatible with dplyr 0.5, which is being submitted to CRAN
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

## Test environments
* local OS X install, R 3.3.0
* ubuntu 12.04 (on travis-ci), R 3.3.0
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs.

## Reverse dependencies

Broom has seven reverse dependencies in CRAN: AutoModel, cdom, DeLorean, dotwhisker, eyetrackingR, forestmodel, ggpmisc, merTools, pixiedust, StroupGLMM, tadaatoolbox, tidytext, vdmR.

It also has four reverse suggests: eechidna, GGally, macleish, plotly.

I downloaded and ran CHECK on each and none had ERRORs, WARNINGs, or NOTEs related in any way to broom.
