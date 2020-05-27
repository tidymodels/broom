# allestimates

<details>

* Version: 0.1.6
* Source code: https://github.com/cran/allestimates
* Date/Publication: 2020-02-05 16:30:12 UTC
* Number of recursive dependencies: 75

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
    Warning: Unknown or uninitialised column: `n`.
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
* Number of recursive dependencies: 76

Run `revdep_details(,"arsenal")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      'confint_tidy' is not an exported object from 'namespace:broom'
      Backtrace:
        1. testthat::expect_identical(...)
       11. arsenal::modelsum(...)
       12. arsenal:::modelsum_guts(...)
       13. broom::confint_tidy
       14. base::getExportedValue(pkg, name)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 426 | SKIPPED: 12 | WARNINGS: 12 | FAILED: 2 ]
      1. Error: ordinal works (@test_modelsum.R#213) 
      2. Error: 08/01/2017: Beth Atkinson's subset problem (@test_modelsum.R#359) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘broom::confint_tidy’
    ```

# biobroom

<details>

* Version: 1.18.0
* Source code: https://github.com/cran/biobroom
* URL: https://github.com/StoreyLab/biobroom
* BugReports: https://github.com/StoreyLab/biobroom/issues
* Date/Publication: 2019-10-29
* Number of recursive dependencies: 141

Run `revdep_details(,"biobroom")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [1mBacktrace:[22m
      [90m 1. [39mgenerics::tidy(dds)
      [90m 2. [39mbiobroom::tidy.EList(dds)
      [90m 3. [39mbiobroom:::tidy_matrix(x$E)
      [90m 7. [39mbroom::fix_data_frame
      [90m 8. [39mbase::getExportedValue(pkg, name)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 33 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 3 ]
      1. Error: limma tidier works as expected (@test-limma_tidiers.R#5) 
      2. Error: voom tidier adds weight column (@test-limma_tidiers.R#26) 
      3. Error: voomWithQualityWeights tidier adds weight and sample.weight columns (@test-limma_tidiers.R#49) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## Newly fixed

*   checking whether package ‘biobroom’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘broom’ was built under R version 3.6.2
    See ‘/Users/max/github/broom/revdep/checks.noindex/biobroom/old/biobroom.Rcheck/00install.out’ for details.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    'library' or 'require' call to ‘DESeq2’ in package code.
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    Missing or unexported objects:
      ‘broom::fix_data_frame’ ‘dplyr::tbl_dt’
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

# breathtestcore

<details>

* Version: 0.6.0
* Source code: https://github.com/cran/breathtestcore
* URL: https://github.com/dmenne/breathtestcore
* BugReports: https://github.com/dmenne/breathtestcore/issues
* Date/Publication: 2020-03-22 02:50:02 UTC
* Number of recursive dependencies: 88

Run `revdep_details(,"breathtestcore")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > fit = nls_fit(data)
    > coef_by_group(fit)
    Error: `by` can't contain join column `lhs` which is missing from LHS
    Backtrace:
    [90m     [39m█
    [90m  1. [39m├─breathtestcore::coef_by_group(fit)
    [90m  2. [39m├─breathtestcore:::coef_by_group.breathtestfit(fit)
    [90m  3. [39m│ └─`%>%`(...)
    [90m  4. [39m│   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
    [90m  5. [39m│   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
    [90m  6. [39m│     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
    [90m  7. [39m│       └─breathtestcore:::`_fseq`(`_lhs`)
    [90m  8. [39m│         └─magrittr::freduce(value, `_function_list`)
    [90m  9. [39m│           └─function_list[[i]](value)
    [90m 10. [39m│             ├─dplyr::do(...)
    [90m 11. [39m│             └─dplyr:::do.grouped_df(...)
    [90m 12. [39m│               └─rlang::eval_tidy(args[[j]], mask)
    [90m 13. [39m└─`%>%`(...)
    [90m 14. [39m  ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
    [
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      [90m 24. [39mdplyr:::common_by.list(by, x, y)
      [90m 25. [39mdplyr:::bad_args(...)
      [90m 26. [39mdplyr:::glubort(fmt_args(args), ..., .envir = .envir)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 333 | SKIPPED: 4 | WARNINGS: 1 | FAILED: 6 ]
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

# CGPfunctions

<details>

* Version: 0.6.0
* Source code: https://github.com/cran/CGPfunctions
* URL: https://github.com/ibecav/CGPfunctions
* BugReports: https://github.com/ibecav/CGPfunctions/issues
* Date/Publication: 2020-04-02 14:10:03 UTC
* Number of recursive dependencies: 174

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
* Number of recursive dependencies: 77

Run `revdep_details(,"chest")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    Warning: Unknown or uninitialised column: `n`.
    
    Error in data.frame(out, p, n) : 
      arguments imply differing number of rows: 8, 0
    Calls: chest_clogit -> data.frame
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

*   checking installed package size ... NOTE
    ```
      installed size is  7.7Mb
      sub-directories of 1Mb or more:
        libs   5.0Mb
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

## Newly fixed

*   checking whether package ‘DeLorean’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/max/github/broom/revdep/checks.noindex/DeLorean/old/DeLorean.Rcheck/00install.out’ for details.
    ```

# disk.frame

<details>

* Version: 0.3.5
* Source code: https://github.com/cran/disk.frame
* URL: https://diskframe.com
* BugReports: https://github.com/xiaodaigh/disk.frame/issues
* Date/Publication: 2020-05-08 13:10:10 UTC
* Number of recursive dependencies: 105

Run `revdep_details(,"disk.frame")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    +   # only run in interactive()
    +   setup_disk.frame(gui = TRUE)
    + }
    > 
    > # set the number workers to 2
    > setup_disk.frame(2)
    Warning in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  :
      port 37400 cannot be opened
    Error in socketConnection("localhost", port = port, server = TRUE, blocking = TRUE,  : 
      Failed to launch and connect to R worker on local machine ‘localhost’ from local machine ‘imp.atlanticbb.net’.
     * The error produced by socketConnection() was: ‘cannot open the connection’
     * In addition, socketConnection() produced 1 warning(s):
       - Warning #1: ‘port 37400 cannot be opened’ (which suggests that this port is either already occupied by another process or blocked by the firewall on your local machine)
     * The localhost socket connection that failed to connect to the R worker used port 37400 using a communication timeout of 120 seconds and a connection timeout of 120 seconds.
     * Worker launch call: '/Library/Frameworks/R.framework/Resources/bin/Rscript' --default-packages=datasets,utils,grDevices,graphics,stats,methods -e '#label=UNKNOWN:56671:imp.atlanticbb.net:max' -e 'try(suppressWarnings(cat(Sys.getpid(),file="/var/folders/lb/xhxqmcrd7gv302_b1pdfykh80000gn/T//RtmpqhMLhX/future.parent=56671.dd5f59ec707e.pid")), silent = TRUE)' -e 'parallel:::.slaveRSOCK()' MASTER=localhost PORT=37400 OUT=/dev/null TIMEOUT=120 XDR=TRUE.
     * Worker (PID 57088) was successfully killed: TRUE
     * Troubleshooting suggestions:
       - Suggestion #1: Set 'verbose=TRUE' to see more details.
       - Suggestion #2: Set 'outfile=NULL' to see output from worker.
    Calls: setup_disk.frame ... tryCatchList -> tryCatchOne -> <Anonymous> -> <Anonymous>
    Execution halted
    ```

## In both

*   checking whether package ‘disk.frame’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘purrr’ was built under R version 3.6.2
    See ‘/Users/max/github/broom/revdep/checks.noindex/disk.frame/new/disk.frame.Rcheck/00install.out’ for details.
    ```

# disto

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/disto
* URL: https://github.com/talegari/disto
* BugReports: https://github.com/talegari/disto/issues
* Date/Publication: 2018-08-02 12:50:02 UTC
* Number of recursive dependencies: 122

Run `revdep_details(,"disto")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘disto-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: summary.disto
    > ### Title: Summary method for dist class
    > ### Aliases: summary.disto
    > 
    > ### ** Examples
    > 
    > temp <- stats::dist(iris[,1:4])
    > dio   <- disto(objectname = "temp")
    > dio
    disto with backend: dist
    size: 150
    > summary(dio)
    Warning: 'tidy.table' is deprecated.
    See help("Deprecated")
    Error in dimnames(x) <- dnx : 'dimnames' applied to non-array
    Calls: summary ... eval -> eval -> data.frame -> do.call -> provideDimnames
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dplyr’ ‘proxy’
      All declared Imports should be used.
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
* Number of recursive dependencies: 82

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
      [ OK: 27 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 2 ]
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
* Number of recursive dependencies: 61

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

# GGally

<details>

* Version: 1.5.0
* Source code: https://github.com/cran/GGally
* URL: https://ggobi.github.io/ggally, https://github.com/ggobi/ggally
* BugReports: https://github.com/ggobi/ggally/issues
* Date/Publication: 2020-03-25 18:20:15 UTC
* Number of recursive dependencies: 133

Run `revdep_details(,"GGally")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘GGally-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: ggally_nostic_se_fit
    > ### Title: ggnostic - fitted value standard error
    > ### Aliases: ggally_nostic_se_fit
    > 
    > ### ** Examples
    > 
    > dt <- broomify(stats::lm(mpg ~ wt + qsec + am, data = mtcars))
    > ggally_nostic_se_fit(dt, ggplot2::aes(wt, .se.fit))
    Error in FUN(X[[i]], ...) : object '.se.fit' not found
    Calls: <Anonymous> ... <Anonymous> -> f -> scales_add_defaults -> lapply -> FUN
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("GGally")
      [31m──[39m [31m1. Error: ggnostic mtcars (@test-ggnostic.R#64) [39m [31m────────────────────────────[39m
      Columns in 'columnsY' not found in data: c('.se.fit'). Choices: c('.rownames', 'mpg', 'wt', 'qsec', 'am', '.fitted', '.resid', '.std.resid', '.hat', '.sigma', '.cooksd')
      [1mBacktrace:[22m
      [90m 1. [39mGGally::ggnostic(...)
      [90m 2. [39mGGally::ggduo(...)
      [90m 3. [39mGGally:::fix_column_values(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 757 | SKIPPED: 0 | WARNINGS: 2 | FAILED: 1 ]
      1. Error: ggnostic mtcars (@test-ggnostic.R#64) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# ggasym

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/ggasym
* URL: https://github.com/jhrcook/ggasym https://jhrcook.github.io/ggasym/
* BugReports: https://github.com/jhrcook/ggasym/issues
* Date/Publication: 2020-04-03 20:10:02 UTC
* Number of recursive dependencies: 101

Run `revdep_details(,"ggasym")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("ggasym")
      Error : No tidy method for objects of class character
      [31m──[39m [31m1. Error: stats asymmetrization works (@test-asymmetrise_stats.R#13) [39m [31m───────[39m
      Could not handle input data; try turning into a tibble using the broom package
      [1mBacktrace:[22m
      [90m 1. [39mtestthat::expect_warning(prepare_data(grps))
      [90m 6. [39mggasym::prepare_data(grps)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 260 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Error: stats asymmetrization works (@test-asymmetrise_stats.R#13) 
      
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

# gtsummary

<details>

* Version: 1.3.0
* Source code: https://github.com/cran/gtsummary
* URL: https://github.com/ddsjoberg/gtsummary, http://www.danieldsjoberg.com/gtsummary/
* BugReports: https://github.com/ddsjoberg/gtsummary/issues
* Date/Publication: 2020-04-17 08:00:02 UTC
* Number of recursive dependencies: 151

Run `revdep_details(,"gtsummary")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### Title: Vetted tidy models
    > ### Aliases: vetted_models
    > ### Keywords: internal
    > 
    > ### ** Examples
    > 
    > my_tidy <- function(x, exponentiate =  FALSE, conf.level = 0.95, ...) {
    +   tidy <-
    +     dplyr::bind_cols(
    +       broom::tidy(x, conf.int = FALSE),
    +       broom::confint_tidy(x, func = stats::confint.default, conf.level = conf.level)
    +     )
    +   # exponentiating, if requested
    +   if (exponentiate == TRUE)
    +     tidy <- dplyr::mutate_at(vars(estimate, conf.low, conf.high), exp)
    + }
    > 
    > lm(age ~ grade + response, trial) %>%
    +   my_tidy()
    Error: 'confint_tidy' is not an exported object from 'namespace:broom'
    Execution halted
    ```

# jtools

<details>

* Version: 2.0.5
* Source code: https://github.com/cran/jtools
* URL: https://jtools.jacob-long.com
* BugReports: https://github.com/jacob-long/jtools/issues
* Date/Publication: 2020-04-21 12:20:12 UTC
* Number of recursive dependencies: 125

Run `revdep_details(,"jtools")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [90m  4. [39mjtools::plot_summs(regmodel, scale = T)
      [90m  6. [39mjtools::plot_coefs(...)
      [90m  7. [39mjtools:::make_tidies(...)
      [90m 10. [39mjtools:::tidy.summ(...)
      [90m 14. [39mbroom:::tidy.svyglm(...)
      [90m 15. [39mbroom:::broom_confint_terms(x, level = conf.level, ...)
      [90m 17. [39mellipsis:::action_dots(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 358 | SKIPPED: 0 | WARNINGS: 13 | FAILED: 2 ]
      1. Error: plot_summs works with svyglm (@test-export-summs.R#211) 
      2. Error: plot_summs accepts summ args with svyglm (@test-export-summs.R#216) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘wec’, ‘interactions’, ‘piecewiseSEM’
    ```

# konfound

<details>

* Version: 0.2.1
* Source code: https://github.com/cran/konfound
* URL: https://github.com/jrosen48/konfound
* BugReports: https://github.com/jrosen48/konfound/issues
* Date/Publication: 2020-02-26 14:50:02 UTC
* Number of recursive dependencies: 113

Run `revdep_details(,"konfound")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
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
    Warning: package ‘lme4’ was built under R version 3.6.2
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
      [ OK: 0 | SKIPPED: 0 | WARNINGS: 4 | FAILED: 2 ]
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

# merTools

<details>

* Version: 0.5.0
* Source code: https://github.com/cran/merTools
* BugReports: https://www.github.com/jknowles/merTools
* Date/Publication: 2019-05-13 12:30:06 UTC
* Number of recursive dependencies: 131

Run `revdep_details(,"merTools")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘merTools-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: lmerModList
    > ### Title: Apply a multilevel model to a list of data frames
    > ### Aliases: lmerModList blmerModList glmerModList bglmerModList
    > 
    > ### ** Examples
    > 
    > sim_list <- replicate(n = 10,
    +         expr = sleepstudy[sample(row.names(sleepstudy), 180),],
    +         simplify=FALSE)
    > fml <- "Reaction ~ Days + (Days | Subject)"
    > mod <- lmerModList(fml, data = sim_list)
    > summary(mod)
    Error: No tidy method for objects of class lmerMod
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat-a_p.R’ failed.
    Last 13 lines of output:
      [31m──[39m [31m1. Error: print methods work for merModList (@test-merModList.R#58) [39m [31m────────[39m
      No tidy method for objects of class lmerMod
      [1mBacktrace:[22m
      [90m 1. [39mbase::summary(g1)
      [90m 2. [39mmerTools:::summary.merModList(g1)
      [90m 3. [39mmerTools::modelFixedEff(modList)
      [90m 4. [39mbase::lapply(modList, tidy, effects = "fixed", ...)
      [90m 6. [39mbroom:::tidy.default(X[[i]], ...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 285 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: print methods work for merModList (@test-merModList.R#58) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking whether package ‘merTools’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘arm’ was built under R version 3.6.2
      Warning: package ‘MASS’ was built under R version 3.6.2
      Warning: package ‘lme4’ was built under R version 3.6.2
    See ‘/Users/max/github/broom/revdep/checks.noindex/merTools/new/merTools.Rcheck/00install.out’ for details.
    ```

# mice

<details>

* Version: 3.9.0
* Source code: https://github.com/cran/mice
* URL: https://github.com/stefvanbuuren/mice, https://stefvanbuuren.name/mice/, https://stefvanbuuren.name/fimd/
* BugReports: https://github.com/stefvanbuuren/mice/issues
* Date/Publication: 2020-05-14 15:20:03 UTC
* Number of recursive dependencies: 85

Run `revdep_details(,"mice")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘mice-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: D3
    > ### Title: Compare two nested models using D3-statistic
    > ### Aliases: D3
    > 
    > ### ** Examples
    > 
    > # Compare two linear models:
    > imp <- mice(nhanes2, seed = 51009, print = FALSE)
    > mi1 <- with(data = imp, expr = lm(bmi ~ age + hyp + chl))
    > mi0 <- with(data = imp, expr = lm(bmi ~ age + hyp))
    > D3(mi1, mi0)
    Error in eval_tidy(xs[[j]], mask) : object 'fstatistic' not found
    Calls: D3 ... with.default -> eval -> eval -> tibble -> tibble_quos -> eval_tidy
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [90m 19. [39mbroom:::glance.lm(X[[i]], ...)
      [90m 21. [39mbase::with.default(...)
      [90m 22. [39m[ base::eval(...) ][90m with 1 more call[39m
      [90m 24. [39mtibble::tibble(...)
      [90m 25. [39mtibble:::tibble_quos(xs[!is_null], .rows, .name_repair)
      [90m 26. [39mrlang::eval_tidy(xs[[j]], mask)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 280 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 3 ]
      1. Error: (unknown) (@test-D3.R#10) 
      2. Error: anova.mira() produces silent D1 and D3 (@test-anova.R#9) 
      3. Error: anova.mira() produces warnings on D2 (@test-anova.R#14) 
      
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
* Number of recursive dependencies: 120

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
      [ OK: 33 | SKIPPED: 11 | WARNINGS: 3 | FAILED: 1 ]
      1. Failure: README code works (@test-get_regression_functions.R#91) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘openintro’
    ```

# NetworkExtinction

<details>

* Version: 0.1.1
* Source code: https://github.com/cran/NetworkExtinction
* URL: https://derek-corcoran-barrios.github.io/NetworkExtintion/
* Date/Publication: 2019-10-27 22:20:02 UTC
* Number of recursive dependencies: 85

Run `revdep_details(,"NetworkExtinction")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘NetworkExtinction-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: degree_distribution
    > ### Title: Degree distribution of the network
    > ### Aliases: degree_distribution
    > 
    > ### ** Examples
    > 
    > library(NetworkExtinction)
    > data("net")
    > degree_distribution(net, name = "Test")
    Warning: Unknown or uninitialised column: `.resid`.
    Error in ks.test(augment(exp.model)$.resid, y = "pnorm", alternative = "two.sided") : 
      not enough 'x' data
    Calls: degree_distribution -> ifelse -> tidy -> ks.test
    Execution halted
    ```

# nlstimedist

<details>

* Version: 1.1.4
* Source code: https://github.com/cran/nlstimedist
* URL: https://github.com/nathaneastwood/nlstimedist
* BugReports: https://github.com/nathaneastwood/nlstimedist/issues
* Date/Publication: 2019-05-15 21:40:03 UTC
* Number of recursive dependencies: 72

Run `revdep_details(,"nlstimedist")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > tdTilia <- tdData(tilia, x = "Day", y = "Trees")
    > model <- timedist(data = tdTilia, x = "Day", y = "propMax", r = 0.1, c = 0.5,
    +                   t = 120)
    > tdCdfPlot(model)
    Error: Can't subset columns that don't exist.
    [31m✖[39m Column `.resid` doesn't exist.
    Backtrace:
    [90m     [39m█
    [90m  1. [39m├─nlstimedist::tdCdfPlot(model)
    [90m  2. [39m│ ├─data[, c(nameMod, ".fitted", ".resid")]
    [90m  3. [39m│ └─tibble:::`[.tbl_df`(data, , c(nameMod, ".fitted", ".resid"))
    [90m  4. [39m│   └─tibble:::tbl_subset_col(x, j = j, j_arg)
    [90m  5. [39m│     └─tibble:::vectbl_as_col_index(j, x, j_arg = j_arg)
    [90m  6. [39m│       └─tibble:::vectbl_as_col_location(...)
    [90m  7. [39m│         ├─tibble:::subclass_col_index_errors(...)
    [90m  8. [39m│         │ ├─base::tryCatch(...)
    [90m  9. [39m│         │ │ └─base:::tryCatchList(expr, classes, parentenv, handlers)
    [90m 10. [39m│         │ │   └─base:::tryCatchOne(expr, names, parentenv, handlers[[1L]])
    [90m 11. [39m│         │ │     └─base:::doTryCatch(return(expr), name, parentenv, handler)
    [90m 12. [39m│         
    Execution halted
    ```

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
      [ OK: 6 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: Ensure the glance method is returning expected values (@test-glance.timedist.R#17) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# panelr

<details>

* Version: 0.7.2
* Source code: https://github.com/cran/panelr
* URL: https://panelr.jacob-long.com
* BugReports: https://github.com/jacob-long/panelr
* Date/Publication: 2020-03-08 22:10:02 UTC
* Number of recursive dependencies: 168

Run `revdep_details(,"panelr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘panelr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: tidy.wbm
    > ### Title: Tidy methods for 'wbm' models
    > ### Aliases: tidy.wbm glance.wbm glance.summ.wbm tidy.summ.wbm
    > 
    > ### ** Examples
    > 
    > data("WageData")
    > wages <- panel_data(WageData, id = id, wave = t)
    > model <- wbm(lwage ~ lag(union) + wks, data = wages)
    > if (requireNamespace("broom")) {
    +   broom::tidy(model)
    + }
    Error: No tidy method for objects of class lmerMod
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("panelr")
      [31m──[39m [31m1. Error: tidy works (@test-utils.R#341) [39m [31m───────────────────────────────────[39m
      No tidy method for objects of class lmerMod
      [1mBacktrace:[22m
      [90m 1. [39mtestthat::expect_is(tidy.wbm(wb), "tbl_df")
      [90m 4. [39mpanelr:::tidy.wbm(wb)
      [90m 6. [39mbroom:::tidy.default(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 291 | SKIPPED: 0 | WARNINGS: 2436 | FAILED: 1 ]
      1. Error: tidy works (@test-utils.R#341) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking whether package ‘panelr’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘lme4’ was built under R version 3.6.2
    See ‘/Users/max/github/broom/revdep/checks.noindex/panelr/new/panelr.Rcheck/00install.out’ for details.
    ```

# pixiedust

<details>

* Version: 0.9.0
* Source code: https://github.com/cran/pixiedust
* URL: https://github.com/nutterb/pixiedust
* BugReports: https://github.com/nutterb/pixiedust/issues
* Date/Publication: 2020-05-15 05:50:10 UTC
* Number of recursive dependencies: 65

Run `revdep_details(,"pixiedust")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("pixiedust")
      [31m──[39m [31m1. Error: dust runs when passed a data frame with tidy_df = TRUE (@test-dust.[39m
      No tidy method for objects of class data.frame
      [1mBacktrace:[22m
      [90m  1. [39mtestthat::expect_warning(dust(mtcars, tidy_df = TRUE))
      [90m  7. [39mpixiedust:::dust.default(mtcars, tidy_df = TRUE)
      [90m 10. [39mbroom:::tidy.default(object, ...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 512 | SKIPPED: 120 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: dust runs when passed a data frame with tidy_df = TRUE (@test-dust.R#52) 
      
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
* Number of recursive dependencies: 155

Run `revdep_details(,"radiant.model")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      SI1     9 114304.420 104924.680 123684.159  9379.739
      sex|male    0.080 -92.0%      -2.522     0.163 -15.447  < .001 ***
      2nd female      0.779 0.712 0.833
      1st female      0.896 0.856 0.926
      1st female 29.000      0.919 0.880 0.945
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 24 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: regress (@test_stats.R#23) 
      
      Error: testthat unit tests failed
      In addition: Warning messages:
      1: package 'lubridate' was built under R version 3.6.2 
      2: package 'tidyr' was built under R version 3.6.2 
      Execution halted
    ```

## In both

*   checking whether package ‘radiant.model’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘lubridate’ was built under R version 3.6.2
      Warning: package ‘tidyr’ was built under R version 3.6.2
    See ‘/Users/max/github/broom/revdep/checks.noindex/radiant.model/new/radiant.model.Rcheck/00install.out’ for details.
    ```

# RCT

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/RCT
* Date/Publication: 2020-05-13 06:20:10 UTC
* Number of recursive dependencies: 80

Run `revdep_details(,"RCT")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### Title: Impact Evaluation of Treatment Effects
    > ### Aliases: impact_eval
    > 
    > ### ** Examples
    > 
    > data <- data.frame(y_1 = rnorm(n = 100, mean = 100, sd = 15), 
    +                   y_2 = rnorm(n = 100, mean = 8, sd = 2), 
    +                   treat = rep(c(0,1,2,3), each = 25), 
    +                   heterogenous_var1 = rep(c("X_Q1", "X_Q2", "X_Q3", "X_Q4"), times = 25),
    +                   cluster_var1 = rep(c(1:5), times = 20), 
    +                   fixed_effect_var1 = rep(c(1,2), times = 50),
    +                   control_var1 = rnorm(n = 100, mean = 20, sd = 1))
    > 
    > evaluation<-impact_eval(data = data, 
    +                        endogenous_vars = c("y_1", "y_2"), 
    +                        treatment = "treat", 
    +                        heterogenous_vars = c("heterogenous_var1"), 
    +                        cluster_vars = "cluster_var1", fixed_effect_vars = c("fixed_effect_var1"), 
    +                        control_vars = c("control_var1"))
    Error: No tidy method for objects of class rowwise_df
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      No tidy method for objects of class rowwise_df
      [1mBacktrace:[22m
      [90m  1. [39mRCT::impact_eval(...)
      [90m  2. [39mpurrr::map2(...)
      [90m  3. [39mRCT:::.f(.x[[1L]], .y[[1L]], ...)
      [90m  4. [39mdplyr::group_by(., !!rlang::sym(x))
      [90m  4. [39mdplyr::do(., fit = lfe::felm(stats::as.formula(y), data = .))
      [90m 12. [39mbroom::tidy(., fit)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 79 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: (unknown) (@test_impact_eval.R#64) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# rstatix

<details>

* Version: 0.5.0
* Source code: https://github.com/cran/rstatix
* URL: https://rpkgs.datanovia.com/rstatix/
* BugReports: https://github.com/kassambara/rstatix/issues
* Date/Publication: 2020-04-28 10:40:02 UTC
* Number of recursive dependencies: 127

Run `revdep_details(,"rstatix")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Running examples in ‘rstatix-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: emmeans_test
    > ### Title: Pairwise Comparisons of Estimated Marginal Means
    > ### Aliases: emmeans_test get_emmeans
    > 
    > ### ** Examples
    > 
    > # Data preparation
    > df <- ToothGrowth
    > df$dose <- as.factor(df$dose)
    > 
    > # Pairwise comparisons
    > res <- df %>%
    +  group_by(supp) %>%
    +  emmeans_test(len ~ dose, p.adjust.method = "bonferroni")
    Error in summary.emmGrid(x, ...) : 
      formal argument "infer" matched by multiple actual arguments
    Calls: %>% ... <Anonymous> -> tidy -> tidy.emmGrid -> tidy_emmeans -> summary
    Execution halted
    ```

# simglm

<details>

* Version: 0.7.4
* Source code: https://github.com/cran/simglm
* Date/Publication: 2019-05-31 17:10:03 UTC
* Number of recursive dependencies: 90

Run `revdep_details(,"simglm")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > with_err_gen <- 'rnorm'
    > data_str <- "long"
    > pow_param <- c('time', 'diff', 'act', 'actClust')
    > alpha <- .01
    > pow_dist <- "z"
    > pow_tail <- 2
    > replicates <- 1
    > power_out <- sim_pow(fixed = fixed, random = random, random3 = random3,
    +                      fixed_param = fixed_param, 
    +                      random_param = random_param, 
    +                      random_param3 = random_param3, 
    +                      cov_param = cov_param, 
    +                      k = k, n = n, p = p,
    +                      error_var = error_var, with_err_gen = "rnorm",
    +                      data_str = data_str, 
    +                      unbal = list(level3 = FALSE, level2 = FALSE), 
    +                      pow_param = pow_param, alpha = alpha,
    +                      pow_dist = pow_dist, pow_tail = pow_tail, 
    +                      replicates = replicates, raw_power = FALSE)
    Error: No tidy method for objects of class lmerMod
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [90m  7. [39msimglm:::FUN(X[[i]], ...)
      [90m 10. [39msimglm::sim_pow_glm_nested3(...)
      [90m 12. [39mbroom:::tidy.default(temp_mod, effects = "fixed")
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 125 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 6 ]
      1. Error: three level power continuous (@test_power_struc.r#169) 
      2. Error: two level power dich (@test_power_struc.r#203) 
      3. Error: three level power dich (@test_power_struc.r#238) 
      4. Error: three level power continuous (@test_power_vary.r#91) 
      5. Error: two level power dich (@test_power_vary.r#128) 
      6. Error: three level power dich (@test_power_vary.r#166) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# survminer

<details>

* Version: 0.4.6
* Source code: https://github.com/cran/survminer
* URL: http://www.sthda.com/english/rpkgs/survminer/
* BugReports: https://github.com/kassambara/survminer/issues
* Date/Publication: 2019-09-03 23:00:02 UTC
* Number of recursive dependencies: 119

Run `revdep_details(,"survminer")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
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
    Warning: package ‘survival’ was built under R version 3.6.2
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

*   checking whether package ‘survminer’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘ggpubr’ was built under R version 3.6.2
    See ‘/Users/max/github/broom/revdep/checks.noindex/survminer/new/survminer.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        doc   5.1Mb
    ```

# survutils

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/survutils
* URL: https://github.com/tinyheero/survutils
* BugReports: https://github.com/tinyheero/survutils/issues
* Date/Publication: 2018-07-22 17:50:02 UTC
* Number of recursive dependencies: 61

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
      [ OK: 6 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
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
* Number of recursive dependencies: 142

Run `revdep_details(,"sweep")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > library(forecast)
    Warning: package ‘forecast’ was built under R version 3.6.2
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
      [90m 2. [39msweep:::sw_glance.robets(fit_robets)
      [90m 6. [39mbroom::finish_glance
      [90m 7. [39mbase::getExportedValue(pkg, name)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 143 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 6 ]
      1. Error: sw_sweep test returns tibble with correct rows and columns. (@test_sw_sweep.R#156) 
      2. Error: sw_*.Arima test returns tibble with correct rows and columns. (@test_tidiers_arima.R#19) 
      3. Error: sw_*.ets test returns tibble with correct rows and columns. (@test_tidiers_ets.R#19) 
      4. Failure: sw_*.default test returns tibble with correct rows and columns. (@test_tidiers_lm.R#22) 
      5. Failure: sw_*.default test returns tibble with correct rows and columns. (@test_tidiers_lm.R#32) 
      6. Error: sw_*.robets test returns tibble with correct rows and columns. (@test_tidiers_robets.R#19) 
      
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

# SWMPrExtension

<details>

* Version: 1.1.4
* Source code: https://github.com/cran/SWMPrExtension
* BugReports: https://github.com/NOAA-OCM/SWMPrExtension/issues
* Date/Publication: 2020-05-04 15:10:11 UTC
* Number of recursive dependencies: 120

Run `revdep_details(,"SWMPrExtension")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘SWMPrExtension-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: seasonal_dot
    > ### Title: Seasonal Dot Plot
    > ### Aliases: seasonal_dot seasonal_dot.swmpr
    > 
    > ### ** Examples
    > 
    > dat_wq <- elksmwq
    > #dat_wq <- subset(dat_wq, subset = c('2010-01-01 0:00', '2017-01-01 0:00'))
    > dat_wq <- qaqc(dat_wq, qaqc_keep = c(0, 3, 5))
    > 
    > x <-
    +   seasonal_dot(dat_wq, param = 'do_mgl'
    +                , lm_trend = TRUE
    +                , lm_lab = TRUE
    +                , plot_title = TRUE)
    Error: No tidy method for objects of class rowwise_df
    Execution halted
    ```

## In both

*   checking whether package ‘SWMPrExtension’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘zoo’ was built under R version 3.6.2
    See ‘/Users/max/github/broom/revdep/checks.noindex/SWMPrExtension/new/SWMPrExtension.Rcheck/00install.out’ for details.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rgeos’
      All declared Imports should be used.
    ```

# tadaatoolbox

<details>

* Version: 0.16.1
* Source code: https://github.com/cran/tadaatoolbox
* URL: https://github.com/tadaadata/tadaatoolbox
* BugReports: https://github.com/tadaadata/tadaatoolbox/issues
* Date/Publication: 2018-11-23 11:20:04 UTC
* Number of recursive dependencies: 118

Run `revdep_details(,"tadaatoolbox")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    [90m 6[39m jahrgang:… 13:Männlich-11…          0   1.16    -[31m0[39m[31m.[39m[31m190[39m      2.51  0.138      
    [90m 7[39m jahrgang:… 11:Weiblich-11…          0   1.58     0.478      2.68  0.000[4m7[24m[4m3[24m[4m6[24m   
    [90m 8[39m jahrgang:… 12:Weiblich-11…          0   0.940   -[31m0[39m[31m.[39m[31m162[39m      2.04  0.143      
    [90m 9[39m jahrgang:… 13:Weiblich-11…          0   2.76     1.41       4.11  0.000[4m0[24m[4m0[24m[4m0[24m207
    [90m10[39m jahrgang:… 13:Männlich-12…          0   0.420   -[31m0[39m[31m.[39m[31m930[39m      1.77  0.948      
    [90m11[39m jahrgang:… 11:Weiblich-12…          0   0.840   -[31m0[39m[31m.[39m[31m262[39m      1.94  0.246      
    [90m12[39m jahrgang:… 12:Weiblich-12…          0   0.200   -[31m0[39m[31m.[39m[31m902[39m      1.30  0.995      
    [90m13[39m jahrgang:… 13:Weiblich-12…          0   2.02     0.670      3.37  0.000[4m3[24m[4m5[24m[4m4[24m   
    [90m14[39m jahrgang:… 11:Weiblich-13…          0   0.420   -[31m0[39m[31m.[39m[31m930[39m      1.77  0.948      
    [90m15[39m jahrgang:… 12:Weiblich-13…          0  -[31m0[39m[31m.[39m[31m220[39m   -[31m1[39m[31m.[39m[31m57[39m       1.13  0.997      
    [90m16[39m jahrgang:… 13:Weiblich-13…          0   1.60     0.041[4m5[24m     3.16  0.040[4m4[24m     
    [90m17[39m jahrgang:… 12:Weiblich-11…          0  -[31m0[39m[31m.[39m[31m640[39m   -[31m1[39m[31m.[39m[31m74[39m       0.462 0.554      
    [90m18[39m jahrgang:… 13:Weiblich-11…          0   1.18    -[31m0[39m[31m.[39m[31m170[39m      2.53  0.125      
    [90m19[39m jahrgang:… 13:Weiblich-12…          0   1.82     0.470      3.17  0.001[4m9[24m[4m0[24m    
    > tadaa_pairwise_tukey(data = ngo, deutsch, jahrgang, print = "console")
    Error in tadaa_pairwise_tukey(data = ngo, deutsch, jahrgang, print = "console") : 
      1 assertions failed:
     * The following variable names are not found in the dust table:
     * comparison
    Calls: tadaa_pairwise_tukey ... <Anonymous> -> sprinkle_colnames.default -> <Anonymous>
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [90m  6. [39mtibble:::`$<-.tbl_df`(...)
      [90m  7. [39mtibble:::tbl_subassign(...)
      [90m  8. [39mtibble:::vectbl_recycle_rhs(...)
      [90m  9. [39mbase::tryCatch(...)
      [90m 10. [39mbase:::tryCatchList(expr, classes, parentenv, handlers)
      [90m 11. [39mbase:::tryCatchOne(expr, names, parentenv, handlers[[1L]])
      [90m 12. [39mvalue[[3L]](cond)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 153 | SKIPPED: 1 | WARNINGS: 32 | FAILED: 2 ]
      1. Error: Pairwise tukey returns correct data structure (@test-pairwise_tests.R#50) 
      2. Error: tadaa_pairwise_tukey produces plot (@test-plots.R#27) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3 marked UTF-8 strings
    ```

# timetk

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/timetk
* URL: https://github.com/business-science/timetk
* BugReports: https://github.com/business-science/timetk/issues
* Date/Publication: 2020-04-19 17:50:02 UTC
* Number of recursive dependencies: 150

Run `revdep_details(,"timetk")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Business Science offers a 1-hour course - Learning Lab #9: Performance Analysis & Portfolio Optimization with tidyquant!
    [39m[34m</> Learn more at: https://university.business-science.io/p/learning-labs-pro </>[39m
    
    Attaching package: ‘tidyquant’
    
    The following objects are masked from ‘package:timetk’:
    
        summarise_by_time, summarize_by_time
    
    > library(timetk)
    > 
    > # Filter values in January 1st through end of February, 2013
    > FANG %>%
    +     group_by(symbol) %>%
    +     filter_by_time(date, "start", "2013-02") %>%
    +     plot_time_series(date, adjusted, .facet_ncol = 2, .interactive = FALSE)
    Warning: 'tidy.table' is deprecated.
    See help("Deprecated")
    Error in dimnames(x) <- dnx : 'dimnames' applied to non-array
    Calls: %>% ... eval -> eval -> data.frame -> do.call -> provideDimnames
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 233 | SKIPPED: 0 | WARNINGS: 7 | FAILED: 10 ]
      1.  Error: tk_get_timeseries_summary(datetime) test returns correct format. (@test_tk_get_timeseries.R#79) 
      2.  Error: tk_get_timeseries_summary(date) test returns correct format. (@test_tk_get_timeseries.R#91) 
      3.  Error: tk_get_timeseries_summary(yearmon) test returns correct format. (@test_tk_get_timeseries.R#103) 
      4.  Error: tk_get_timeseries_summary(yearqtr) test returns correct format. (@test_tk_get_timeseries.R#116) 
      5.  Error: tk_make_future_timeseries(datetime) test returns correct format. (@test_tk_make_future_timeseries.R#12) 
      6.  Error: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#53) 
      7.  Error: tk_make_future_timeseries(predict_every_two) test returns correct format. (@test_tk_make_future_timeseries.R#309) 
      8.  Error: tk_make_future_timeseries(predict_every_three) test returns correct format. (@test_tk_make_future_timeseries.R#348) 
      9.  Error: tk_make_future_timeseries(predict_every_four) test returns correct format. (@test_tk_make_future_timeseries.R#386) 
      10. Error: tk_make_future_timeseries(predict_random) test returns correct format. (@test_tk_make_future_timeseries.R#430) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.5Mb
      sub-directories of 1Mb or more:
        doc   5.1Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 2750 marked UTF-8 strings
    ```

# widyr

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/widyr
* URL: http://github.com/dgrtwo/widyr
* BugReports: http://github.com/dgrtwo/widyr/issues
* Date/Publication: 2020-04-12 06:00:02 UTC
* Number of recursive dependencies: 113

Run `revdep_details(,"widyr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > dat <- tibble(group = rep(1:5, each = 2),
    +               letter = c("a", "b",
    +                          "a", "c",
    +                          "a", "c",
    +                          "b", "e",
    +                          "b", "f"))
    > 
    > # count the number of times two letters appear together
    > pairwise_count(dat, letter, group)
    Error in `colnames<-`(`*tmp*`, value = c("item1", "item2", "value")) : 
      attempt to set 'colnames' on an object with less than two dimensions
    Calls: pairwise_count ... freduce -> <Anonymous> -> custom_melt -> colnames<-
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 38 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 10 ]
      1.  Error: pairing and counting works (@test-pairwise-count.R#16) 
      2.  Error: We can count with a weight column (@test-pairwise-count.R#63) 
      3.  Error: Counts co-occurrences of words in Pride & Prejudice (@test-pairwise-count.R#79) 
      4.  Error: Can count within groups (@test-pairwise-count.R#104) 
      5.  Error: Can count within groups (@test-pairwise-count.R#103) 
      6.  Error: (unknown) (@test-pairwise-count.R#103) 
      7.  Error: pairwise_similarity computes pairwise cosine similarity (@test-pairwise-similarity.R#14) 
      8.  Error: pairwise_similarity retains factor levels (@test-pairwise-similarity.R#29) 
      9.  Failure: Can perform 'squarely' operations on pairs of items (@test-squarely.R#14) 
      10. Failure: Can perform 'squarely' within groups (@test-squarely.R#25) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

