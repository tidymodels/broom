# Maintaining broom

*October 2025.*

The package is mature and stable, and is up-to-date with spring cleaning
as of Spring 2025. In 2021-2025, Simon prioritized backward
compatibility more-so than in other tidymodels packages, as the package
is very widely adopted and many of its dependencies would not be
discoverable via a reverse dependency check (as it’s used primarily in
applied analyses).

The article `vignettes/articles/maintenance.Rmd` outlines the
maintenance policy of the package since version 1.0.0—namely, “the broom
dev team now asks that attempts to add tidier methods supporting a model
object are directed to the model-owning package.” Vignette
`vignettes/adding-tidiers.Rmd` also notes this (which pre-dated the
1.0.0 release of the package).

## To-do

A number of methods were deprecated in the 0.7.0 release of broom—five
years ago now—and need to be removed completely. Those are contained in
`R/deprecated-0-7-0.R`. Removing them results in double-digit breakages
of reverse dependencies, but they will need to be removed sooner than
later in anticipation of changes in R itself \[TODO: link issue\]. Happy
to help out with the revdep breakages.
