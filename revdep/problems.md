# amt

Version: 0.0.5.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rcpp’ ‘magrittr’
      All declared Imports should be used.
    ```

# autocogs

Version: 0.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘MASS’ ‘broom’ ‘diptest’ ‘ggplot2’ ‘hexbin’ ‘moments’
      All declared Imports should be used.
    ```

# autoimage

Version: 2.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘akima’
    ```

# biobroom

Version: 1.14.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    The following object is masked from 'package:dplyr':
    
        count
    
    Loading required package: BiocParallel
    Warning: package 'BiocParallel' was built under R version 3.5.1
    
    Attaching package: 'DelayedArray'
    
    The following objects are masked from 'package:matrixStats':
    
        colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges
    
    The following objects are masked from 'package:base':
    
        aperm, apply
    
    Quitting from lines 136-141 (biobroom_vignette.Rmd) 
    Error: processing vignette 'biobroom_vignette.Rmd' failed with diagnostics:
    there is no package called 'airway'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘airway’
    ```

*   checking dependencies in R code ... NOTE
    ```
    'library' or 'require' call to ‘DESeq2’ in package code.
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    Missing or unexported object: ‘dplyr::tbl_dt’
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      for ‘colData’
    tidy.deSet: no visible global function definition for ‘exprs<-’
    tidy.deSet: no visible binding for global variable ‘value’
    tidy.deSet: no visible binding for global variable ‘gene’
    tidy.deSet: no visible global function definition for ‘pData’
    tidy.qvalue: no visible binding for global variable ‘smoothed’
    tidy.qvalue: no visible binding for global variable ‘pi0’
    tidy.qvalue: no visible binding for global variable ‘lambda’
    tidy_matrix: no visible binding for global variable ‘value’
    tidy_matrix: no visible binding for global variable ‘gene’
    Undefined global functions or variables:
      . DGEList calcNormFactors colData counts design end estimate
      estimateSizeFactors exprs<- fData<- gene gr is lambda model.matrix
      p.adjust pData pData<- pi0 protein rowRanges sample.id seqnames
      setNames smoothed start tbl_dt term value voom voomWithQualityWeights
    Consider adding
      importFrom("methods", "is")
      importFrom("stats", "end", "model.matrix", "p.adjust", "setNames",
                 "start")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
    contains 'methods').
    ```

# BloodCancerMultiOmics2017

Version: 1.2.0

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is 115.4Mb
      sub-directories of 1Mb or more:
        data     80.0Mb
        doc      26.5Mb
        extdata   8.5Mb
    ```

# breathtestcore

Version: 0.4.5

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘breathteststan’
    ```

# broom.mixed

Version: 0.2.3

## Newly broken

*   checking S3 generic/method consistency ... WARNING
    ```
    augment:
      function(x, data, ...)
    augment.ranef.mer:
      function(x, ci.level, reorder, order.var, ...)
    
    See section ‘Generic functions and methods’ in the ‘Writing R
    Extensions’ manual.
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘glmmADMB’
    ```

# catenary

Version: 1.1.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyverse’
      All declared Imports should be used.
    ```

# ChIPexoQual

Version: 1.6.0

## In both

*   checking whether package ‘ChIPexoQual’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘GenomicAlignments’ was built under R version 3.5.1
      Warning: package ‘BiocGenerics’ was built under R version 3.5.1
      Warning: package ‘S4Vectors’ was built under R version 3.5.1
      Warning: package ‘IRanges’ was built under R version 3.5.1
      Warning: package ‘GenomeInfoDb’ was built under R version 3.5.1
      Warning: package ‘GenomicRanges’ was built under R version 3.5.1
      Warning: package ‘SummarizedExperiment’ was built under R version 3.5.1
      Warning: package ‘Biobase’ was built under R version 3.5.1
      Warning: package ‘DelayedArray’ was built under R version 3.5.1
      Warning: package ‘BiocParallel’ was built under R version 3.5.1
      Warning: package ‘Biostrings’ was built under R version 3.5.1
      Warning: package ‘XVector’ was built under R version 3.5.1
      Warning: package ‘Rsamtools’ was built under R version 3.5.1
    See ‘/Users/max/github/forks/broom/revdep/checks.noindex/ChIPexoQual/new/ChIPexoQual.Rcheck/00install.out’ for details.
    ```

# crawl

Version: 2.2.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘gdistance’ ‘raster’
      All declared Imports should be used.
    ```

# DeclareDesign

Version: 0.12.0

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(DeclareDesign)
      Loading required package: randomizr
      Loading required package: fabricatr
      Loading required package: estimatr
      > 
      > test_check("DeclareDesign")
      ── 1. Failure: gam (@test-model.R#247)  ────────────────────────────────────────
      `expect_equal(ncol(draw_estimates(des)), 7)` did not produce any warnings.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 456 SKIPPED: 5 FAILED: 1
      1. Failure: gam (@test-model.R#247) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# DEGreport

Version: 1.18.0

## In both

*   checking for hidden files and directories ... NOTE
    ```
    Found the following hidden files and directories:
      .travis.yml
    These were most likely included in error. See section ‘Package
    structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Package listed in more than one of Depends, Imports, Suggests, Enhances:
      ‘knitr’
    A package should be listed in only one of these fields.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
    degMV: no visible binding for global variable ‘max_sd’
    degPatterns: no visible global function definition for ‘rowMedians’
    degPatterns: no visible binding for global variable ‘genes’
    degPatterns: no visible global function definition for ‘n’
    degPlotCluster: no visible binding for global variable ‘genes’
    degPlotCluster: no visible binding for global variable ‘cluster’
    degPlotWide : <anonymous>: no visible binding for global variable
      ‘count’
    significants,TopTags: no visible binding for global variable ‘FDR’
    significants,TopTags: no visible binding for global variable ‘logFC’
    significants,list : <anonymous>: no visible binding for global variable
      ‘gene’
    Undefined global functions or variables:
      .x FDR base_mean boxplot cluster comp compare count counts covar desc
      enrichGO fdr gene genes itemConsensus k keys lm log2FoldChange log2fc
      logFC max_sd min_median n p.value r ratios rowMedians score simplify
      value_fc value_fdr x xend y yend
    Consider adding
      importFrom("graphics", "boxplot")
      importFrom("stats", "lm")
    to your NAMESPACE file.
    ```

# DeLorean

Version: 1.5.0

## Newly broken

*   checking whether package ‘DeLorean’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/max/github/forks/broom/revdep/checks.noindex/DeLorean/new/DeLorean.Rcheck/00install.out’ for details.
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
** libs
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exact.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exactsizes.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowrank.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowranksizes.stan
Wrote C++ file "stan_files/exact.cc"
Wrote C++ file "stan_files/exactsizes.cc"
Wrote C++ file "stan_files/lowranksizes.cc"
Wrote C++ file "stan_files/lowrank.cc"
/usr/local/clang4/bin/clang++ -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/BH/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/Rcpp/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c init.cpp -o init.o
Error in readRDS("/var/folders/lb/xhxqmcrd7gv302_b1pdfykh80000gn/T//RtmpyH4Ycx/file1276123f7b004") : 
  error reading from connection
Calls: .Last -> readRDS
Execution halted
/usr/local/clang4/bin/clang++ -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/BH/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/Rcpp/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c stan_files/exact.cc -o stan_files/exact.o
make: *** [stan_files/lowrank.cc] Error 1
make: *** Waiting for unfinished jobs....
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:44:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:70:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/autocorrelation.hpp:18:8: warning: function 'fft_next_good_size' is not needed and will not be emitted [-Wunneeded-internal-declaration]
size_t fft_next_good_size(size_t N) {
       ^
In file included from stan_files/exact.cc:3:
stan_files/exact.hpp:397:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
16 warnings generated.
rm stan_files/exact.cc stan_files/exactsizes.cc stan_files/lowranksizes.cc stan_files/lowrank.cc
ERROR: compilation failed for package ‘DeLorean’
* removing ‘/Users/max/github/forks/broom/revdep/checks.noindex/DeLorean/new/DeLorean.Rcheck/DeLorean’

```
### CRAN

```
* installing *source* package ‘DeLorean’ ...
** package ‘DeLorean’ successfully unpacked and MD5 sums checked
** libs
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exact.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/exactsizes.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowrank.stan
"/Library/Frameworks/R.framework/Resources/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/lowranksizes.stan
Wrote C++ file "stan_files/exact.cc"
Wrote C++ file "stan_files/exactsizes.cc"
Wrote C++ file "stan_files/lowranksizes.cc"
Wrote C++ file "stan_files/lowrank.cc"
/usr/local/clang4/bin/clang++ -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/BH/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/Rcpp/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c init.cpp -o init.o
/usr/local/clang4/bin/clang++ -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/BH/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/Rcpp/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c stan_files/exact.cc -o stan_files/exact.o
/usr/local/clang4/bin/clang++ -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/BH/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/Rcpp/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c stan_files/exactsizes.cc -o stan_files/exactsizes.o
/usr/local/clang4/bin/clang++ -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/BH/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/Rcpp/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c stan_files/lowranksizes.cc -o stan_files/lowranksizes.o
/usr/local/clang4/bin/clang++ -std=gnu++14 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"`"/Library/Frameworks/R.framework/Resources/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/BH/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/Rcpp/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include" -I"/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c stan_files/lowrank.cc -o stan_files/lowrank.o
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hppIn file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
:In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU::
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:447:
:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop:1:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535
                             ^
:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
47:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:1:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Core:535:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from In file included from stan_files/exactsizes.hpp:25:
stan_files/exact.ccIn file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:7:
In file included from :34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp::
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues4:58:
:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:2:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/LU:47:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Jacobi:29:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Cholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14In file included from :
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/QR:17:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Householder:27:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning58:
: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h    #pragma clang diagnostic pop
                             ^
:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:5:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SVD:48:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Geometry:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:14:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/matrix_vari.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat/fun/Eigen_NumTraits.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/Eigen.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Dense:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Eigenvalues:58:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hppIn file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30    #pragma clang diagnostic pop
                             ^
: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30:In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:2534:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:
:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96In file included from :
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
:/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:

    #pragma clang diagnostic pop
                             ^
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:26:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCore:66:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:27:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/OrderingMethods:71:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:29:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseCholesky:43:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:32:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/SparseQR:35:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:96:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/csr_extract_u.hpp:6:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/Sparse:33:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:44:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/exact.cc:3:
In file included from stan_files/exact.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:70:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/autocorrelation.hpp:18:8: warning: function 'fft_next_good_size' is not needed and will not be emitted [-Wunneeded-internal-declaration]
size_t fft_next_good_size(size_t N) {
       ^
In file included from stan_files/exact.cc:3:
stan_files/exact.hpp:397:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:44:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/exactsizes.cc:3:
In file included from stan_files/exactsizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:70:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/autocorrelation.hpp:18:8: warning: function 'fft_next_good_size' is not needed and will not be emitted [-Wunneeded-internal-declaration]
size_t fft_next_good_size(size_t N) {
       ^
In file included from stan_files/exactsizes.cc:3:
stan_files/exactsizes.hpp:397:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:44:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/lowranksizes.cc:3:
In file included from stan_files/lowranksizes.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:70:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/autocorrelation.hpp:18:8: warning: function 'fft_next_good_size' is not needed and will not be emitted [-Wunneeded-internal-declaration]
size_t fft_next_good_size(size_t N) {
       ^
In file included from stan_files/lowranksizes.cc:3:
stan_files/lowranksizes.hpp:495:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core.hpp:44:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/core/set_zero_all_adjoints.hpp:14:13: warning: unused function 'set_zero_all_adjoints' [-Wunused-function]
static void set_zero_all_adjoints() {
            ^
In file included from stan_files/lowrank.cc:3:
In file included from stan_files/lowrank.hpp:25:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/rstaninc.hpp:3:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/rstan/include/rstan/stan_fit.hpp:34:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/test_gradients.hpp:7:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/rev/mat.hpp:12:
In file included from /Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat.hpp:70:
/Users/max/github/forks/broom/revdep/library.noindex/DeLorean/StanHeaders/include/stan/math/prim/mat/fun/autocorrelation.hpp:18:8: warning: function 'fft_next_good_size' is not needed and will not be emitted [-Wunneeded-internal-declaration]
size_t fft_next_good_size(size_t N) {
       ^
In file included from stan_files/lowrank.cc:3:
stan_files/lowrank.hpp:495:30: warning: unused typedef 'fun_return_scalar_t__' [-Wunused-local-typedef]
    typedef local_scalar_t__ fun_return_scalar_t__;
                             ^
16 warnings generated.
16 warnings generated.
16 warnings generated.
16 warnings generated.
/usr/local/clang4/bin/clang++ -std=gnu++14 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/clang4/lib -o DeLorean.so stan_files/exact.o stan_files/exactsizes.o stan_files/lowrank.o stan_files/lowranksizes.o init.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: text-based stub file /System/Library/Frameworks//CoreFoundation.framework/CoreFoundation.tbd and library file /System/Library/Frameworks//CoreFoundation.framework/CoreFoundation are out of sync. Falling back to library file for linking.
rm stan_files/exact.cc stan_files/exactsizes.cc stan_files/lowranksizes.cc stan_files/lowrank.cc
installing to /Users/max/github/forks/broom/revdep/checks.noindex/DeLorean/old/DeLorean.Rcheck/DeLorean/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded
* DONE (DeLorean)

```
# disto

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dplyr’ ‘proxy’
      All declared Imports should be used.
    ```

# DLMtool

Version: 5.2.3

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        R      2.0Mb
        data   2.1Mb
    ```

# eechidna

Version: 1.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.4Mb
      sub-directories of 1Mb or more:
        data   5.1Mb
        doc    1.2Mb
    ```

# enviGCMS

Version: 0.5.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘BiocParallel’ ‘broom’ ‘reshape2’ ‘rmarkdown’
      All declared Imports should be used.
    ```

# eurostat

Version: 3.3.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 595 marked UTF-8 strings
    ```

# eyetrackingR

Version: 0.1.7

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
      ...
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning: Removed 37 rows containing non-finite values (stat_summary).
    Warning in make_onset_data(response_window_clean, onset_time = 15500, fixation_window_length = 1,  :
      Very few trials have a legitimate first AOI! Possible incorrect onset time?
    Warning in max(SwitchAOI) :
      no non-missing arguments to max; returning -Inf
    Warning in min(SwitchAOI) :
      no non-missing arguments to min; returning Inf
    Warning in max(df_plot$.Time) :
      no non-missing arguments to max; returning -Inf
    Quitting from lines 91-93 (onset_contingent_analysis_vignette.Rmd) 
    Error: processing vignette 'onset_contingent_analysis_vignette.Rmd' failed with diagnostics:
    replacement has 1 row, data has 0
    Execution halted
    ```

# fivethirtyeight

Version: 0.4.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘fivethirtyeight’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.4Mb
      sub-directories of 1Mb or more:
        data   5.4Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1616 marked UTF-8 strings
    ```

# forestmangr

Version: 0.9.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘covr’ ‘curl’ ‘graphics’ ‘htmltools’ ‘psych’ ‘rmarkdown’ ‘scales’
      All declared Imports should be used.
    ```

# germinationmetrics

Version: 0.1.2

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    tlmgr install fancyhdr
    tlmgr: package repository http://mirror.utexas.edu/ctan/systems/texlive/tlnet (not verified: gpg unavailable)
    [1/1, ??:??/??:??] install: fancyhdr [4k]
    running mktexlsr ...
    done running mktexlsr.
    tlmgr: package log updated: /Users/max/Library/TinyTeX/texmf-var/web2c/tlmgr.log
    tlmgr path add
    tlmgr search --file --global '/wrapfig.sty'
    Trying to automatically install missing LaTeX packages...
    tlmgr install wrapfig
    tlmgr: package repository http://mirror.utexas.edu/ctan/systems/texlive/tlnet (not verified: gpg unavailable)
    [1/1, ??:??/??:??] install: wrapfig [10k]
    running mktexlsr ...
    done running mktexlsr.
    tlmgr: package log updated: /Users/max/Library/TinyTeX/texmf-var/web2c/tlmgr.log
    tlmgr path add
    ! LaTeX Error: Option clash for package xcolor.
    
    Error: processing vignette 'Introduction.Rmd' failed with diagnostics:
    Failed to compile Introduction.tex. See Introduction.log for more info.
    Execution halted
    ```

# ggformula

Version: 0.9.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyr’
      All declared Imports should be used.
    ```

# ggpmisc

Version: 0.3.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘gginnards’
    ```

# ggstatsplot

Version: 0.0.6

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is  5.3Mb
      sub-directories of 1Mb or more:
        doc    2.6Mb
        help   2.3Mb
    ```

# glmmfields

Version: 0.1.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    Error in re-building vignettes:
      ...
    Loading required package: Rcpp
    
    Attaching package: 'dplyr'
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, setequal, union
    
    Waiting for profiling to be done...
    trying deprecated constructor; please alert package maintainer
    error occurred during calling the sampler; sampling not done
    Quitting from lines 134-135 (spatial-glms.Rmd) 
    Error: processing vignette 'spatial-glms.Rmd' failed with diagnostics:
    incorrect number of dimensions
    Execution halted
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# healthcareai

Version: 2.2.0

## Newly fixed

*   checking whether package ‘healthcareai’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import ‘recipes::tidy’ by ‘broom::tidy’ when loading ‘healthcareai’
    See ‘/Users/max/github/forks/broom/revdep/checks.noindex/healthcareai/old/healthcareai.Rcheck/00install.out’ for details.
    ```

## In both

*   checking examples ... ERROR
    ```
    ...
    Running examples in ‘healthcareai-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: evaluate
    > ### Title: Get model performance metrics
    > ### Aliases: evaluate evaluate.predicted_df evaluate.model_list
    > 
    > ### ** Examples
    > 
    > models <- machine_learn(pima_diabetes[1:40, ],
    +                        patient_id,
    +                        outcome = diabetes,
    +                        models = c("XGB", "RF"),
    +                        tune = FALSE,
    +                        n_folds = 3)
    Training new data prep recipe...
    
    Error in lapply(newdata[vars], function(x) { : 
      argument "newdata" is missing, with no default
    Calls: machine_learn ... <Anonymous> -> prep.recipe -> bake -> bake.step_missing -> lapply
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat-5.R’ failed.
    Last 13 lines of output:
      3: recipes::prep(recipe, training = d)
      4: prep.recipe(recipe, training = d)
      5: bake(x$steps[[i]], new_data = training)
      6: bake.step_missing(x$steps[[i]], new_data = training)
      7: lapply(newdata[vars], function(x) {
             levels(x) <- c(levels(x), "missing")
             x
         })
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 0 SKIPPED: 0 FAILED: 1
      1. Error: the fundamentals work (@test-cran_only.R#4) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# highcharter

Version: 0.5.0

## Newly broken

*   R CMD check timed out
    

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 16.5Mb
      sub-directories of 1Mb or more:
        doc          13.7Mb
        htmlwidgets   1.8Mb
    ```

# huxtable

Version: 4.3.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      7: withVisible(code)
      8: eval_bare(get_expr(quo), get_env(quo))
      9: quick_pdf(m, dfr, ht, file = tf, height = "4in")
      10: tools::texi2pdf(latex_file, clean = TRUE)
      11: texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet, texi2dvi = texi2dvi, 
             texinputs = texinputs, index = index)
      12: stop(msg, domain = NA)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 841 SKIPPED: 57 FAILED: 2
      1. Error: quick_pdf works (@test-quick-output.R#41) 
      2. Error: quick_pdf works with height and width options (@test-quick-output.R#53) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# jtools

Version: 1.1.1

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘wec’, ‘rockchalk’, ‘pequod’, ‘piecewiseSEM’
    ```

# lucid

Version: 1.6

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Loading required package: lucid
    Loading required package: lattice
    Loading required package: rjags
    Loading required package: coda
    Error: package or namespace load failed for 'rjags':
     .onLoad failed in loadNamespace() for 'rjags', details:
      call: dyn.load(file, DLLpath = DLLpath, ...)
      error: unable to load shared object '/Users/max/github/forks/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so':
      dlopen(/Users/max/github/forks/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so, 10): Library not loaded: /usr/local/lib/libjags.4.dylib
      Referenced from: /Users/max/github/forks/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so
      Reason: image not found
    Quitting from lines 271-295 (lucid_examples.Rmd) 
    Error: processing vignette 'lucid_examples.Rmd' failed with diagnostics:
    could not find function "jags.model"
    Execution halted
    ```

# MARSS

Version: 3.10.10

## In both

*   checking re-building of vignette outputs ... NOTE
    ```
    Error in re-building vignettes:
      ...
    Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
      Running 'texi2dvi' on 'EMDerivation.tex' failed.
    LaTeX errors:
    ! LaTeX Error: File `ae.sty' not found.
    
    Type X to quit or <RETURN> to proceed,
    or enter new name. (Default extension: sty)
    
    ! Emergency stop.
    <read *> 
             
    l.30 \ifthenelse
                    {\boolean{Sweave@inconsolata}}{%^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    Calls: buildVignettes -> texi2pdf -> texi2dvi
    Execution halted
    ```

# mason

Version: 0.2.6

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘pixiedust’
    ```

# mosaic

Version: 1.4.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    
    Using parallel package.
      * Set seed with set.rseed().
      * Disable this message with options(`mosaic:parallelMessage` = FALSE)
    
    Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
      Running 'texi2dvi' on 'Resampling.tex' failed.
    LaTeX errors:
    ! LaTeX Error: File `xstring.sty' not found.
    
    Type X to quit or <RETURN> to proceed,
    or enter new name. (Default extension: sty)
    
    ! Emergency stop.
    <read *> 
             
    l.5 \RequirePackage
                       {xcolor}^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    Calls: buildVignettes -> texi2pdf -> texi2dvi
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘manipulate’
    ```

# MPTmultiverse

Version: 0.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      3: getExportedValue(pkg, name)
      4: asNamespace(ns)
      5: getNamespace(ns)
      6: tryCatch(loadNamespace(name), error = function(e) stop(e))
      7: tryCatchList(expr, classes, parentenv, handlers)
      8: tryCatchOne(expr, names, parentenv, handlers[[1L]])
      9: value[[3L]](cond)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 0 SKIPPED: 3 FAILED: 2
      1. Error: No-pooling approaches work (@test-mptinr.R#23) 
      2. Error: Complete-pooling approaches work (@test-mptinr.R#164) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 57-80 (introduction-bayen_kuhlmann_2011.rmd) 
    Error: processing vignette 'introduction-bayen_kuhlmann_2011.rmd' failed with diagnostics:
    .onLoad failed in loadNamespace() for 'rjags', details:
      call: dyn.load(file, DLLpath = DLLpath, ...)
      error: unable to load shared object '/Users/max/github/forks/broom/revdep/library.noindex/MPTmultiverse/rjags/libs/rjags.so':
      dlopen(/Users/max/github/forks/broom/revdep/library.noindex/MPTmultiverse/rjags/libs/rjags.so, 10): Library not loaded: /usr/local/lib/libjags.4.dylib
      Referenced from: /Users/max/github/forks/broom/revdep/library.noindex/MPTmultiverse/rjags/libs/rjags.so
      Reason: image not found
    Execution halted
    ```

# plotly

Version: 4.8.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        htmlwidgets   3.1Mb
    ```

# progeny

Version: 1.4.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 42-60 (progeny.Rmd) 
    Error: processing vignette 'progeny.Rmd' failed with diagnostics:
    there is no package called 'airway'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘airway’
    ```

# psycho

Version: 0.3.7

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘methods’
      All declared Imports should be used.
    ```

# radiant.data

Version: 0.9.7

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘shinyFiles’
      All declared Imports should be used.
    ```

# sparklyr

Version: 0.9.2

## Newly broken

*   checking S3 generic/method consistency ... WARNING
    ```
    ...
      function(x, data, ...)
    augment.ml_model_logistic_regression:
      function(x, newdata, ...)
    
    augment:
      function(x, data, ...)
    augment.ml_model_naive_bayes:
      function(x, newdata, ...)
    
    augment:
      function(x, data, ...)
    augment.ml_model_random_forest_classification:
      function(x, newdata, ...)
    
    augment:
      function(x, data, ...)
    augment.ml_model_random_forest_regression:
      function(x, newdata, ...)
    
    See section ‘Generic functions and methods’ in the ‘Writing R
    Extensions’ manual.
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        R      2.1Mb
        java   1.9Mb
    ```

# StroupGLMM

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘car’ ‘lmerTest’ ‘pbkrtest’
      All declared Imports should be used.
    ```

# survivALL

Version: 0.9.3

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘cowplot’
      All declared Imports should be used.
    ```

# survminer

Version: 0.4.3

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        doc   5.1Mb
    ```

# survsup

Version: 0.0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘gridExtra’ ‘stats’ ‘survival’ ‘utils’
      All declared Imports should be used.
    ```

# sweep

Version: 0.2.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘lazyeval’ ‘lubridate’ ‘tidyr’
      All declared Imports should be used.
    ```

# SWMPrExtension

Version: 0.3.16

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rgeos’
      All declared Imports should be used.
    ```

# tadaatoolbox

Version: 0.16.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3 marked UTF-8 strings
    ```

# takos

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘MASS’ ‘devEMF’ ‘segmented’ ‘smoother’ ‘tools’
      All declared Imports should be used.
    ```

# tidybayes

Version: 1.0.3

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
             modules = modules, factories = factories, jags = jags, call.setup = TRUE, method = method, 
             mutate = mutate)
      10: setup.jags(model = outmodel, monitor = outmonitor, data = outdata, n.chains = n.chains, 
             inits = outinits, modules = modules, factories = factories, response = response, 
             fitted = fitted, residual = residual, jags = jags, method = method, mutate = mutate)
      11: loadandcheckrjags()
      12: stop("Loading the rjags package failed (diagnostics are given above this error message)", 
             call. = FALSE)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 263 SKIPPED: 2 FAILED: 1
      1. Error: tidy_draws works with runjags (@test.tidy_draws.R#87) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# tidymodels

Version: 0.0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘ggplot2’ ‘infer’ ‘pillar’ ‘recipes’ ‘rsample’
      ‘tidyposterior’ ‘tidypredict’ ‘tidytext’ ‘yardstick’
      All declared Imports should be used.
    ```

# tidyverse

Version: 1.2.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dbplyr’ ‘reprex’ ‘rlang’
      All declared Imports should be used.
    ```

# timetk

Version: 0.1.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘forecast’
      All declared Imports should be used.
    ```

# tipr

Version: 0.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘tibble’
      All declared Imports should be used.
    ```

# TPP

Version: 3.10.0

## In both

*   checking whether package ‘TPP’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘Biobase’ was built under R version 3.5.1
      Warning: package ‘BiocGenerics’ was built under R version 3.5.1
    See ‘/Users/max/github/forks/broom/revdep/checks.noindex/TPP/new/TPP.Rcheck/00install.out’ for details.
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    done.
    
    Creating QC plots to visualize normalization effects...
    done.
    
    Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
      Running 'texi2dvi' on 'NPARC_analysis_of_TPP_TR_data.tex' failed.
    LaTeX errors:
    ! LaTeX Error: File `forloop.sty' not found.
    
    Type X to quit or <RETURN> to proceed,
    or enter new name. (Default extension: sty)
    
    ! Emergency stop.
    <read *> 
             
    l.35 ^^M
            
    !  ==> Fatal error occurred, no output PDF file produced!
    Calls: buildVignettes -> texi2pdf -> texi2dvi
    Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 13.5Mb
      sub-directories of 1Mb or more:
        data           1.9Mb
        example_data   8.0Mb
        test_data      1.9Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘broom’
      All declared Imports should be used.
    Unexported objects imported by ':::' calls:
      ‘doParallel:::.options’ ‘mefa:::rep.data.frame’
      See the note in ?`:::` about the use of this operator.
    ```

*   checking R code for possible problems ... NOTE
    ```
    File ‘TPP/R/TPP.R’:
      .onLoad calls:
        packageStartupMessage(msgText, "\n")
    
    See section ‘Good practice’ in '?.onAttach'.
    
    plot_fSta_distribution: no visible binding for global variable
      ‘..density..’
    plot_pVal_distribution: no visible binding for global variable
      ‘..density..’
    Undefined global functions or variables:
      ..density..
    ```

# TSS.RESTREND

Version: 0.2.13

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘gimms’
    ```

# vdmR

Version: 0.2.6

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rdpack’ ‘maptools’ ‘rgeos’
      All declared Imports should be used.
    ```

