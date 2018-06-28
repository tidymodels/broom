# broom 0.5.0

This is a resubmission to deal with warnings due to undeclared dependencies in tests. It's also a new release, with release notes in NEWS.md.

## Reverse dependencies

This update broke 7 reverse dependencies:

- ERSA
- germinationmetrics
- healthcareai
- mason
- nlstimedist
- pcr
- pixiedust

Five of these packages had only deprecation warnings. Near drop in replacements for the deprecated functions exist in the tibble package. The other two packages broke due to a package-wide change in output type from data.frames to tibbles.

Maintainers of these packages were notified on June 25, 2018.

We were unable to check the pyscho package reverse dependency.

## Test environments

* local windows 8 install: release, oldrel
* travis-ci ubuntu 14.04: devel, release, oldrel
* appveyor windows server 2012: release 
* win-builder: devel, release

## R CMD check results

There were no ERRORs, WARNINGs or NOTEs.
