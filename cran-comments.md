# Release summary

This is a resubmission following a request to first deprecate removed methods
and send another reminder to maintainers. We have made the requested
changes and carried out another round of reverse dependency checks, notifying
maintainers with unfixed breakages. We note that several remaining breakages
are due to removal of mixed-model tidiers that have been deprecated since broom
0.5.0's release two years ago--we have not reverted these methods back to 
soft-deprecations as their namespace conflicts with the `broom.mixed` package, 
which provides a consistent interface to mixed model tidiers, have caused user 
confusion. More notes on our most recent round of reverse dependency checks
can be found at the bottom of this document.

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

0 NOTES, 0 WARNINGS, 0 ERRORS, aside from a Note_to_CRAN_Maintainers with
the following message:

> Maintainer: 'Alex Hayes <alexpghayes@gmail.com>'

## revdepcheck results

In the initial round of revdepchecks, we checked 149 reverse dependencies, 
comparing R CMD check results across CRAN and dev versions of this package. 
We saw 37 new problems and failed to check one package.

We first notified affected maintainers three weeks prior to our initial
submission, and checked in with maintainers again a week and a half prior. 
Records of our initial outreach attempts can be found on this issue:

https://github.com/tidymodels/broom/issues/862

Since being asked to revert removals to soft-deprecations by the CRAN team on
23 June 2020, we have ran revdepchecks again. 
20 issues remained, and after fixing 3 of them by 
reverting removals to soft-deprecations, 17 remain. Of the 17 remaining issues, 
9 of them have been fixed in development versions and are waiting on the release 
of `broom` 0.7.0 to submit. I've reached out to maintainers for all remaining issues, 
besides `eyetrackingR`, which currently does not have a maintainer. The majority of
remaining issues are due to the planned deprecation of mixed model tidiers to 
`broom.mixed`, initially announced with the release of broom 0.5.0 two years ago.
Records of our most recent revdepchecks, and attempts to reach out to maintainers,
can be found on this issue:

https://github.com/tidymodels/broom/issues/885

