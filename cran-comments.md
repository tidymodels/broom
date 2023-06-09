# Reverse dependencies

We checked 227 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package, and saw 1 new breakage. The issue arose in the tipsae package and is expected. We [notified package maintainers of the issue](https://github.com/tidymodels/broom/issues/1160) two weeks ago and have not heard back. The breakage is an error in examples due to the deprecation of tidiers for objects from retiring spatial packages sp and rgeos.
