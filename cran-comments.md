# release summary

broom 0.5.4 is a minor release that removes support for joineRML, which is no longer on CRAN

this is a resubmission that fixes a dead URL and additionally removes support for the robust package, which is now orphaned

## Test environments

- local windows 8 install: release
- travis-ci ubuntu 14.04: devel, release, oldrel
- appveyor windows server 2012: release 
- win-builder: devel, release

## Test results

1 NOTE on some linux systems

  Package suggested but not available for checking: 'rstanarm'

Since rstanarm is still available on CRAN I'm going to assume this is some sort of temporary compiler compatibility issue in rstanarm that I don't need to worry about
