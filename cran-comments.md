# Release summary

This is a resubmission following an automated pretest failure due to
"[n]on-file package-anchored link(s) in documentation object[s]." This seems
to be a new test as of our previous submission, and has been addressed by 
linking to documentation files rather than topics.

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

We checked 149 reverse dependencies, comparing R CMD check results across 
CRAN and dev versions of this package. We saw 37 new problems and failed to 
check one package.

We first notified affected maintainers three weeks ago, and 
checked in with maintainers again a week and a half ago. Records
of our initial outreach attempts can be found on this issue:

https://github.com/tidymodels/broom/issues/862


