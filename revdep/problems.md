# allestimates

<details>

* Version: 0.1.6
* Source code: https://github.com/cran/allestimates
* Date/Publication: 2020-02-05 16:30:12 UTC
* Number of recursive dependencies: 73

Run `revdep_details(,"allestimates")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘allestimates-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: all_cox
    > ### Title: Estimates all possible effect estimates using Cox Proportional
    > ###   Hazards regression models
    > ### Aliases: all_cox
    > 
    > ### ** Examples
    > 
    > vlist <- c("Age", "Sex", "Married", "BMI", "Education", "Income")
    > results <- all_cox(crude = "Surv(t0, t1, Endpoint) ~ Diabetes", xlist = vlist, data = diab_df)
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Error in data.frame(variables = "Crude", estimate, conf_low, conf_high,  : 
      arguments imply differing number of rows: 1, 0
    Calls: all_cox -> data.frame
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘MASS’ ‘tibble’
      All declared Imports should be used.
    ```

# arsenal

<details>

* Version: 3.4.0
* Source code: https://github.com/cran/arsenal
* URL: https://github.com/eheinzen/arsenal, https://cran.r-project.org/package=arsenal, https://eheinzen.github.io/arsenal/
* BugReports: https://github.com/eheinzen/arsenal/issues
* Date/Publication: 2020-02-15 19:10:03 UTC
* Number of recursive dependencies: 74

Run `revdep_details(,"arsenal")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > test_check("arsenal")
      ── 1. Error: ordinal works (@test_modelsum.R#213)  ─────────────────────────────
      Must assign to rows with a valid subscript vector.
      ℹ Logical subscripts must match the size of the indexed input.
      ✖ Input has size 8 but subscript `coeffORTidy$coefficient_type == "zeta"` has size 0.
      Backtrace:
        1. testthat::expect_identical(...)
       25. vctrs:::stop_indicator_size(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 427 | SKIPPED: 12 | WARNINGS: 14 | FAILED: 1 ]
      1. Error: ordinal works (@test_modelsum.R#213) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# CGPfunctions

<details>

* Version: 0.6.1
* Source code: https://github.com/cran/CGPfunctions
* URL: https://github.com/ibecav/CGPfunctions
* BugReports: https://github.com/ibecav/CGPfunctions/issues
* Date/Publication: 2020-05-27 18:20:02 UTC
* Number of recursive dependencies: 161

Run `revdep_details(,"CGPfunctions")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### ** Examples
    > 
    > 
    > Plot2WayANOVA(mpg ~ am * cyl, mtcars, plottype = "line")
    
    Converting am to a factor --- check your results
    
    Converting cyl to a factor --- check your results
    Warning: Unknown or uninitialised column: `r.squared`.
    Warning: Unknown or uninitialised column: `r.squared`.
    Warning: Unknown or uninitialised column: `r.squared`.
    Warning: Unknown or uninitialised column: `r.squared`.
    Warning in max(limit1, limit2) :
      no non-missing arguments to max; returning -Inf
    Warning in min(limit1, limit2) :
      no non-missing arguments to min; returning Inf
    Warning: Unknown or uninitialised column: `r.squared`.
    Error in round(model_summary$r.squared, 3) : 
      non-numeric argument to mathematical function
    Calls: Plot2WayANOVA
    Execution halted
    ```

# chest

<details>

* Version: 0.3.1
* Source code: https://github.com/cran/chest
* Date/Publication: 2020-01-29 12:20:02 UTC
* Number of recursive dependencies: 75

Run `revdep_details(,"chest")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Warning: Unknown or uninitialised column: `conf.low`.
    Warning: Unknown or uninitialised column: `conf.high`.
    Error in data.frame(variables, est, lb, ub, Change) : 
      arguments imply differing number of rows: 8, 0
    Calls: chest_cox -> data.frame
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘magrittr’
      All declared Imports should be used.
    ```

# DeLorean

<details>

* Version: 1.5.0
* Source code: https://github.com/cran/DeLorean
* Date/Publication: 2018-10-17 22:30:16 UTC
* Number of recursive dependencies: 118

Run `revdep_details(,"DeLorean")` for more info

</details>

## Newly broken

*   checking whether package ‘DeLorean’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/max/github/broom/revdep/checks.noindex/DeLorean/new/DeLorean.Rcheck/00install.out’ for details.
    ```

## Newly fixed

*   checking installed package size ... NOTE
    ```
      installed size is  7.6Mb
      sub-directories of 1Mb or more:
        libs   4.9Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘lattice’
      All declared Imports should be used.
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

## Installation

### Devel

```
* installing *source* package ‘DeLorean’ ...
** package ‘DeLorean’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exact.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exactsizes.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowrank.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowranksizes.stan
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c init.cpp -o init.o
Wrote C++ file "stan_files/lowrank.cc"
Wrote C++ file "stan_files/exact.cc"
Wrote C++ file "stan_files/exactsizes.cc"
Wrote C++ file "stan_files/lowranksizes.cc"
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/lowrank.cc -o stan_files/lowrank.o
Error in readRDS("/var/folders/zh/nd9kmnyd2_d_xbwvbx5_7k_00000gn/T//RtmphfjD41/file91ed4d1f0548") : 
  error reading from connection
Calls: .Last -> readRDS
Execution halted
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/exact.cc -o stan_files/exact.o
make: *** [stan_files/lowranksizes.cc] Error 1
make: *** Waiting for unfinished jobs....
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/CholmodSupport:45:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/CholmodSupport:45:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:39:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/Polynomials:135:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:39:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/Polynomials:135:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:283:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/gaussian_dlm_obs_rng.hpp:138:7: warning: unused variable 'n' [-Wunused-variable]
  int n = G.rows();  // number of states
      ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:283:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/gaussian_dlm_obs_rng.hpp:138:7: warning: unused variable 'n' [-Wunused-variable]
  int n = G.rows();  // number of states
      ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/columns_dot_self.hpp:8:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/dot_self.hpp:38:41: warning: all paths through this function will call itself [-Winfinite-recursion]
  inline static double square(double x) { return square(x); }
                                        ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/columns_dot_self.hpp:8:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/dot_self.hpp:38:41: warning: all paths through this function will call itself [-Winfinite-recursion]
  inline static double square(double x) { return square(x); }
                                        ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:70:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/integrate_ode_adams.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/cvodes_integrator.hpp:126:18: warning: unused variable 'coupled_size' [-Wunused-variable]
    const size_t coupled_size = cvodes_data.coupled_ode_.size();
                 ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:70:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/integrate_ode_adams.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/cvodes_integrator.hpp:126:18: warning: unused variable 'coupled_size' [-Wunused-variable]
    const size_t coupled_size = cvodes_data.coupled_ode_.size();
                 ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints_nested.hpp:17:13: warning: 'static' function 'set_zero_all_adjoints_nested' declared in header file should be declared 'static inline' [-Wunneeded-internal-declaration]
static void set_zero_all_adjoints_nested() {
            ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:278:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_lpmf.hpp:60:9: warning: unused type alias 'T_partials_vec' [-Wunused-local-typedef]
  using T_partials_vec = typename Eigen::Matrix<T_partials_return, -1, 1>;
        ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:328:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_lpmf.hpp:52:9: warning: unused type alias 'T_alpha_val' [-Wunused-local-typedef]
  using T_alpha_val = typename std::conditional_t<
        ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:27:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_v>::type;
          ^
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:64:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_d>::type;
          ^
In file included from stan_files/exact.cc:3:
stan_files/exact.hpp:390:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
stan_files/exact.hpp:714:24: warning: unused typedef 'local_scalar_t__' [-Wunused-local-typedef]
        typedef double local_scalar_t__;
                       ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints_nested.hpp:17:13: warning: 'static' function 'set_zero_all_adjoints_nested' declared in header file should be declared 'static inline' [-Wunneeded-internal-declaration]
static void set_zero_all_adjoints_nested() {
            ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:278:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_lpmf.hpp:60:9: warning: unused type alias 'T_partials_vec' [-Wunused-local-typedef]
  using T_partials_vec = typename Eigen::Matrix<T_partials_return, -1, 1>;
        ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:328:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_lpmf.hpp:52:9: warning: unused type alias 'T_alpha_val' [-Wunused-local-typedef]
  using T_alpha_val = typename std::conditional_t<
        ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:27:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_v>::type;
          ^
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:64:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_d>::type;
          ^
In file included from stan_files/lowrank.cc:3:
stan_files/lowrank.hpp:485:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
stan_files/lowrank.hpp:864:24: warning: unused typedef 'local_scalar_t__' [-Wunused-local-typedef]
        typedef double local_scalar_t__;
                       ^
28 warnings generated.
28 warnings generated.
rm stan_files/exact.cc stan_files/exactsizes.cc stan_files/lowranksizes.cc stan_files/lowrank.cc
ERROR: compilation failed for package ‘DeLorean’
* removing ‘/Users/max/github/broom/revdep/checks.noindex/DeLorean/new/DeLorean.Rcheck/DeLorean’

```
### CRAN

```
* installing *source* package ‘DeLorean’ ...
** package ‘DeLorean’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exact.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exactsizes.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowrank.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowranksizes.stan
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c init.cpp -o init.o
Wrote C++ file "stan_files/exactsizes.cc"
Wrote C++ file "stan_files/exact.cc"
Wrote C++ file "stan_files/lowranksizes.cc"
Wrote C++ file "stan_files/lowrank.cc"
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/exactsizes.cc -o stan_files/exactsizes.o
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/exact.cc -o stan_files/exact.o
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/lowranksizes.cc -o stan_files/lowranksizes.o
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/lowrank.cc -o stan_files/lowrank.o
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
    #pragma clang diagnostic pop
                             ^
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:11:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/version.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:14:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/CholmodSupport:45:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/CholmodSupport:45:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/CholmodSupport:45:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/CholmodSupport:45:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:39:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/Polynomials:135:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:39:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/Polynomials:135:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:39:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/Polynomials:135:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:39:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/Polynomials:135:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:283:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/gaussian_dlm_obs_rng.hpp:138:7: warning: unused variable 'n' [-Wunused-variable]
  int n = G.rows();  // number of states
      ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:283:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/gaussian_dlm_obs_rng.hpp:138:7: warning: unused variable 'n' [-Wunused-variable]
  int n = G.rows();  // number of states
      ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:283:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/gaussian_dlm_obs_rng.hpp:138:7: warning: unused variable 'n' [-Wunused-variable]
  int n = G.rows();  // number of states
      ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:283:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/gaussian_dlm_obs_rng.hpp:138:7: warning: unused variable 'n' [-Wunused-variable]
  int n = G.rows();  // number of states
      ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/columns_dot_self.hpp:8:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/dot_self.hpp:38:41: warning: all paths through this function will call itself [-Winfinite-recursion]
  inline static double square(double x) { return square(x); }
                                        ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/columns_dot_self.hpp:8:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/dot_self.hpp:38:41: warning: all paths through this function will call itself [-Winfinite-recursion]
  inline static double square(double x) { return square(x); }
                                        ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/columns_dot_self.hpp:8:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/dot_self.hpp:38:41: warning: all paths through this function will call itself [-Winfinite-recursion]
  inline static double square(double x) { return square(x); }
                                        ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:17:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/columns_dot_self.hpp:8:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/dot_self.hpp:38:41: warning: all paths through this function will call itself [-Winfinite-recursion]
  inline static double square(double x) { return square(x); }
                                        ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:70:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/integrate_ode_adams.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/cvodes_integrator.hpp:126:18: warning: unused variable 'coupled_size' [-Wunused-variable]
    const size_t coupled_size = cvodes_data.coupled_ode_.size();
                 ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:70:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/integrate_ode_adams.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/cvodes_integrator.hpp:In file included from 126stan_files/exact.cc::3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:70:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/integrate_ode_adams.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/cvodes_integrator.hpp:126:18: warning: unused variable 'coupled_size' [-Wunused-variable]
18: warning: unused variable 'coupled_size' [-Wunused-variable]
    const size_t coupled_size = cvodes_data.coupled_ode_.size();
                 ^
    const size_t coupled_size = cvodes_data.coupled_ode_.size();
                 ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:70:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/integrate_ode_adams.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/functor/cvodes_integrator.hpp:126:18: warning: unused variable 'coupled_size' [-Wunused-variable]
    const size_t coupled_size = cvodes_data.coupled_ode_.size();
                 ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints_nested.hpp:17:13: warning: 'static' function 'set_zero_all_adjoints_nested' declared in header file should be declared 'static inline' [-Wunneeded-internal-declaration]
static void set_zero_all_adjoints_nested() {
            ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:278:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_lpmf.hpp:60:9: warning: unused type alias 'T_partials_vec' [-Wunused-local-typedef]
  using T_partials_vec = typename Eigen::Matrix<T_partials_return, -1, 1>;
        ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:328:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_lpmf.hpp:52:9: warning: unused type alias 'T_alpha_val' [-Wunused-local-typedef]
  using T_alpha_val = typename std::conditional_t<
        ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:27:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_v>::type;
          ^
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:64:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_d>::type;
          ^
In file included from stan_files/exact.cc:3:
stan_files/exact.hpp:390:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
stan_files/exact.hpp:714:24: warning: unused typedef 'local_scalar_t__' [-Wunused-local-typedef]
        typedef double local_scalar_t__;
                       ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints_nested.hpp:17:13: warning: 'static' function 'set_zero_all_adjoints_nested' declared in header file should be declared 'static inline' [-Wunneeded-internal-declaration]
static void set_zero_all_adjoints_nested() {
            ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:278:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_lpmf.hpp:60:9: warning: unused type alias 'T_partials_vec' [-Wunused-local-typedef]
  using T_partials_vec = typename Eigen::Matrix<T_partials_return, -1, 1>;
        ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:328:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_lpmf.hpp:52:9: warning: unused type alias 'T_alpha_val' [-Wunused-local-typedef]
  using T_alpha_val = typename std::conditional_t<
        ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:27:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_v>::type;
          ^
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:64:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_d>::type;
          ^
In file included from stan_files/exactsizes.cc:3:
stan_files/exactsizes.hpp:390:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
stan_files/exactsizes.hpp:734:24: warning: unused typedef 'local_scalar_t__' [-Wunused-local-typedef]
        typedef double local_scalar_t__;
                       ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints_nested.hpp:17:13: warning: 'static' function 'set_zero_all_adjoints_nested' declared in header file should be declared 'static inline' [-Wunneeded-internal-declaration]
static void set_zero_all_adjoints_nested() {
            ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:278:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_lpmf.hpp:60:9: warning: unused type alias 'T_partials_vec' [-Wunused-local-typedef]
  using T_partials_vec = typename Eigen::Matrix<T_partials_return, -1, 1>;
        ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:328:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_lpmf.hpp:52:9: warning: unused type alias 'T_alpha_val' [-Wunused-local-typedef]
  using T_alpha_val = typename std::conditional_t<
        ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:27:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_v>::type;
          ^
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:64:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_d>::type;
          ^
In file included from stan_files/lowranksizes.cc:3:
stan_files/lowranksizes.hpp:485:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
stan_files/lowranksizes.hpp:901:24: warning: unused typedef 'local_scalar_t__' [-Wunused-local-typedef]
        typedef double local_scalar_t__;
                       ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:46:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:6:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:47:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints_nested.hpp:17:13: warning: 'static' function 'set_zero_all_adjoints_nested' declared in header file should be declared 'static inline' [-Wunneeded-internal-declaration]
static void set_zero_all_adjoints_nested() {
            ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:278:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/dirichlet_lpmf.hpp:60:9: warning: unused type alias 'T_partials_vec' [-Wunused-local-typedef]
  using T_partials_vec = typename Eigen::Matrix<T_partials_return, -1, 1>;
        ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:328:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_log.hpp:5:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/prob/poisson_log_glm_lpmf.hpp:52:9: warning: unused type alias 'T_alpha_val' [-Wunused-local-typedef]
  using T_alpha_val = typename std::conditional_t<
        ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:35:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:27:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_v>::type;
          ^
/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/squared_distance.hpp:64:11: warning: unused type alias 'idx_t' [-Wunused-local-typedef]
    using idx_t = typename index_type<matrix_d>::type;
          ^
In file included from stan_files/lowrank.cc:3:
stan_files/lowrank.hpp:485:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
stan_files/lowrank.hpp:864:24: warning: unused typedef 'local_scalar_t__' [-Wunused-local-typedef]
        typedef double local_scalar_t__;
                       ^
28 warnings generated.
28 warnings generated.
28 warnings generated.
28 warnings generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o DeLorean.so stan_files/exact.o stan_files/exactsizes.o stan_files/lowrank.o stan_files/lowranksizes.o init.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
rm stan_files/exact.cc stan_files/exactsizes.cc stan_files/lowranksizes.cc stan_files/lowrank.cc
installing to /Users/max/github/broom/revdep/checks.noindex/DeLorean/old/DeLorean.Rcheck/00LOCK-DeLorean/00new/DeLorean/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** checking absolute paths in shared objects and dynamic libraries
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (DeLorean)

```
# ERSA

<details>

* Version: 0.1.1
* Source code: https://github.com/cran/ERSA
* Date/Publication: 2018-07-24 11:10:03 UTC
* Number of recursive dependencies: 109

Run `revdep_details(,"ERSA")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘ERSA-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: plotSum
    > ### Title: Plots of model summaries
    > ### Aliases: plotSum plotAnovaStats plottStats plotCIStats
    > 
    > ### ** Examples
    > 
    > plotAnovaStats(lm(mpg ~ wt+hp+disp, data=mtcars))
    > plottStats(lm(mpg ~ wt+hp+disp, data=mtcars))
    Error: No tidy method for objects of class summary.lm
    Execution halted
    ```

# eyetrackingR

<details>

* Version: 0.1.8
* Source code: https://github.com/cran/eyetrackingR
* URL: http://eyetracking-r.com
* BugReports: https://github.com/jwdink/eyetrackingR/issues
* Date/Publication: 2018-12-03 22:00:39 UTC
* Number of recursive dependencies: 80

Run `revdep_details(,"eyetrackingR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > data(word_recognition)
    > data <- make_eyetrackingr_data(word_recognition, 
    +                                participant_column = "ParticipantName",
    +                                trial_column = "Trial",
    +                                time_column = "TimeFromTrialOnset",
    +                                trackloss_column = "TrackLoss",
    +                                aoi_columns = c('Animate','Inanimate'),
    +                                treat_non_aoi_looks_as_missing = TRUE )
    > response_window <- subset_by_window(data, window_start_time = 15500, window_end_time = 21000, 
    +                                     rezero = FALSE)
    Avg. window length in new data will be 5500
    > response_time <- make_time_sequence_data(response_window, time_bin_size = 500, aois = "Animate", 
    +                                          predictor_columns = "Sex")
    > 
    > time_cluster_data <- make_time_cluster_data(data = response_time, predictor_column = "SexM", 
    +                          aoi = "Animate", test = "lmer", 
    +                          threshold = 1.5, 
    +                          formula = LogitAdjusted ~ Sex + (1|Trial) + (1|ParticipantName))
    Error: No tidy method for objects of class lmerMod
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      [31m──[39m [31m2. Error: (unknown) (@test_cluster_analysis.R#88) [39m [31m──────────────────────────[39m
      No tidy method for objects of class lmerMod
      [1mBacktrace:[22m
      [90m  1. [39meyetrackingR::make_time_cluster_data(...)
      [90m 16. [39meyetrackingR:::the_test(...)
      [90m 18. [39mbroom:::tidy.default(res_err_warn$res, effects = "fixed")
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 27 | SKIPPED: 0 | WARNINGS: 4 | FAILED: 2 ]
      1. Error: (unknown) (@test_analyze_time_bins.R#98) 
      2. Error: (unknown) (@test_cluster_analysis.R#88) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# forestmodel

<details>

* Version: 0.5.0
* Source code: https://github.com/cran/forestmodel
* Date/Publication: 2018-04-25 07:53:06 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"forestmodel")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > pretty_lung <- lung %>%
    +   transmute(time,
    +             status,
    +             Age = age,
    +             Sex = factor(sex, labels = c("Male", "Female")),
    +             ECOG = factor(lung$ph.ecog),
    +             `Meal Cal` = meal.cal)
    > 
    > print(forest_model(coxph(Surv(time, status) ~ ., pretty_lung)))
    Error in eval(x$expr, data, x$env) : object 'conf.low' not found
    Calls: print ... eval -> eval -> lapply -> FUN -> lazy_eval -> eval -> eval
    Execution halted
    ```

# ggasym

<details>

* Version: 0.1.4
* Source code: https://github.com/cran/ggasym
* URL: https://github.com/jhrcook/ggasym https://jhrcook.github.io/ggasym/
* BugReports: https://github.com/jhrcook/ggasym/issues
* Date/Publication: 2020-05-31 11:50:02 UTC
* Number of recursive dependencies: 99

Run `revdep_details(,"ggasym")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(ggasym)
      > 
      > test_check("ggasym")
      [31m──[39m [31m1. Failure: stats asymmetrization works (@test-asymmetrise_stats.R#13) [39m [31m─────[39m
      `prepare_data(grps)` did not throw an error.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 266 | SKIPPED: 0 | WARNINGS: 2 | FAILED: 1 ]
      1. Failure: stats asymmetrization works (@test-asymmetrise_stats.R#13) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# glmmfields

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/glmmfields
* URL: https://github.com/seananderson/glmmfields
* BugReports: https://github.com/seananderson/glmmfields/issues
* Date/Publication: 2019-05-18 04:40:03 UTC
* Number of recursive dependencies: 85

Run `revdep_details(,"glmmfields")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘broom::tidyMCMC’
    ```

## In both

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# konfound

<details>

* Version: 0.2.1
* Source code: https://github.com/cran/konfound
* URL: https://github.com/jrosen48/konfound
* BugReports: https://github.com/jrosen48/konfound/issues
* Date/Publication: 2020-02-26 14:50:02 UTC
* Number of recursive dependencies: 112

Run `revdep_details(,"konfound")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    [22mTo sustain an inference, 80.978% of the estimate would have to be due to bias. This is based on a threshold of 0.013 for statistical significance (alpha = 0.05).
    To sustain an inference, 17334 of the cases with 0 effect would have to be replaced with cases at the threshold of inference.
    See Frank et al. (2013) for a description of the method
    [4mCitation:[24m Frank, K.A., Maroulis, S., Duong, M., and Kelcey, B. 2013. What would it take to change an inference? Using Rubin's causal model to interpret the robustness of causal inferences. [3mEducation, Evaluation and Policy Analysis, 35[23m 437-460.
    [1mImpact Threshold for a Confounding Variable:
    [22mThe minimum impact to invalidate an inference for a null hypothesis of 0 effect is based on a correlation of 5.535 with the outcome and at 5.535 with the predictor of interest (conditioning on observed covariates) based on a threshold of 1.003 for statistical significance (alpha = 0.05).
    Correspondingly the impact of an omitted variable (as defined in Frank 2000) must be 5.535 X 5.535 = 30.636 to invalidate an inference for a null hypothesis of 0 effect.
    See Frank (2000) for a description of the method
    [4mCitation:[24m Frank, K. 2000. Impact of a confounding variable on the inference of a regression coefficient. [3mSociological Methods and Research, 29[23m (2), 147-194
    NULL
    > 
    > # using lme4 for mixed effects (or multi-level) models
    > if (requireNamespace("lme4")) {
    +   library(lme4)
    +   m3 <- fm1 <- lme4::lmer(Reaction ~ Days + (1 | Subject), sleepstudy)
    +   konfound(m3, Days)
    + }
    Loading required namespace: lme4
    Loading required package: Matrix
    Error: No tidy method for objects of class lmerMod
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      [31m──[39m [31m2. Error: (unknown) (@test-pkonfound.R#11) [39m [31m─────────────────────────────────[39m
      No tidy method for objects of class lmerMod
      [1mBacktrace:[22m
      [90m 1. [39mkonfound::konfound(testmod2, texp, test_all = TRUE, to_return = "raw_output")
      [90m 2. [39mkonfound:::konfound_lmer(...)
      [90m 4. [39mbroom:::tidy.default(model_object)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 0 | SKIPPED: 0 | WARNINGS: 2 | FAILED: 2 ]
      1. Error: (unknown) (@test-mkonfound.r#12) 
      2. Error: (unknown) (@test-pkonfound.R#11) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘mice’
      All declared Imports should be used.
    ```

# lcsm

<details>

* Version: 0.1.1
* Source code: https://github.com/cran/lcsm
* URL: https://milanwiedemann.github.io/lcsm/
* BugReports: https://github.com/milanwiedemann/lcsm/issues
* Date/Publication: 2020-06-05 10:40:03 UTC
* Number of recursive dependencies: 148

Run `revdep_details(,"lcsm")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    +                                          beta = TRUE, 
    +                                          phi = FALSE),
    +                           model_y = list(alpha_constant = TRUE, 
    +                                          beta = TRUE, 
    +                                          phi = TRUE),
    +                           coupling = list(delta_lag_xy = TRUE, 
    +                                           xi_lag_yx = TRUE)
    +                                           )
    Warning in lav_model_vcov(lavmodel = lavmodel, lavsamplestats = lavsamplestats,  :
      lavaan WARNING:
        The variance-covariance matrix of the estimated parameters (vcov)
        does not appear to be positive definite! The smallest eigenvalue
        (= 3.695231e-16) is close to zero. This may be a symptom that the
        model is not identified.
    > 
    > # Now extract fit statistics  
    > extract_fit(bi_lcsm_01)
    Error in lavInspect(x, "converged") : 
      could not find function "lavInspect"
    Calls: extract_fit ... bind_cols -> list2 -> tibble -> tibble_quos -> eval_tidy
    Execution halted
    ```

# mice

<details>

* Version: 3.9.0
* Source code: https://github.com/cran/mice
* URL: https://github.com/stefvanbuuren/mice, https://stefvanbuuren.name/mice/, https://stefvanbuuren.name/fimd/
* BugReports: https://github.com/stefvanbuuren/mice/issues
* Date/Publication: 2020-05-14 15:20:03 UTC
* Number of recursive dependencies: 84

Run `revdep_details(,"mice")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [1mBacktrace:[22m
      [90m 1. [39mmice::parlmice(nhanes, n.core = 2, n.imp.core = 4)
      [90m 2. [39mparallel::makeCluster(n.core, type = cl.type)
      [90m 3. [39mparallel::makePSOCKcluster(names = spec, ...)
      [90m 4. [39mbase::serverSocket(port = port)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 277 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 4 ]
      1. Error: (unknown) (@test-D3.R#58) 
      2. Error: Warning and Imputations between mice and parlmice are unequal (@test-parlmice.R#5) 
      3. Error: Imputations are equal between mice and parlmice (@test-parlmice.R#13) 
      4. Error: (unknown) (@test-parlmice.R#19) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# moderndive

<details>

* Version: 0.4.0
* Source code: https://github.com/cran/moderndive
* URL: https://github.com/ModernDive/moderndive_package
* BugReports: https://github.com/ModernDive/moderndive_package/issues
* Date/Publication: 2019-11-04 05:40:02 UTC
* Number of recursive dependencies: 119

Run `revdep_details(,"moderndive")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(moderndive)
      > 
      > test_check("moderndive")
      [31m──[39m [31m1. Failure: README code works (@test-get_regression_functions.R#91) [39m [31m────────[39m
      `get_regression_points(mpg_mlr_model2, newdata = newcars)` produced warnings.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 33 | SKIPPED: 11 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: README code works (@test-get_regression_functions.R#91) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘openintro’
    ```

# nlstimedist

<details>

* Version: 1.1.4
* Source code: https://github.com/cran/nlstimedist
* URL: https://github.com/nathaneastwood/nlstimedist
* BugReports: https://github.com/nathaneastwood/nlstimedist/issues
* Date/Publication: 2019-05-15 21:40:03 UTC
* Number of recursive dependencies: 70

Run `revdep_details(,"nlstimedist")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(nlstimedist)
      > 
      > test_check("nlstimedist")
      [31m──[39m [31m1. Failure: Ensure the glance method is returning expected values (@test-glan[39m
      `out` not equal to `expect`.
      Names: 1 string mismatch
      Length mismatch: comparison on first 9 components
      Component 9: Mean relative difference: 0.9308432
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 6 | SKIPPED: 0 | WARNINGS: 2 | FAILED: 1 ]
      1. Failure: Ensure the glance method is returning expected values (@test-glance.timedist.R#17) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# qgcomp

<details>

* Version: 2.3.0
* Source code: https://github.com/cran/qgcomp
* Date/Publication: 2020-04-08 05:50:02 UTC
* Number of recursive dependencies: 116

Run `revdep_details(,"qgcomp")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘broom::finish_glance’
    ```

# radiant.model

<details>

* Version: 1.3.10
* Source code: https://github.com/cran/radiant.model
* URL: https://github.com/radiant-rstats/radiant.model, https://radiant-rstats.github.io/radiant.model, https://radiant-rstats.github.io/docs
* BugReports: https://github.com/radiant-rstats/radiant.model/issues
* Date/Publication: 2020-03-24 09:50:03 UTC
* Number of recursive dependencies: 156

Run `revdep_details(,"radiant.model")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      x[23]: "Nr obs: 2,999"
      y[23]: "Nr obs: 3,000"
      
      SI1     9 114304.420 104924.680 123684.159  9379.739
      sex|male    0.080 -92.0%      -2.522     0.163 -15.447  < .001 ***
      2nd female      0.779 0.712 0.833
      1st female      0.896 0.856 0.926
      1st female 29.000      0.919 0.880 0.945
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 24 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: regress (@test_stats.R#23) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# RCT

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/RCT
* Date/Publication: 2020-05-13 06:20:10 UTC
* Number of recursive dependencies: 78

Run `revdep_details(,"RCT")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > evaluation<-impact_eval(data = data, 
    +                        endogenous_vars = c("y_1", "y_2"), 
    +                        treatment = "treat", 
    +                        heterogenous_vars = c("heterogenous_var1"), 
    +                        cluster_vars = "cluster_var1", fixed_effect_vars = c("fixed_effect_var1"), 
    +                        control_vars = c("control_var1"))
    Warning: Data frame tidiers are deprecated and will be removed in an upcoming release of broom.
    Warning: `data_frame()` is deprecated as of tibble 1.1.0.
    Please use `tibble()` instead.
    [90mThis warning is displayed once every 8 hours.[39m
    [90mCall `lifecycle::last_warnings()` to see where this warning was generated.[39m
    Warning in mean.default(X[[i]], ...) :
      argument is not numeric or logical: returning NA
    Warning in mean.default(X[[i]], ...) :
      argument is not numeric or logical: returning NA
    Warning in var(if (is.vector(x) || is.factor(x)) x else as.double(x), na.rm = na.rm) :
      NAs introduced by coercion
    Error in var(if (is.vector(x) || is.factor(x)) x else as.double(x), na.rm = na.rm) : 
      is.atomic(x) is not TRUE
    Calls: impact_eval ... tibble_quos -> eval_tidy -> vapply -> FUN -> var -> stopifnot
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [31m──[39m [31m1. Error: (unknown) (@test_impact_eval.R#64) [39m [31m───────────────────────────────[39m
      is.atomic(x) is not TRUE
      [1mBacktrace:[22m
      [90m  1. [39mRCT::impact_eval(...)
      [90m 18. [39mbase::vapply(...)
      [90m 19. [39mstats:::FUN(X[[i]], ...)
      [90m 20. [39mstats::var(...)
      [90m 21. [39mbase::stopifnot(is.atomic(x))
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 79 | SKIPPED: 0 | WARNINGS: 5 | FAILED: 1 ]
      1. Error: (unknown) (@test_impact_eval.R#64) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# survminer

<details>

* Version: 0.4.7
* Source code: https://github.com/cran/survminer
* URL: http://www.sthda.com/english/rpkgs/survminer/
* BugReports: https://github.com/kassambara/survminer/issues
* Date/Publication: 2020-05-28 11:40:02 UTC
* Number of recursive dependencies: 118

Run `revdep_details(,"survminer")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘survminer-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: ggforest
    > ### Title: Forest Plot for Cox Proportional Hazards Model
    > ### Aliases: ggforest
    > 
    > ### ** Examples
    > 
    > require("survival")
    Loading required package: survival
    > model <- coxph( Surv(time, status) ~ sex + rx + adhere,
    +                 data = colon )
    > ggforest(model)
    Warning in .get_data(model, data = data) :
      The `data` argument is not provided. Data will be extracted from model fit.
    Error in `[.data.frame`(cbind(allTermsDF, coef[inds, ]), , c("var", "level",  : 
      undefined columns selected
    Calls: ggforest -> [ -> [.data.frame
    Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.3Mb
      sub-directories of 1Mb or more:
        doc   4.8Mb
    ```

# survutils

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/survutils
* URL: https://github.com/tinyheero/survutils
* BugReports: https://github.com/tinyheero/survutils/issues
* Date/Publication: 2018-07-22 17:50:02 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"survutils")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("survutils")
      [31m──[39m [31m1. Failure: get_cox_res runs univariate Cox regression on a single feature (@[39m
      as.data.frame(out_df) not equal to as.data.frame(expected_out_df).
      Names: 1 string mismatch
      Length mismatch: comparison on first 6 components
      Component 6: Modes: character, numeric
      Component 6: target is character, current is numeric
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 6 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: get_cox_res runs univariate Cox regression on a single feature (@test_get_cox_res.R#48) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# sweep

<details>

* Version: 0.2.2
* Source code: https://github.com/cran/sweep
* URL: https://github.com/business-science/sweep
* BugReports: https://github.com/business-science/sweep/issues
* Date/Publication: 2019-10-08 13:50:02 UTC
* Number of recursive dependencies: 143

Run `revdep_details(,"sweep")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > library(forecast)
    > library(sweep)
    > 
    > fit_arima <- WWWusage %>%
    +     auto.arima()
    > 
    > sw_tidy(fit_arima)
    [90m# A tibble: 2 x 2[39m
      term  estimate
      [3m[90m<chr>[39m[23m    [3m[90m<dbl>[39m[23m
    [90m1[39m ar1      0.650
    [90m2[39m ma1      0.526
    > sw_glance(fit_arima)
    Error: 'finish_glance' is not an exported object from 'namespace:broom'
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [90m 1. [39msweep::sw_glance(fit_robets)
      [90m 2. [39msweep:::sw_glance.robets(fit_robets)
      [90m 6. [39mbroom::finish_glance
      [90m 7. [39mbase::getExportedValue(pkg, name)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 146 | SKIPPED: 0 | WARNINGS: 4 | FAILED: 5 ]
      1. Error: sw_*.Arima test returns tibble with correct rows and columns. (@test_tidiers_arima.R#19) 
      2. Error: sw_*.ets test returns tibble with correct rows and columns. (@test_tidiers_ets.R#19) 
      3. Failure: sw_*.default test returns tibble with correct rows and columns. (@test_tidiers_lm.R#22) 
      4. Failure: sw_*.default test returns tibble with correct rows and columns. (@test_tidiers_lm.R#32) 
      5. Error: sw_*.robets test returns tibble with correct rows and columns. (@test_tidiers_robets.R#19) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking Rd cross-references ... WARNING
    ```
    Missing link or links in documentation object 'sw_augment.Rd':
      ‘rowwise_df_tidiers’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘lazyeval’ ‘lubridate’ ‘tidyr’
      All declared Imports should be used.
    Missing or unexported object: ‘broom::finish_glance’
    ```

