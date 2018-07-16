# release summary

broom 0.5.0 is a major new release featuring breaking changes. The main breaking changes are:

- All tidying methods now return tibbles rather than data frames for cleaner print methods and more consistent behavior.
- Methods for tidying data frames, matrices, and vectors have been deprecated, in favor of other packages such as tibble.
- The bootstrap function has been deprecated in favor of the rsample package.

Other major improvements include:

- A new test suite
- A new roxygen2 template based system for documentation
- Several new tidying methods and vignettes

Additional details may be found in NEWS.md.

## Test environments

- local windows 8 install: release, oldrel
- travis-ci ubuntu 14.04: devel, release, oldrel
- appveyor windows server 2012: release 
- win-builder: devel, release

## R CMD check results

There was 1 NOTE about a URL not in CRAN canonical form. This is because the Github page provides much more information about the project than the CRAN page.

## Reverse dependencies

We checked all 92 reverse dependencies by running R CMD check twice, once with the CRAN version installed, and once with this version installed.

## Couldn't check (5)

|package                                      |version |error |warning |note |
|:--------------------------------------------|:-------|:-----|:-------|:----|
|[crawl](problems.md#crawl)                   |2.1.1   |1     |        |     |
|[miceFast](problems.md#micefast)             |0.2.3   |1     |        |     |
|[nlshelper](problems.md#nlshelper)           |0.2     |1     |        |     |
|[psycho](problems.md#psycho)                 |0.3.4   |1     |        |     |
|[SWMPrExtension](problems.md#swmprextension) |0.3.16  |1     |        |     |

## Broken (10)

|package                                              |version |error    |warning  |note |
|:----------------------------------------------------|:-------|:--------|:--------|:----|
|[biobroom](problems.md#biobroom)                     |1.12.0  |1 __+2__ |2        |3    |
|[ERSA](problems.md#ersa)                             |0.1.0   |1        |1 __+1__ |1    |
|[germinationmetrics](problems.md#germinationmetrics) |0.1.0   |1 __+1__ |2        |     |
|[mice](problems.md#mice)                             |3.1.0   |1 __+1__ |1        |     |
|[nlstimedist](problems.md#nlstimedist)               |1.1.1   |1 __+1__ |1        |     |
|[pcr](problems.md#pcr)                               |1.1.1   |1        |1 __+1__ |     |
|[perccalc](problems.md#perccalc)                     |1.0.1   |1 __+1__ |1 __+1__ |     |
|[survminer](problems.md#survminer)                   |0.4.2   |1        |1 __+1__ |1    |
|[survutils](problems.md#survutils)                   |1.0.1   |1 __+1__ |1        |     |
|[TPP](problems.md#tpp)                               |3.8.2   |1 __+1__ |2        |3    |

- The maintainer of perccalc informs me that an updated version is on the way
- I have not heard from maintainers of any of the other broken packages
- Most issues are related to the switch to tibble output and the deprecation of matrix and vector
  tidiers. These should be easy fixes.

We notified package maintainers of these specific issues introduced to their packages by broom 0.5.0 on June 29. A detailed explanation of breaking changes was made available at https://broom.tidyverse.org/news/.
