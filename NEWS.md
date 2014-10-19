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
