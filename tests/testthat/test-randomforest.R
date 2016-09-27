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
    
    test_that("tidy works on randomForest models", {
        tdc <- tidy(crf)
        tdc_fix <- tidy(crf_fix)
        expect_warning(tdc_noimp <- tidy(crf_noimp), "Only MeanDecreaseGini")
        
        tidy_names <- c("term", paste("class", crf_cats, sep = "_"), "MeanDecreaseAccuracy", "MeanDecreaseGini", paste("sd", c(crf_cats, "MeanDecreaseAccuracy"), sep = "_"))
        
        expect_equal(colnames(tdc), tidy_names)
        expect_equal(tdc[["term"]], crf_vars)
        expect_equal(colnames(tdc_fix), tidy_names)
        expect_equal(tdc_fix[["term"]], crf_vars)
        expect_equal(colnames(tdc_noimp), c("term", "MeanDecreaseGini"))
        expect_equal(tdc_noimp[["term"]], crf_vars)
        
        tdr <- tidy(rrf)
        expect_equal(colnames(tdr), c("term", "percent_inc_mse", "inc_node_purity", "imp_sd"))
        expect_equal(tdr[["term"]], rrf_vars)
       
        udr <- tidy(urf)
    })
    
    test_that("glance works on randomForest models", {
        measure_names <- c("precision", "recall", "accuracy", "f_measure")
        glance_names <- c("ntree", "mtry", unlist(lapply(crf_cats, function(x) paste(x, measure_names, sep = "_"))))
        
        glc <- glance(crf)
        glc_fix <- glance(crf_fix)
        glc_noimp <- glance(crf_noimp)
        expect_equal(colnames(glc), glance_names)
        expect_equal(nrow(glc), 1)
        expect_equal(colnames(glc_fix), glance_names)
        expect_equal(nrow(glc_fix), 1)
        expect_equal(colnames(glc_fix), glance_names)
        expect_equal(nrow(glc_fix), 1)

        glr <- glance(rrf)
        expect_equal(colnames(glr), c("ntree", "mtry", "mean_mse", "mean_rsq"))
        expect_equal(nrow(glr), 1)
        
        glu <- glance(urf)
        expect_equal(colnames(glu), c("ntree", "mtry"))
        expect_equal(nrow(glu), 1)
    })
    
    test_that("augment works on randomForest models", {
        auc <- augment(crf)
        auc_fix <- augment(crf_fix)
        expect_error(auc_noimp <- augment(crf_noimp))
        
        expect_equal(colnames(auc), c(names(iris), ".oob_times", ".fitted", paste0(".votes_", crf_cats), paste0(".li_", crf_vars)))
        expect_equal(nrow(auc), nrow(iris))
        expect_equal(colnames(auc_fix), c(names(iris), ".oob_times", ".fitted", paste0(".votes_", crf_cats), paste0(".li_", crf_vars)))
        expect_equal(nrow(auc_fix), nrow(iris))
        
        aur <- augment(rrf)
        expect_equal(colnames(aur), c(names(airquality), ".oob_times", ".fitted", paste0(".li_", rrf_vars)))
        expect_equal(nrow(aur), nrow(airquality))
        
        expect_error(auu <- augment(urf))
    })
}
