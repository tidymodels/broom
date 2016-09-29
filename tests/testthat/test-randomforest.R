# test tidy, augment, and glance methods from rf_tidiers.r

context("randomForest tidiers")
suppressPackageStartupMessages(library(randomForest))

if (require(randomForest, quietly = TRUE)) {
    set.seed(100)
    
    # Salt vector with NAs
    v_salt_na <- function(x, m) {
        i <- sample.int(length(x), size = m, replace = FALSE)
        x[i] <- NA
        x
    }
    
    # Add NAs to test dataset so that na.action can be tested
    df_salt_na <- function(df, frac, col_names) {
        m <- round(nrow(df) * frac)
        dplyr::mutate_at(df, .funs = dplyr::funs(v_salt_na(., m)), .cols = col_names)
    }
    
    salted_iris <- df_salt_na(iris, 0.1, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
    
    # Classification rf
    crf <- randomForest(Species ~ ., data = salted_iris, localImp = TRUE, na.action = na.omit)
    crf_fix <- randomForest(Species ~ ., data = salted_iris, localImp = TRUE, na.action = na.roughfix)
    
    crf_cats <- levels(salted_iris[["Species"]])
    crf_vars <- names(salted_iris[, -5])
    
    crf_noimp <- randomForest(Species ~ ., data = salted_iris, importance = FALSE, na.action = na.omit)
    
    # Regression rf
    rrf <- randomForest(Ozone ~ ., data = airquality, mtry = 3,
                        localImp = TRUE, na.action = na.omit)
    rrf_vars <- names(airquality[, -1])
    
    rrf_noimp <- randomForest(Ozone ~ ., data = airquality, mtry = 3,
                        importance = FALSE, na.action = na.omit)
    
    # Unsupervised rf
    urf <- randomForest(iris[, -5], importance = TRUE)
    urf_noimp <- randomForest(iris[, -5], importance = FALSE)
    
    # Tidy ----
    test_that("tidy works on randomForest models", {
        tdc <- tidy(crf)
        tidy_names <- c("term", paste("class", crf_cats, sep = "_"), "MeanDecreaseAccuracy", "MeanDecreaseGini", paste("sd", c(crf_cats, "MeanDecreaseAccuracy"), sep = "_"))
        expect_equal(colnames(tdc), tidy_names)
        expect_equal(tdc[["term"]], crf_vars)
        
        tdc_fix <- tidy(crf_fix)
        expect_equal(colnames(tdc_fix), tidy_names)
        expect_equal(tdc_fix[["term"]], crf_vars)
        
        expect_warning(tdc_noimp <- tidy(crf_noimp), "Only MeanDecreaseGini")
        expect_equal(colnames(tdc_noimp), c("term", "MeanDecreaseGini"))
        expect_equal(tdc_noimp[["term"]], crf_vars)
        
        tdr <- tidy(rrf)
        expect_equal(colnames(tdr), c("term", "X.IncMSE", "IncNodePurity", "imp_sd"))
        expect_equal(tdr[["term"]], rrf_vars)
        
        expect_warning(tdr_noimp <- tidy(rrf_noimp))
        expect_equal(colnames(tdr_noimp), c("term", "IncNodePurity"))
        expect_equal(tdr_noimp[["term"]], rrf_vars)
       
        udr <- tidy(urf)
        expect_equal(colnames(udr), c("term", "X1", "X2", "MeanDecreaseAccuracy", "MeanDecreaseGini", "sd_1", "sd_2", "sd_MeanDecreaseAccuracy"))
        expect_equal(udr[["term"]], crf_vars)
        
        expect_warning(udr_noimp <- tidy(urf_noimp))
        expect_equal(colnames(udr_noimp), c("term", "MeanDecreaseGini"))
        expect_equal(udr_noimp[["term"]], crf_vars)
    })
    
    # Glance ----
    test_that("glance works on randomForest models", {
        measure_names <- c("precision", "recall", "accuracy", "f_measure")
        glance_names <- c(unlist(lapply(crf_cats, function(x) paste(x, measure_names, sep = "_"))))
        
        glc <- glance(crf)
        expect_equal(colnames(glc), glance_names)
        expect_equal(nrow(glc), 1)
        
        glc_fix <- glance(crf_fix)
        expect_equal(colnames(glc_fix), glance_names)
        expect_equal(nrow(glc_fix), 1)
        
        glc_noimp <- glance(crf_noimp)
        expect_equal(colnames(glc_fix), glance_names)
        expect_equal(nrow(glc_fix), 1)

        glr <- glance(rrf)
        expect_equal(colnames(glr), c("mean_mse", "mean_rsq"))
        expect_equal(nrow(glr), 1)
        
        glr_noimp <- glance(rrf_noimp)
        expect_equal(colnames(glr_noimp), c("mean_mse", "mean_rsq"))
        expect_equal(nrow(glr_noimp), 1)
        
        expect_error(glu <- glance(urf))
        expect_error(glu_noimp <- glance(urf_noimp))
    })
    
    # Augment ----
    test_that("augment works on randomForest models", {
        auc <- augment(crf)
        expect_equal(colnames(auc), c(names(iris), ".oob_times", ".fitted", paste0(".votes_", crf_cats), paste0(".li_", crf_vars)))
        expect_equal(nrow(auc), nrow(iris))
        
        auc_fix <- augment(crf_fix)
        expect_equal(colnames(auc_fix), c(names(iris), ".oob_times", ".fitted", paste0(".votes_", crf_cats), paste0(".li_", crf_vars)))
        expect_equal(nrow(auc_fix), nrow(iris))
        
        expect_warning(auc_noimp <- augment(crf_noimp))
        expect_equal(colnames(auc_noimp), c(names(iris), ".oob_times", ".fitted", paste0(".votes_", crf_cats)))
        expect_equal(nrow(auc_noimp), nrow(iris))
        
        aur <- augment(rrf)
        expect_equal(colnames(aur), c(names(airquality), ".oob_times", ".fitted", paste0(".li_", rrf_vars)))
        expect_equal(nrow(aur), nrow(airquality))
        
        expect_warning(aur_noimp <- augment(rrf_noimp))
        expect_equal(colnames(aur_noimp), c(names(airquality), ".oob_times", ".fitted"))
        expect_equal(nrow(aur_noimp), nrow(airquality))
        
        # Currently, it's impossible to run randomForest unsuprvised with
        # localImp = TRUE - causes a segfault
        auu <- augment(urf)
        expect_equal(colnames(auu), c(names(iris), ".oob_times", ".fitted", paste0(".votes_", 1:2)))
        expect_equal(nrow(auu), nrow(iris))
        
        auu_noimp <- augment(urf_noimp)
        expect_equal(colnames(auu_noimp), c(names(iris), ".oob_times", ".fitted", paste0(".votes_", 1:2)))
        expect_equal(nrow(auu_noimp), nrow(iris))
    })
}
