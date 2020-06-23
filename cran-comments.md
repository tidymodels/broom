# Release summary

This is a resubmission following a request to first deprecate breaking
changes and send another reminder to maintainers. We have made the requested
changes and carried out another round of reverse dependency checks, notifying
maintainers with unfixed breakages. We note that several remaining breakages
are due to removal of mixed-model tidiers that were deprecated in previous
releases--we have not reverted these methods back to soft-deprecations as
their namespace conflicts with the broom.mixed package, which provides a
consistent interface to mixed model tidiers, have caused user confusion.

The previous submission was also  a resubmission following an automated 
pretest failure due to breaking changes in the `epi.2by2` function from 
the `epiR` package, a new version of which was released on CRAN since 
our previous submission.

The previous submission was also a resubmission following an erroniously 
included Remotes section in the package DESCRIPTION.

The previous submission was also a resubmission following an automated pretest 
failure due to "[n]on-file package-anchored link(s) in documentation 
object[s]." This seemed to be a new test as of our previous submission, 
and has been addressed by linking to documentation files rather than topics.

The previous submission was also a resubmission following an automated pretest 
failure. The failure was due to breaking changes in the `residuals.fixest()` 
S3 method from the `fixest` package, a new version of which was 
released on CRAN the same day as the original submission.

broom 0.7.0 is a major release featuring a number of new S3 methods,
bug fixes, and improvements to internal consistency and performance.
This release also carries out a planned deprecation of a number of
methods to the `broom.mixed` package.

## Test environments

- local mac OS  install: R 4.0.0
- mac OS (on github actions): R 3.6.3
- ubuntu 16.04 (on github actions), R 3.6.3
- Microsoft Windows Server 2019 10.0.17763 (on github actions) devel, release
- win-builder (devel)

## R CMD check results

0 NOTES, 0 WARNINGS, 0 ERRORS

## revdepcheck results

In the initial round of revdepchecks, we checked 149 reverse dependencies, 
comparing R CMD check results across CRAN and dev versions of this package. 
We saw 37 new problems and failed to  check one package.

We first notified affected maintainers three weeks prior to our initial
submission, and checked in with maintainers again a week and a half ago. 
Records of our initial outreach attempts can be found on this issue:

https://github.com/tidymodels/broom/issues/862

Since reverting removals to soft-deprecations, we have ran revdepchecks again.
Records of our outreach with maintainers of packages that are still newly
broken (since 0.5.6) can be found on this issue:






