# broom 0.7.4

This is a resubmission following request to notify maintainers of 2 newly broken
packages. We filed notes in the issues trackers of the two affected packages,
rstatix and tadaatoolbox, on January 15th, with notes on the specific causes
for breakages and proposed changes to their codebase:

* https://github.com/tadaadata/tadaatoolbox/issues/33
* https://github.com/kassambara/rstatix/issues/89

While we have not received responses from maintainers of either project, we are
resubmitting now following request on January 12th to fix package breakages 
by January 26th.

## Test environments

- local mac OS  install: R 3.6.3
- mac OS (on github actions): R release
- ubuntu 16.04 (on github actions): R release
- Microsoft Windows Server 2019 10.0.17763 (on github actions), devel, release, 3.6
- win-builder (devel)

## R CMD check results

0 WARNINGS, 0 ERRORS, 0 NOTES.

# Reverse dependencies

We checked 170 reverse dependencies (158 from CRAN + 12 from BioConductor), 
comparing R CMD check results across CRAN and dev versions of this package.
We saw new ERRORs in 2 CRAN packages, rstatix and tadaatoolbox.
