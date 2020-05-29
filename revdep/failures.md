# miceFast

<details>

* Version: 0.5.1
* Source code: https://github.com/cran/miceFast
* URL: https://github.com/Polkas/miceFast
* BugReports: https://github.com/Polkas/miceFast/issues
* Date/Publication: 2019-08-19 22:50:02 UTC
* Number of recursive dependencies: 104

Run `revdep_details(,"miceFast")` for more info

</details>

## In both

*   checking whether package ‘miceFast’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/max/github/broom/revdep/checks.noindex/miceFast/new/miceFast.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘miceFast’ ...
** package ‘miceFast’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c R_funs.cpp -o R_funs.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c corrData.cpp -o corrData.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c miceFast_additfunc.cpp -o miceFast_additfunc.o
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
make: *** [R_funs.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [miceFast_additfunc.o] Error 1
make: *** [corrData.o] Error 1
make: *** [RcppExports.o] Error 1
ERROR: compilation failed for package ‘miceFast’
* removing ‘/Users/max/github/broom/revdep/checks.noindex/miceFast/new/miceFast.Rcheck/miceFast’

```
### CRAN

```
* installing *source* package ‘miceFast’ ...
** package ‘miceFast’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c R_funs.cpp -o R_funs.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c corrData.cpp -o corrData.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/max/github/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/max/github/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -fopenmp -fPIC  -Wall -g -O2  -c miceFast_additfunc.cpp -o miceFast_additfunc.o
clangclang: error: unsupported option '-fopenmp': clangclang
error: unsupported option '-fopenmp'
: error: error: unsupported option '-fopenmp'
: unsupported option '-fopenmp'
make: *** [RcppExports.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [miceFast_additfunc.o] Error 1
make: *** [corrData.o] Error 1
make: *** [R_funs.o] Error 1
ERROR: compilation failed for package ‘miceFast’
* removing ‘/Users/max/github/broom/revdep/checks.noindex/miceFast/old/miceFast.Rcheck/miceFast’

```
