# agridat

Version: 1.16

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp2sKNWk/Rd2pdf1cde1b61261d'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# amt

Version: 0.0.4.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmptYtFOU/Rd2pdf1aa111a533f4'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rcpp’ ‘magrittr’
      All declared Imports should be used.
    ```

# apaTables

Version: 2.0.4

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpQdN06v/Rd2pdf1e833721df1f'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# arsenal

Version: 1.2.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpsiPcjG/Rd2pdf20bf16a84434'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# autoimage

Version: 2.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp4O94II/Rd2pdf25bf7eef094b'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# AutoModel

Version: 0.4.9

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp8VYZAe/Rd2pdf241e2b27dcae'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
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
      
      [31m──[39m [31m2. Failure: voomWithQualityWeights tidier adds weight and sample.weight columns (@test-limma_tid[39m
      transform(td, weight = NULL) not equal to `ld`.
      Attributes: < Component "class": Lengths (1, 3) differ (string compare on first 1) >
      Attributes: < Component "class": 1 string mismatch >
      
      ══ testthat results  ══════════════════════════════════════════════════════════════════════════════
      OK: 48 SKIPPED: 0 FAILED: 2
      1. Failure: voom tidier adds weight column (@test-limma_tidiers.R#43) 
      2. Failure: voomWithQualityWeights tidier adds weight and sample.weight columns (@test-limma_tidiers.R#70) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmpn2vRQV/Rd2pdf286067cc78b3'
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

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
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

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpVyK1MS/Rd2pdf2e357c9250da'
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    Loading required package: survival
    
    Attaching package: 'limma'
    
    The following object is masked from 'package:DESeq2':
    
        plotMA
    
    The following object is masked from 'package:BiocGenerics':
    
        plotMA
    
    Loading required package: rgl
    Error: package or namespace load failed for 'rgl':
     .onLoad failed in loadNamespace() for 'rgl', details:
      call: NULL
      error: X11 not found; XQuartz (from www.xquartz.org) is required to run rgl.
    Quitting from lines 46-92 (BloodCancerMultiOmics2017.Rmd) 
    Error: processing vignette 'BloodCancerMultiOmics2017.Rmd' failed with diagnostics:
    package 'rgl' could not be loaded
    Execution halted
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘org.Hs.eg.db’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 115.1Mb
      sub-directories of 1Mb or more:
        data     80.0Mb
        doc      26.2Mb
        extdata   8.5Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘vsn’
    ```

# breathtestcore

Version: 0.4.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpkiVHh0/Rd2pdf2c6d53872f11'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘breathteststan’
    ```

# catenary

Version: 1.1.2

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpwqERzG/Rd2pdf2fdb247c270f'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyverse’
      All declared Imports should be used.
    ```

# cdom

Version: 0.1.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpyeujQI/Rd2pdf325a3b1f2257'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# ciTools

Version: 0.3.0

## Newly broken

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpruetoA/Rd2pdf35d92a1d5c26'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

## Newly fixed

*   R CMD check timed out
    

# dotwhisker

Version: 0.5.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpmzA2QV/Rd2pdf385f480e4702'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# eechidna

Version: 1.1

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is  7.0Mb
      sub-directories of 1Mb or more:
        data   5.6Mb
        doc    1.2Mb
    ```

# eurostat

Version: 3.2.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp54c9iK/Rd2pdf4dc051a6508c'
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    Table t2020_rk310 cached at /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpLmUaQB/eurostat/t2020_rk310_num_code_TF.rds
    trying URL 'http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=data%2Ften00081.tsv.gz'
    Content type 'application/octet-stream;charset=UTF-8' length 13630 bytes (13 KB)
    ==================================================
    downloaded 13 KB
    
    Table ten00081 cached at /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpLmUaQB/eurostat/ten00081_date_code_TF.rds
    trying URL 'http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=data%2Ftgs00026.tsv.gz'
    Content type 'application/octet-stream;charset=UTF-8' length 5998 bytes
    ==================================================
    downloaded 5998 bytes
    
    Quitting from lines 380-401 (eurostat_tutorial.Rmd) 
    Error: processing vignette 'eurostat_tutorial.Rmd' failed with diagnostics:
    .onLoad failed in loadNamespace() for 'Cairo', details:
      call: dyn.load(file, DLLpath = DLLpath, ...)
      error: unable to load shared object '/Users/alexhayes/Documents/broom/revdep/library.noindex/eurostat/Cairo/libs/Cairo.so':
      dlopen(/Users/alexhayes/Documents/broom/revdep/library.noindex/eurostat/Cairo/libs/Cairo.so, 6): Library not loaded: /opt/X11/lib/libfreetype.6.dylib
      Referenced from: /Users/alexhayes/Documents/broom/revdep/library.noindex/eurostat/Cairo/libs/Cairo.so
      Reason: image not found
    Execution halted
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘curl’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 484 marked UTF-8 strings
    ```

# eyetrackingR

Version: 0.1.7

## In both

*   R CMD check timed out
    

# fivethirtyeight

Version: 0.4.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpEASYUM/Rd2pdf3cb02329a214'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘fivethirtyeight’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.9Mb
      sub-directories of 1Mb or more:
        data   6.0Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1616 marked UTF-8 strings
    ```

# forestmodel

Version: 0.5.0

## In both

*   R CMD check timed out
    

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

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpxP6w8q/Rd2pdf40b5681a515d'
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in (function (filename = if (onefile) "Rplots.pdf" else "Rplot%03d.pdf",  :
      unable to load shared object '/Library/Frameworks/R.framework/Resources/library/grDevices/libs//cairo.so':
      dlopen(/Library/Frameworks/R.framework/Resources/library/grDevices/libs//cairo.so, 6): Library not loaded: /opt/X11/lib/libcairo.2.dylib
      Referenced from: /Library/Frameworks/R.framework/Resources/library/grDevices/libs//cairo.so
      Reason: image not found
    Warning in (function (filename = if (onefile) "Rplots.pdf" else "Rplot%03d.pdf",  :
      failed to load cairo DLL
    Quitting from lines 51-55 (Introduction.Rmd) 
    Error: processing vignette 'Introduction.Rmd' failed with diagnostics:
    dev.control() called without an open graphics device
    Execution halted
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

## Newly fixed

*   R CMD check timed out
    

# ggpmisc

Version: 0.2.17

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘grid’ ‘gridExtra’
      All declared Imports should be used.
    ```

## In both

*   R CMD check timed out
    

# ggsn

Version: 0.4.0

## Newly broken

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp6RZeVc/Rd2pdf445346a6ddc2'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

## Newly fixed

*   R CMD check timed out
    

# groupdata2

Version: 1.0.0

## Newly broken

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpVsYGAy/Rd2pdf467a44cc121'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

## Newly fixed

*   R CMD check timed out
    

# healthcareai

Version: 2.1.0

## In both

*   R CMD check timed out
    

# infer

Version: 0.2.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmpgx6UZT/Rd2pdf505574cd81f0'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# jtools

Version: 1.0.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      3: capture(act$val <- eval_bare(get_expr(quo), get_env(quo)))
      4: withCallingHandlers(code, message = function(condition) {
             out$push(condition)
             invokeRestart("muffleMessage")
         })
      5: eval_bare(get_expr(quo), get_env(quo))
      6: print(plot_coefs(fit, plot.distributions = TRUE))
      7: plot_coefs(fit, plot.distributions = TRUE)
      
      ══ testthat results  ════════════════════════════════════════════════
      OK: 385 SKIPPED: 0 FAILED: 1
      1. Error: plot.distributions works (@test-export-summs.R#272) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmpn7eysV/Rd2pdf52896b23bbae'
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Loading required package: grid
    Loading required package: Matrix
    Loading required package: survival
    
    Attaching package: 'survey'
    
    The following object is masked from 'package:graphics':
    
        dotchart
    
    Quitting from lines 287-288 (summ.Rmd) 
    Error: processing vignette 'summ.Rmd' failed with diagnostics:
    argument is of length zero
    Execution halted
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘effects’, ‘wec’, ‘arm’, ‘rockchalk’, ‘pequod’, ‘piecewiseSEM’
    ```

# konfound

Version: 0.1.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpMt1aX7/Rd2pdf4bd67be9003b'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# lspline

Version: 1.0-0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpWD6oi7/Rd2pdf53ff7701949c'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# lucid

Version: 1.4

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmprxeP50/Rd2pdf572059fe8338'
    ```

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
      error: unable to load shared object '/Users/alexhayes/Documents/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so':
      dlopen(/Users/alexhayes/Documents/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so, 10): Library not loaded: /usr/local/lib/libjags.4.dylib
      Referenced from: /Users/alexhayes/Documents/broom/revdep/library.noindex/lucid/rjags/libs/rjags.so
      Reason: image not found
    Quitting from lines 269-293 (lucid_printing.Rmd) 
    Error: processing vignette 'lucid_printing.Rmd' failed with diagnostics:
    could not find function "jags.model"
    Execution halted
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# macleish

Version: 0.3.2

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpwCcu7u/Rd2pdf59164ea7bdff'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# MARSS

Version: 3.10.8

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpDjj9fD/Rd2pdf5cd32fa72544'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking re-building of vignette outputs ... NOTE
    ```
    Error in re-building vignettes:
      ...
    Error in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  : 
      Running 'texi2dvi' on 'EMDerivation.tex' failed.
    Calls: buildVignettes -> texi2pdf -> texi2dvi
    Execution halted
    ```

# mason

Version: 0.2.6

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmptL9Wam/Rd2pdf5d751b56022d'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘pander’, ‘pixiedust’
    ```

# merTools

Version: 0.4.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpY3FXfL/Rd2pdf600f257f54c6'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# mice

Version: 3.1.0

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      > 
      > test_check("mice")
      [31m──[39m [31m1. Error: (unknown) (@test-D1.R#13) [39m [31m─────────────────────────────[39m
      Non-numeric argument to mathematical function
      1: D1(fit1, fit0) at testthat/test-D1.R:13
      2: testModels(fit1, fit0, method = "D1", df.com = df.com)
      3: pf(val, k, v)
      
      ══ testthat results  ════════════════════════════════════════════════
      OK: 269 SKIPPED: 0 FAILED: 1
      1. Error: (unknown) (@test-D1.R#13) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpCAIETM/Rd2pdf66e127c7a46a'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# miceFast

Version: 0.2.3

## In both

*   checking whether package ‘miceFast’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/miceFast/new/miceFast.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘miceFast’ ...
** package ‘miceFast’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/alexhayes/Documents/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/alexhayes/Documents/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2 -c R_funs.cpp -o R_funs.o
clang: error: unsupported option '-fopenmp'
make: *** [R_funs.o] Error 1
ERROR: compilation failed for package ‘miceFast’
* removing ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/miceFast/new/miceFast.Rcheck/miceFast’

```
### CRAN

```
* installing *source* package ‘miceFast’ ...
** package ‘miceFast’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I"/Users/alexhayes/Documents/broom/revdep/library.noindex/miceFast/Rcpp/include" -I"/Users/alexhayes/Documents/broom/revdep/library.noindex/miceFast/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2 -c R_funs.cpp -o R_funs.o
clang: error: unsupported option '-fopenmp'
make: *** [R_funs.o] Error 1
ERROR: compilation failed for package ‘miceFast’
* removing ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/miceFast/old/miceFast.Rcheck/miceFast’

```
# modelr

Version: 0.1.2

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpxWmV6b/Rd2pdf650931b2916d'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# moderndive

Version: 0.2.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpPvGyEI/Rd2pdf6af475fe1eb9'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# mosaic

Version: 1.3.0

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘mosaic-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: cdist
    > ### Title: Central portion of a distribution
    > ### Aliases: cdist xcgamma xct xcchisq xcf xcbinom xcpois xcgeom xcnbinom
    > ###   xcbeta
    > 
    > ### ** Examples
    > 
    > cdist( "norm", .95)
    Error in find_subclass("Geom", geom, parent.frame()) : 
      could not find function "find_subclass"
    Calls: cdist ... plot_multi_dist -> do.call -> <Anonymous> -> do.call -> <Anonymous>
    Execution halted
    ```

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpcDoeBW/Rd2pdf6d556512db9b'
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 43-45 (ggformula-lattice.Rmd) 
    Error: processing vignette 'ggformula-lattice.Rmd' failed with diagnostics:
    could not find function "find_subclass"
    Execution halted
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘manipulate’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘cubature’
    ```

# NetworkExtinction

Version: 0.1.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpJNbYOV/Rd2pdf6e26141c8ba7'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# nls.multstart

Version: 1.0.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpjEgvlh/Rd2pdf71907148ba2'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# nlshelper

Version: 0.2

## In both

*   checking whether package ‘nlshelper’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/nlshelper/new/nlshelper.Rcheck/00install.out’ for details.
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
* removing ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/nlshelper/new/nlshelper.Rcheck/nlshelper’

```
### CRAN

```
* installing *source* package ‘nlshelper’ ...
** package ‘nlshelper’ successfully unpacked and MD5 sums checked
** R
** byte-compile and prepare package for lazy loading
Error : package ‘sm’ required by ‘magicaxis’ could not be found
ERROR: lazy loading failed for package ‘nlshelper’
* removing ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/nlshelper/old/nlshelper.Rcheck/nlshelper’

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
      [31m──[39m [31m1. Failure: Ensure the glance method is returning expected values [39m
      `out` not equal to `expect`.
      Rows in x but not y: 1. Rows in y but not x: 1. 
      
      ══ testthat results  ════════════════════════════════════════════════
      OK: 6 SKIPPED: 0 FAILED: 1
      1. Failure: Ensure the glance method is returning expected values (@test-glance.timedist.R#19) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmplswPdI/Rd2pdf75871f1417b5'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
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

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpbDFlCP/Rd2pdf7637b7d0e71'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
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
    
    Quitting from lines 47-54 (perc_warning_example.Rmd) 
    Error: processing vignette 'perc_warning_example.Rmd' failed with diagnostics:
    Column index must be at most 3 if positive, not 4
    Execution halted
    ```

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpsVjRZl/Rd2pdf79305477979e'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# pixiedust

Version: 0.8.4

## Newly fixed

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library("testthat")
      > library("pixiedust")
      Additional documentation is being constructed at http://nutterb.github.io/pixiedust/index.html
      > 
      > test_check("pixiedust")
      [31m──[39m [31m1. Failure: dust runs when passed a data frame with tidy_df = TRUE[39m
      `dust(mtcars, tidy_df = TRUE)` did not produce any warnings.
      
      ══ testthat results  ════════════════════════════════════════════════
      OK: 512 SKIPPED: 120 FAILED: 1
      1. Failure: dust runs when passed a data frame with tidy_df = TRUE (@test-dust.R#52) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpQ5MpYI/Rd2pdf7b18627d9690'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# plotly

Version: 4.7.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ════════════════════════════════════════════════
      OK: 1154 SKIPPED: 25 FAILED: 21
      1. Failure: Translates both dates and datetimes (with dynamic ticks) correctly (@test-ggplot-lines.R#85) 
      2. Failure: Translates both dates and datetimes (with dynamic ticks) correctly (@test-ggplot-lines.R#86) 
      3. Failure: geom_linerange() without a y aesthetic translates to a path (@test-ggplot-lines.R#111) 
      4. Failure: polygons with different hovertext must be different traces  (@test-ggplot-polygons.R#25) 
      5. Failure: polygons with different hovertext must be different traces  (@test-ggplot-polygons.R#26) 
      6. Failure: polygons with different hovertext must be different traces  (@test-ggplot-polygons.R#31) 
      7. Failure: borders become one trace with NA (@test-ggplot-polygons.R#147) 
      8. Failure: borders become one trace with NA (@test-ggplot-polygons.R#149) 
      9. Failure: geom_polygon(aes(group)) -> 1 trace (@test-ggplot-polygons.R#162) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpZu4HWg/Rd2pdf7e591ec06fb4'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘RSelenium’
    ```

# progeny

Version: 1.2.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpkPxeyv/Rd2pdf801e156568e1'
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 42-60 (progeny.Rmd) 
    Error: processing vignette 'progeny.Rmd' failed with diagnostics:
    there is no package called 'airway'
    Execution halted
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘airway’
    ```

# radiant.data

Version: 0.9.5

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpJCDkHR/Rd2pdf83a072a4ec3c'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘curl’ ‘writexl’
      All declared Imports should be used.
    ```

# recipes

Version: 0.1.3

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpzXV2fs/Rd2pdf871e67b17524'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# rsample

Version: 0.0.2

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpD7evrN/Rd2pdf8b464a2ef8f'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# simglm

Version: 0.7.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp5zTnpq/Rd2pdf8db73c6a840f'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# SimplifyStats

Version: 1.0.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmpwz5Pq5/Rd2pdf909043680da3'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# simTool

Version: 1.1.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpJC2MGn/Rd2pdf925258d1388d'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# sjlabelled

Version: 1.0.11

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmprhrGvV/Rd2pdf99e17a166fdb'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# sjmisc

Version: 2.7.3

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpkZqn7C/Rd2pdf9b1848150a7c'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# sjPlot

Version: 2.4.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpuHQE1I/Rd2pdf9dfb4eaa8d2'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# sjstats

Version: 0.15.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp1JvDXi/Rd2pdfab09dd58907'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘MuMIn’, ‘piecewiseSEM’
    ```

# sparklyr

Version: 0.8.4

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpzHMqiW/Rd2pdfa2da307cf9de'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# spbabel

Version: 0.4.8

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpbNDntO/Rd2pdfa5dd37e7d793'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# statsr

Version: 0.1-0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpR85uBj/Rd2pdfa80e5c43be61'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# StroupGLMM

Version: 0.1.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp6a1JE5/Rd2pdfa9b946cb1f01'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘car’ ‘lmerTest’ ‘pbkrtest’
      All declared Imports should be used.
    ```

# survivALL

Version: 0.9.3

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmpyqbiqd/Rd2pdfaded696d1865'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

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

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp84xywZ/Rd2pdfb41a12a415da'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

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
      [31m──[39m [31m1. Failure: get_cox_res runs univariate Cox regression on a single[39m
      `out_df` not equal to `expected_out_df`.
      Rows in x but not y: 1. Rows in y but not x: 1. 
      
      ══ testthat results  ════════════════════════════════════════════════
      OK: 6 SKIPPED: 0 FAILED: 1
      1. Failure: get_cox_res runs univariate Cox regression on a single feature (@test_get_cox_res.R#44) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmph49JGX/Rd2pdfb1ef5404cc0f'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# sweep

Version: 0.2.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpuHsdca/Rd2pdfb65268798faf'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘lazyeval’ ‘lubridate’ ‘tidyr’
      All declared Imports should be used.
    ```

# SWMPrExtension

Version: 0.3.16

## In both

*   checking whether package ‘SWMPrExtension’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/SWMPrExtension/new/SWMPrExtension.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘SWMPrExtension’ ...
** package ‘SWMPrExtension’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in dyn.load(file, DLLpath = DLLpath, ...) : 
  unable to load shared object '/Users/alexhayes/Documents/broom/revdep/library.noindex/SWMPrExtension/gdtools/libs/gdtools.so':
  dlopen(/Users/alexhayes/Documents/broom/revdep/library.noindex/SWMPrExtension/gdtools/libs/gdtools.so, 6): Library not loaded: /opt/X11/lib/libcairo.2.dylib
  Referenced from: /Users/alexhayes/Documents/broom/revdep/library.noindex/SWMPrExtension/gdtools/libs/gdtools.so
  Reason: image not found
ERROR: lazy loading failed for package ‘SWMPrExtension’
* removing ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/SWMPrExtension/new/SWMPrExtension.Rcheck/SWMPrExtension’

```
### CRAN

```
* installing *source* package ‘SWMPrExtension’ ...
** package ‘SWMPrExtension’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in dyn.load(file, DLLpath = DLLpath, ...) : 
  unable to load shared object '/Users/alexhayes/Documents/broom/revdep/library.noindex/SWMPrExtension/gdtools/libs/gdtools.so':
  dlopen(/Users/alexhayes/Documents/broom/revdep/library.noindex/SWMPrExtension/gdtools/libs/gdtools.so, 6): Library not loaded: /opt/X11/lib/libcairo.2.dylib
  Referenced from: /Users/alexhayes/Documents/broom/revdep/library.noindex/SWMPrExtension/gdtools/libs/gdtools.so
  Reason: image not found
ERROR: lazy loading failed for package ‘SWMPrExtension’
* removing ‘/Users/alexhayes/Documents/broom/revdep/checks.noindex/SWMPrExtension/old/SWMPrExtension.Rcheck/SWMPrExtension’

```
# tadaatoolbox

Version: 0.16.0

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpsLl6Rw/Rd2pdfb9f12984da51'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3 marked UTF-8 strings
    ```

# temperatureresponse

Version: 0.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpNyBjZM/Rd2pdfbb2e60ec3869'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘nlme’ ‘tidyr’
      All declared Imports should be used.
    ```

# tibbletime

Version: 0.1.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmpk9Cfbg/Rd2pdfbcee15cef5c5'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# tidyposterior

Version: 0.0.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp6Cxgud/Rd2pdfc09a32889280'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# tidyquant

Version: 0.5.5

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp7DFjJt/Rd2pdfc37328561e15'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unable to find any JVMs matching version "(null)".
    No Java runtime present, try --request to install.
    ```

# tidytext

Version: 0.1.9

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//Rtmp74cnIa/Rd2pdfc5b82b615dd5'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unable to find any JVMs matching version "(null)".
    No Java runtime present, try --request to install.
    ```

# tidyverse

Version: 1.2.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpmlOnq2/Rd2pdfc8c25d71e194'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dbplyr’ ‘reprex’ ‘rlang’
      All declared Imports should be used.
    ```

# timetk

Version: 0.1.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpTwrRJi/Rd2pdfcd85641a79d7'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘forecast’
      All declared Imports should be used.
    ```

# tipr

Version: 0.1.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpQwqzBR/Rd2pdfcb98659ecf18'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘tibble’
      All declared Imports should be used.
    ```

# TPP

Version: 3.8.1

## In both

*   R CMD check timed out
    

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

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpiBg3GL/Rd2pdfd1611bc94661'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘gimms’
    ```

# widyr

Version: 0.1.1

## In both

*   checking PDF version of manual without hyperrefs or index ... ERROR
    ```
    Re-running with no redirection of stdout/stderr.
    Hmm ... looks like a package
    You may want to clean up by 'rm -Rf /var/folders/30/hnwqgmvn6cl_mvs6l1486jnh0000gp/T//RtmpkQA8pL/Rd2pdfd68173b67dd4'
    ```

*   checking PDF version of manual ... WARNING
    ```
    LaTeX errors when creating PDF version.
    This typically indicates Rd problems.
    ```

# yardstick

Version: 0.0.1

## In both

*   R CMD check timed out
    

