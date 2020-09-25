# broom 0.7.1 

broom 0.7.1 is a patch release featuring a number of bug fixes following
the 0.7.0 major release.

## Test environments

- local mac OS  install: R 3.6.3
- mac OS (on github actions): R 4.0.2
- ubuntu 16.04 (on github actions), R 4.0.2
- Microsoft Windows Server 2019 10.0.17763 (on github actions), release
- win-builder (devel)

## R CMD check results

0 WARNINGS, 0 ERRORS. Some platforms give 1 NOTE:

```
 checking for future file timestamps ... NOTE
  unable to verify current time
```

This NOTE seems to be a widespread issue.

# Reverse dependencies

We checked 162 reverse dependencies (152 from CRAN + 10 from BioConductor), 
comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 1 new problem
 * We failed to check 1 package
 
The new problem is in the `huxtable` package. We submitted an issue on the
package repository two weeks ago noting the needed fix, and received the 
following response from the package maintainer on September 25th, 2020: 
"Fixed in github. I'll update after you guys release, having updated recently."

More discussion here: https://github.com/hughjonesd/huxtable/issues/186

