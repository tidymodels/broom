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
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/broom/new/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c init.cpp -o init.o
Wrote C++ file "stan_files/lowrank.cc"
Wrote C++ file "stan_files/exactsizes.cc"
Wrote C++ file "stan_files/lowranksizes.cc"
Wrote C++ file "stan_files/exact.cc"
Error in readRDS("/var/folders/zh/nd9kmnyd2_d_xbwvbx5_7k_00000gn/T//RtmpxKgfbo/file105b37af16b48") : 
  error reading from connection
Calls: .Last -> readRDS
Error in readRDS("/var/folders/zh/nd9kmnyd2_d_xbwvbx5_7k_00000gn/T//RtmpxKgfbo/file105b37af16b48") : 
  error reading from connection
Calls: .Last -> readRDS
Execution halted
Execution halted
Error in readRDS("/var/folders/zh/nd9kmnyd2_d_xbwvbx5_7k_00000gn/T//RtmpxKgfbo/file105b37af16b48") : 
  error reading from connection
Calls: .Last -> readRDS
Execution halted
make: *** [stan_files/lowranksizes.cc] Error 1
make: *** Waiting for unfinished jobs....
make: *** [stan_files/lowrank.cc] Error 1
make: *** [stan_files/exactsizes.cc] Error 1
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
Wrote C++ file "stan_files/exact.cc"
Wrote C++ file "stan_files/exactsizes.cc"
Wrote C++ file "stan_files/lowranksizes.cc"
Wrote C++ file "stan_files/lowrank.cc"
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/exact.cc -o stan_files/exact.o
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/exactsizes.cc -o stan_files/exactsizes.o
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/lowranksizes.cc -o stan_files/lowranksizes.o
clang++ -mmacosx-version-min=10.13 -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/BH/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/Rcpp/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include' -I'/Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include' -I/usr/local/include   -fPIC  -Wall -g -O2  -c stan_files/lowrank.cc -o stan_files/lowrank.o
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
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:13:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
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
In file included from stan_files/lowrank.cc:3:
    #pragma clang diagnostic pop
                             ^
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
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:32:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/CholmodSupport:45:
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
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:22:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigen.h:25:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/RcppEigenForward.h:40:
In file included from /Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
/Users/max/github/broom/revdep/library.noindex/DeLorean/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30    #pragma clang diagnostic pop
                             ^
: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
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
