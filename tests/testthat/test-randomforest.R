# test tidy, augment, and glance methods from rf_tidiers.r

context("randomForest tidiers")
suppressPackageStartupMessages(library(randomForest))

if (require(randomForest, quietly = TRUE)) {
    set.seed(100)
    crf <- randomForest(Species ~ ., data = iris, importance = TRUE, localImp = TRUE, proximity = TRUE)
    crf_cats <- levels(iris[["Species"]])
    crf_base_names <- c(crf_cats, "MeanDecreaseAccuracy")
    crf_vars <- names(iris[, -5])
    crf_noimp <- randomForest(Species ~ ., data = iris, importance = TRUE)
    
    rrf <- randomForest(Ozone ~ ., data = airquality, mtry = 3,
                        importance = TRUE, na.action = na.omit)
    rrf_vars <- names(airquality[, -1])
    
    rrf_noimp <- randomForest(Ozone ~ ., data = airquality, mtry = 3,
                        importance = FALSE, na.action = na.omit)
    urf <- randomForest(iris[, -5], importance = TRUE)
    
    test_that("tidy works on randomForest models", {
        tdc <- tidy(crf)
        expect_equal(colnames(tidy(crf)), c("term", crf_base_names, "MeanDecreaseGini", paste("sd", crf_base_names, sep = "_")))
        expect_equal(tdc[["term"]], crf_vars)
        
        tdr <- tidy(rrf)
        expect_equal(colnames(tdr), c("term", "percent_inc_mse", "inc_node_purity", "imp_sd"))
        expect_equal(tdr[["term"]], rrf_vars)
       
        udr <- tidy(urf)
    })
    
    test_that("glance works on randomForest models", {
        glc <- glance(crf)
        expect_equal(colnames(glc), c("ntree", "mtry", "err.rate"))
        expect_equal(nrow(glc), 1)
        
        glr <- glance(rrf)
        expect_equal(colnames(glr), c("ntree", "mtry", "mean_mse", "mean_rsq"))
        expect_equal(nrow(glr), 1)
        
        glu <- glance(urf)
        expect_equal(colnames(glu), c("ntree", "mtry"))
        expect_equal(nrow(glu), 1)
    })
    
    test_that("augment works on randomForest models", {
        auc <- augment(crf)
        expect_equal(colnames(auc), c(names(iris), paste0(".votes_", crf_cats), paste0(".li_", crf_vars), ".oob_times", ".predicted"))
        expect_equal(nrow(auc), nrow(iris))
        
        expect_error(aur <- augment(rrf))
        
        expect_error(auu <- augment(urf))
        
    })
}
