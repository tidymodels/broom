broom 0.4.0
-----------

## Changes

* Added tidiers for geeglm, nlrq, roc, boot, bgterm, kappa, binWidth, binDesign, rcorr, stanfit, rjags, gamlss, and mle2 objects.
* Added `tidy` methods for lists, including u, d, v lists from `svd`, and x, y, z lists used by `image` and `persp`
* Added `quick` argument to `tidy.lm`, `tidy.nls`, and `tidy.biglm`, to create a smaller and faster version of the output.
* Changed `rowwise_df_tidiers` to allow the original data to be saved as a list column, then provided as a column name to `augment`. This required removing `data` from the `augment` S3 signature. Also added `tests-rowwise.R`
* Fixed various issues in ANOVA output
* Fixed various issues in lme4 output
* Fixed issues in tests caused by dev version of ggplot2

## Test environments
* local OS X install, R 3.2.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs.

## Reverse dependencies
Broom has seven reverse dependencies in CRAN: AutoModel, dotwhisker, eyetrackingR, forestmodel, HydeNet, pixiedust, and plotly. I ran R CMD CHECK on each with the newest version of broom and found no ERRORs, WARNINGs, or NOTEs.
