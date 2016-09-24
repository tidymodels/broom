# test tidy, augment, and glance methods from rf_tidiers.r

context("randomForest tidiers")
suppressPackageStartupMessages(library(randomForest))

if (require(randomForest, quietly = TRUE)) {
    set.seed(100)
    crf <- randomForest(Species ~ ., data = iris, importance = TRUE,
                        proximity = TRUE)
    rrf <- randomForest(Ozone ~ ., data = airquality, mtry = 3,
                        importance = TRUE, na.action = na.omit)
    urf <- randomForest(iris[, -5])
    
    context("randomForest models")
    test_that("tidy works on randomForest models", {
        tdc <- tidy(crf)
       
        tdr <- tidy(rrf)
       
        tdu <- tidy(urf)
        
    })
    
    test_that("glance works on randomForest models", {
        glc <- glance(crf)
        expect_equal(colnames(glc), c("err.rate", "ntree", "mtry"))
        glr <- glance(rrf)
        expect_equal(colnames(glc), c("mean_mse", "mean_rsq", "ntree", "mtry"))
        glu <- glance(urf)
    })
    
    test_that("augment works on randomForest models", {
        auc <- augment(crf)
        
        aur <- augment(rrf)
        
        auu <- augment(urf)
        
    })
}
