# agridat

Version: 1.15

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: Setting row names on a tibble is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

# amt

Version: 0.0.4.0

## In both

*   checking whether package ‘amt’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      track_methods.cpp:22:16: warning: using integer absolute value function 'abs' when argument is of floating point type [-Wabsolute-value]
      track_methods.cpp:23:16: warning: using integer absolute value function 'abs' when argument is of floating point type [-Wabsolute-value]
      track_methods.cpp:50:22: warning: using integer absolute value function 'abs' when argument is of floating point type [-Wabsolute-value]
      track_methods.cpp:52:22: warning: using integer absolute value function 'abs' when argument is of floating point type [-Wabsolute-value]
      track_methods.cpp:55:27: warning: using integer absolute value function 'abs' when argument is of floating point type [-Wabsolute-value]
    See ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/amt/new/amt.Rcheck/00install.out’ for details.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rcpp’ ‘magrittr’
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

Version: 1.12.0

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    This is MSnbase version 2.6.1 
      Visit https://lgatto.github.io/MSnbase/ to get started.
    
    
    Attaching package: ‘MSnbase’
    
    The following object is masked from ‘package:stats’:
    
        smooth
    
    The following object is masked from ‘package:base’:
    
        trimws
    
    Warning: Unknown or uninitialised column: 'sample'.
    Warning: Unknown or uninitialised column: 'sample'.
    Error in data.frame(..., check.names = FALSE) : 
      arguments imply differing number of rows: 220, 0
    Calls: tidy ... unrowname -> as.data.frame -> cbind -> cbind -> data.frame
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Attributes: < Component "class": Lengths (1, 3) differ (string compare on first 1) >
      Attributes: < Component "class": 1 string mismatch >
      
      [31m──[39m [31m2. Failure: voomWithQualityWeights tidier adds weight and sample.weight columns (@test-limma_tidiers.R#70[39m
      transform(td, weight = NULL) not equal to `ld`.
      Attributes: < Component "class": Lengths (1, 3) differ (string compare on first 1) >
      Attributes: < Component "class": 1 string mismatch >
      
      ══ testthat results  ═══════════════════════════════════════════════════════════════════════════════════════
      OK: 48 SKIPPED: 0 FAILED: 2
      1. Failure: voom tidier adds weight column (@test-limma_tidiers.R#43) 
      2. Failure: voomWithQualityWeights tidier adds weight and sample.weight columns (@test-limma_tidiers.R#70) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking whether package ‘biobroom’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import ‘dplyr::exprs’ by ‘Biobase::exprs’ when loading ‘biobroom’
    See ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/biobroom/new/biobroom.Rcheck/00install.out’ for details.
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    
    The following object is masked from 'package:dplyr':
    
        count
    
    Loading required package: BiocParallel
    
    Attaching package: 'DelayedArray'
    
    The following objects are masked from 'package:matrixStats':
    
        colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges
    
    The following objects are masked from 'package:base':
    
        aperm, apply
    
    Quitting from lines 134-139 (biobroom_vignette.Rmd) 
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

Version: 1.0.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    
    The following objects are masked from 'package:IRanges':
    
        intersect, setdiff, union
    
    The following objects are masked from 'package:S4Vectors':
    
        intersect, setdiff, union
    
    The following objects are masked from 'package:BiocGenerics':
    
        intersect, setdiff, union
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, union
    
    Quitting from lines 46-92 (BloodCancerMultiOmics2017.Rmd) 
    Error: processing vignette 'BloodCancerMultiOmics2017.Rmd' failed with diagnostics:
    there is no package called 'org.Hs.eg.db'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘org.Hs.eg.db’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 101.4Mb
      sub-directories of 1Mb or more:
        data     66.4Mb
        doc      26.2Mb
        extdata   8.5Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘vsn’
    ```

# breathtestcore

Version: 0.4.1

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Attaching package: ‘dplyr’
    
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > data("usz_13c")
    > data = usz_13c %>%
    +   dplyr::filter( patient_id %in%
    +     c("norm_001", "norm_002", "norm_003", "norm_004", "pat_001", "pat_002","pat_003")) %>%
    +   cleanup_data()
    > fit = nls_fit(data)
    > coef_by_group(fit)
    Error in mutate_impl(.data, dots) : 
      Evaluation error: non-numeric argument to mathematical function.
    Calls: coef_by_group ... <Anonymous> -> mutate -> mutate.tbl_df -> mutate_impl
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      22: mutate.tbl_df(., estimate.x = signif(estimate.x, sig), conf.low = signif(conf.low, sig), conf.high = signif(conf.high, 
             sig), p.value = signif(p.value, sig))
      23: mutate_impl(.data, dots)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════════════════════════════════
      OK: 323 SKIPPED: 5 FAILED: 6
      1. Error: Result with default parameters is tbl_df with required columns (@test_coef_by_group.R#13) 
      2. Error: Options digits is served (@test_coef_by_group.R#33) 
      3. Error: Result with default parameters is tbl_df with required columns (@test_coef_diff_by_group.R#13) 
      4. Error: Result with Dunnett contrast only returns 3 groups (@test_coef_diff_by_group.R#24) 
      5. Error: Correct Dunnett contrast when reference value is given (@test_coef_diff_by_group.R#45) 
      6. Error: Options digits is served (@test_coef_diff_by_group.R#67) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘breathteststan’
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

Version: 1.4.0

## Newly broken

*   R CMD check timed out
    

# ciTools

Version: 0.3.0

## In both

*   R CMD check timed out
    

# eechidna

Version: 1.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.3Mb
      sub-directories of 1Mb or more:
        data   4.9Mb
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

# ERSA

Version: 0.1.0

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'tidy.matrix' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘RColorBrewer’ ‘modelr’
      All declared Imports should be used.
    ```

# eurostat

Version: 3.2.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘curl’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 484 marked UTF-8 strings
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
      installed size is  6.2Mb
      sub-directories of 1Mb or more:
        data   5.3Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1616 marked UTF-8 strings
    ```

# germinationmetrics

Version: 0.1.0

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    The error most likely occurred in:
    
    > ### Name: FourPHFfit
    > ### Title: Fit four-parameter hill function
    > ### Aliases: FourPHFfit
    > 
    > ### ** Examples
    > 
    > 
    > x <- c(0, 0, 0, 0, 4, 17, 10, 7, 1, 0, 1, 0, 0, 0)
    > y <- c(0, 0, 0, 0, 4, 21, 31, 38, 39, 39, 40, 40, 40, 40)
    > int <- 1:length(x)
    > total.seeds = 50
    > 
    > # From partial germination counts
    > #----------------------------------------------------------------------------
    > FourPHFfit(germ.counts = x, intervals = int, total.seeds = 50, tmax = 20)
    Error in integrate(FourPHF, lower = 0, upper = tmax, a = a, b = b, c = c,  : 
      evaluation of function gave a result of wrong length
    Calls: FourPHFfit -> integrate
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 264-264 (Introduction.Rmd) 
    Error: processing vignette 'Introduction.Rmd' failed with diagnostics:
    evaluation of function gave a result of wrong length
    Execution halted
    ```

# ggformula

Version: 0.8.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘quantreg’
    ```

# ggpmisc

Version: 0.2.17

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘grid’ ‘gridExtra’
      All declared Imports should be used.
    ```

# healthcareai

Version: 2.0.0

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'tidy.logical' is deprecated.
      Warning: 'tidy.logical' is deprecated.
      Warning: 'tidy.logical' is deprecated.
      Warning: 'tidy.logical' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      [31m──[39m [31m2. Failure: dummy columns are created as expected (@test-prep_data.R#278) [39m [31m────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[39m
      all(n == exp) isn't true.
      
      [31m──[39m [31m3. Failure: prep_data respects add_levels = FALSE (@test-prep_data.R#428) [39m [31m────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[39m
      any(c("other", "missing") %in% levels(pd$x)) isn't false.
      
      ══ testthat results  ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
      OK: 775 SKIPPED: 7 FAILED: 3
      1. Failure: determine_prep TRUE w/o warning when prep needed and vars changed in prep (@test-predict.R#227) 
      2. Failure: dummy columns are created as expected (@test-prep_data.R#278) 
      3. Failure: prep_data respects add_levels = FALSE (@test-prep_data.R#428) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# highcharter

Version: 0.5.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 16.5Mb
      sub-directories of 1Mb or more:
        doc          13.7Mb
        htmlwidgets   1.8Mb
    ```

# huxtable

Version: 4.0.0

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `huxreg(lm1, glm1, tidy_args = list(exponentiate = FALSE), statistics = "nobs")` produced warnings.
      
      ══ testthat results  ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
      OK: 482 SKIPPED: 51 FAILED: 8
      1. Failure: huxreg copes with different models (@test-huxreg.R#27) 
      2. Failure: huxreg confidence intervals work (@test-huxreg.R#40) 
      3. Failure: huxreg confidence intervals work when tidy c.i.s not available (@test-huxreg.R#50) 
      4. Failure: huxreg bold_signif works (@test-huxreg.R#90) 
      5. Failure: huxreg error_pos works (@test-huxreg.R#98) 
      6. Failure: can pass broom::tidy arguments to huxreg (@test-huxreg.R#181) 
      7. Failure: can pass broom::tidy arguments to huxreg (@test-huxreg.R#182) 
      8. Failure: can pass broom::tidy arguments to huxreg (@test-huxreg.R#183) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# jtools

Version: 1.0.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘effects’, ‘wec’, ‘rockchalk’, ‘pequod’, ‘car’, ‘piecewiseSEM’
    ```

# lucid

Version: 1.4

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
      error: unable to load shared object '/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so':
      dlopen(/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so, 10): Library not loaded: /usr/local/lib/libjags.4.dylib
      Referenced from: /Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so
      Reason: image not found
    Quitting from lines 269-293 (lucid_printing.Rmd) 
    Error: processing vignette 'lucid_printing.Rmd' failed with diagnostics:
    could not find function "jags.model"
    Execution halted
    ```

# mason

Version: 0.2.5

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'tidy.matrix' is deprecated.
      Warning: 'tidy.matrix' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘pander’, ‘pixiedust’
    ```

# mice

Version: 3.1.0

## In both

*   checking whether package ‘mice’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/mice/new/mice.Rcheck/00install.out’ for details.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘pan’
    ```

## Installation

### Devel

```
* installing *source* package ‘mice’ ...
** package ‘mice’ successfully unpacked and MD5 sums checked
** libs
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/mice/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/mice/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c match.cpp -o match.o
clang++ -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o mice.so RcppExports.o match.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to /Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/mice/new/mice.Rcheck/mice/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘pan’
ERROR: lazy loading failed for package ‘mice’
* removing ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/mice/new/mice.Rcheck/mice’

```
### CRAN

```
* installing *source* package ‘mice’ ...
** package ‘mice’ successfully unpacked and MD5 sums checked
** libs
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/mice/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/mice/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c match.cpp -o match.o
clang++ -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o mice.so RcppExports.o match.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to /Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/mice/old/mice.Rcheck/mice/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘pan’
ERROR: lazy loading failed for package ‘mice’
* removing ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/mice/old/mice.Rcheck/mice’

```
# miceFast

Version: 0.2.3

## In both

*   checking whether package ‘miceFast’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/miceFast/new/miceFast.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘miceFast’ ...
** package ‘miceFast’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Library/Frameworks/R.framework/Versions/3.5/Resources/library/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2 -c R_funs.cpp -o R_funs.o
clang: error: unsupported option '-fopenmp'
make: *** [R_funs.o] Error 1
ERROR: compilation failed for package ‘miceFast’
* removing ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/miceFast/new/miceFast.Rcheck/miceFast’

```
### CRAN

```
* installing *source* package ‘miceFast’ ...
** package ‘miceFast’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/drobinson/Repositories/rpackages/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Library/Frameworks/R.framework/Versions/3.5/Resources/library/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2 -c R_funs.cpp -o R_funs.o
clang: error: unsupported option '-fopenmp'
make: *** [R_funs.o] Error 1
ERROR: compilation failed for package ‘miceFast’
* removing ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/miceFast/old/miceFast.Rcheck/miceFast’

```
# mosaic

Version: 1.2.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘cubature’
    ```

# nlshelper

Version: 0.2

## In both

*   checking whether package ‘nlshelper’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/nlshelper/new/nlshelper.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘nlshelper’ ...
** package ‘nlshelper’ successfully unpacked and MD5 sums checked
** R
** byte-compile and prepare package for lazy loading
Error : package ‘sm’ required by ‘magicaxis’ could not be found
ERROR: lazy loading failed for package ‘nlshelper’
* removing ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/nlshelper/new/nlshelper.Rcheck/nlshelper’

```
### CRAN

```
* installing *source* package ‘nlshelper’ ...
** package ‘nlshelper’ successfully unpacked and MD5 sums checked
** R
** byte-compile and prepare package for lazy loading
Error : package ‘sm’ required by ‘magicaxis’ could not be found
ERROR: lazy loading failed for package ‘nlshelper’
* removing ‘/Users/drobinson/Repositories/rpackages/broom/revdep/checks.noindex/nlshelper/old/nlshelper.Rcheck/nlshelper’

```
# nlstimedist

Version: 1.1.1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(nlstimedist)
      > 
      > test_check("nlstimedist")
      [31m──[39m [31m1. Failure: Ensure the glance method is returning expected values (@test-glance.timedist.R#19) [39m [31m───────────────────────────────────────────────────────────────────────────────────────────────────[39m
      `out` not equal to `expect`.
      Rows in x but not y: 1. Rows in y but not x: 1. 
      
      ══ testthat results  ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
      OK: 6 SKIPPED: 0 FAILED: 1
      1. Failure: Ensure the glance method is returning expected values (@test-glance.timedist.R#19) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# pcr

Version: 1.1.1

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'tidy.matrix' is deprecated.
      Warning: 'tidy.matrix' is deprecated.
      Warning: 'tidy.matrix' is deprecated.
      Warning: 'tidy.matrix' is deprecated.
      Warning: 'tidy.matrix' is deprecated.
      Warning: 'tidy.matrix' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

# perccalc

Version: 1.0.1

## Newly broken

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
      ...
    
    Attaching package: 'dplyr'
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, setequal, union
    
    trying URL 'http://gss.norc.org/Documents/stata/2016_stata.zip'
    Content type 'application/x-zip-compressed' length 1134619 bytes (1.1 MB)
    ==================================================
    downloaded 1.1 MB
    
    Quitting from lines 206-213 (perc_calculator_example.Rmd) 
    Error: processing vignette 'perc_calculator_example.Rmd' failed with diagnostics:
    Evaluation error: object 'estimate' not found.
    Execution halted
    ```

# pixiedust

Version: 0.8.3

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ══ testthat results  ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
      OK: 498 SKIPPED: 120 FAILED: 9
      1. Failure: dust runs when passed a data frame with tidy_df = TRUE (@test-dust.R#50) 
      2. Failure: dust with glance_foot (@test-dust.R#74) 
      3. Failure: dust with glance_foot and col_pairs a divisor of total_cols (@test-dust.R#80) 
      4. Failure: glance_foot by column (@test-glance_foot.R#18) 
      5. Failure: glance_foot by row (@test-glance_foot.R#23) 
      6. Failure: glance_foot with subset of stats (@test-glance_foot.R#28) 
      7. Failure: medley_model (@test-medley.R#17) 
      8. Failure: Apply a calculation (@test-perform_function.R#11) 
      9. Failure: Apply a string manipulation (@test-perform_function.R#23) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 283-290 (pixiedust.Rmd) 
    Error: processing vignette 'pixiedust.Rmd' failed with diagnostics:
    need numeric data
    Execution halted
    ```

# plotly

Version: 4.7.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘RSelenium’
    ```

# progeny

Version: 1.2.0

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

# radiant.data

Version: 0.9.5

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘curl’ ‘writexl’
      All declared Imports should be used.
    ```

# sjmisc

Version: 2.7.3

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘sjmisc-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: merge_imputations
    > ### Title: Merges multiple imputed data frames into a single data frame
    > ### Aliases: merge_imputations
    > 
    > ### ** Examples
    > 
    > library(mice)
    Loading required package: lattice
    Error: package or namespace load failed for ‘mice’ in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
     there is no package called ‘pan’
    Execution halted
    ```

# sjPlot

Version: 2.4.1

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘plm’
    ```

# sjstats

Version: 0.15.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘piecewiseSEM’
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

Version: 0.4.2

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: Setting row names on a tibble is deprecated.
      Warning: Setting row names on a tibble is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        doc   5.1Mb
    ```

# survutils

Version: 1.0.1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(survutils)
      > 
      > test_check("survutils")
      [31m──[39m [31m1. Failure: get_cox_res runs univariate Cox regression on a single feature (@test_get_cox_res.R#44) [39m [31m──────────────────────────────────────────────────────────────────────────────────────────────[39m
      `out_df` not equal to `expected_out_df`.
      Rows in x but not y: 1. Rows in y but not x: 1. 
      
      ══ testthat results  ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
      OK: 6 SKIPPED: 0 FAILED: 1
      1. Failure: get_cox_res runs univariate Cox regression on a single feature (@test_get_cox_res.R#44) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# sweep

Version: 0.2.1

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

Version: 0.16.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3 marked UTF-8 strings
    ```

# temperatureresponse

Version: 0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘nlme’ ‘tidyr’
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

Version: 0.1.1

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

Version: 3.8.1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
      OK: 13372 SKIPPED: 1 FAILED: 34
      1. Error: NPARC_allok_plot (@test_analyzeTPPTR.R#61) 
      2. Error: allOk_H0 (@test_compute_spline_auc.R#43) 
      3. Error: allOk_H1_1 (@test_compute_spline_auc.R#58) 
      4. Error: allOk_H1_2 (@test_compute_spline_auc.R#73) 
      5. Error: (unknown) (@test_create_spline_plots.R#30) 
      6. Error: allOk_names_H0 (@test_extract_fit_factors.R#30) 
      7. Error: allOk_values_H0 (@test_extract_fit_factors.R#41) 
      8. Error: allOk_names_H1 (@test_extract_fit_factors.R#51) 
      9. Error: allOk_values_H1 (@test_extract_fit_factors.R#62) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

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

Version: 0.2.5

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rdpack’ ‘maptools’ ‘rgeos’
      All declared Imports should be used.
    ```

