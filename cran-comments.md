# release summary

broom 0.5.0 is a major new release featuring breaking changes. The main changes are:

- All tidying methods now return tibbles for cleaner print methods and to more consistent behavior
- A new test suite
- A new roxygen template based system for documentation
- Several new tidying methods have been added
- New vignettes
- Many bugfixes

## Test environments

- local windows 8 install: release, oldrel
- travis-ci ubuntu 14.04: devel, release, oldrel
- appveyor windows server 2012: release 
- win-builder: devel, release

## Reverse dependencies

We checked all 92 reverse dependencies by running R CMD check twice, once with the CRAN version installed, and once with this version installed.

TODO

## R CMD check results

There were no ERRORs, WARNINGs or NOTEs.
