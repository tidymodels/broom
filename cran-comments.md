# release summary

broom 0.5.1 is a minor release featuring a single change to clean up CRAN check warnings:

- `tidy()`, `glance()` and `augment()` are now re-exported from the [generics](https://github.com/r-lib/generics) package

This may result in some breakages in packages due to minor changes in the generics signature, but these should be easy to fix.

Additionally, Alex Hayes will take over maintaining the package from David Robinson.

## Test environments

- local windows 8 install: release
- travis-ci ubuntu 14.04: devel, release, oldrel
- appveyor windows server 2012: release 
- win-builder: devel, release

## R CMD check results

There was 1 NOTE due to a change in maintainership.
