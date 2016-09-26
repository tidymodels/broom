#' Tidying methods for a randomForest model
#' 
#' These methods tidy the variable importance of a random forest model summary, 
#' augment the original data with information on the fitted
#' values/classifications and error, and construct a one-row glance of the
#' model's statistics.
#' 
#' @return All tidying methods return a \code{data.frame} without rownames. The
#'   structure depends on the method chosen.
#'   
#' @name rf_tidiers
#'   
#' @param x randomForest object
#' @param ... Additional arguments (ignored)
NULL

#' @rdname rf_tidiers
#' 
#' @return \code{tidy} returns one row for each model term, with the following columns:
#'   \item{term}{The term in the randomForest model}
#'   \item{class_*}{One column for each model term; the relative importance of each term per class.}
#'   \item{MeanDecreaseAccuracy}{A measure of variable importance. See \code{\link[randomForest]{randomForest}} for more information.}
#'   \item{MeanDecreaseGini}{A measure of variable importance. See \code{\link[randomForest]{randomForest}} for more information.}
#'   \item{sd_*}{Sandard deviations for the preceding statistics.}
#' 
#' @export
tidy.randomForest.formula <- function(x, ...) {
    tidy.randomForest.method <- switch(x[["type"]],
                                       "classification" = tidy.randomForest.classification,
                                       "regression" = tidy.randomForest.regression,
                                       "unsupervised" = tidy.randomForest.unsupervised)
    tidy.randomForest.method(x, ...)
}

#' @export
tidy.randomForest <- tidy.randomForest.formula

#' @rdname rf_tidiers
tidy.randomForest.classification <- function(x, ...) {
    imp_m <- as.data.frame(x[["importance"]])
    if (ncol(imp_m) > 1)
        names(imp_m) <- c(paste("class", head(names(imp_m), -2), sep = "_"), "MeanDecreaseAccuracy", "MeanDecreaseGini")
    imp_m <- fix_data_frame(imp_m)
    
    # When run with importance = FALSE, randomForest() does not calculate
    # importanceSD. Issue a warning.
    if (is.null(x[["importanceSD"]])) {
        warning("Only MeanDecreaseGini is available from this model. Run randomforest(..., importance = TRUE) for more detailed results")
        imp_m
    } else {
        imp_sd <- as.data.frame(x[["importanceSD"]])
        names(imp_sd) <- paste("sd", names(imp_sd), sep = "_")
        
        dplyr::bind_cols(imp_m, imp_sd)    
    }
}

tidy.randomForest.regression <- function(x, ...) {
    imp_m <- as.data.frame(x[["importance"]])
    names(imp_m) <- c("percent_inc_mse", "inc_node_purity")
    imp_m <- fix_data_frame(imp_m)
    imp_sd <- x[["importanceSD"]]
    
    imp_m$imp_sd <- imp_sd
    imp_m
}

tidy.randomForest.unsupervised <- function(x, ...) {
    imp_m <- as.data.frame(x[["importance"]])
    imp_m <- fix_data_frame(imp_m)
    names(imp_m) <- rename_groups(names(imp_m))
    imp_sd <- as.data.frame(x[["importanceSD"]])
    names(imp_sd) <- paste("sd", names(imp_sd), sep = "_")
    
    dplyr::bind_cols(imp_m, imp_sd)
}

#' @rdname rf_tidiers
#' 
#' @return \code{augment} returns the original data with additional columns:
#'   \item{.oob_times}{The number of trees for which the given case was "out of bag". See \code{\link[randomForest]{randomForest} for more details.}}
#'   \item{.predicted}{The model prediction.}
#'   \item{.li_*}{The casewise variable importance for each term. Note: only returned if \code{\link[randomForest]{randomForest}} was run with \code{localImp = TRUE}.}
#'   In addition, \code{augment} returns additional columns for classification trees:
#'   \item{.votes_*}{For each case, the voting results, with one column per class.}
#'   
#' @export
augment.randomForest.formula <- function(x, df = NULL, ...) {   
    
    # Extract data from model
    if (is.null(df)) {
        if (is.null(x$call$data)) {
            list <- lapply(all.vars(x$call$formula), as.name)
            df <- eval(as.call(list(quote(data.frame),list)), parent.frame())
        } else {
            df <- eval(x$call$data,parent.frame())
        }
    }
    
    augment.randomForest.method <- switch(x[["type"]],
                                       "classification" = augment.randomForest.classification,
                                       "regression" = augment.randomForest.regression,
                                       "unsupervised" = augment.randomForest.unsupervised)
    augment.randomForest.method(x, df, ...)
}

#' @export
augment.randomForest <- augment.randomForest.formula

augment.randomForest.classification <- function(x, data, ...) {
    
    # When na.omit is used, case-wise model attributes will only be calculated
    # for complete cases in the original data. All columns returned with
    # augment() must be expanded to the length of the full data, inserting NA
    # for all missing values.
    
    n_data <- nrow(data)
    if (is.null(x[["na.action"]])) {
        na_at <- rep(FALSE, times = n_data)
    } else {
        na_at <- seq_len(n_data) %in% as.integer(x[["na.action"]])
    }
    
    oob_times <- rep(NA_integer_, times = n_data)
    oob_times[!na_at] <- x[["oob.times"]]
    
    predicted <- rep(NA, times = n_data)
    predicted[!na_at] <- x[["predicted"]]
    predicted <- factor(predicted, labels = levels(x[["y"]]))
    
    votes <- x[["votes"]]
    full_votes <- matrix(data = NA, nrow = n_data, ncol = ncol(votes))
    full_votes[which(!na_at),] <- votes
    colnames(full_votes) <- colnames(votes)
    full_votes <- as.data.frame(full_votes)
    names(full_votes) <- paste("votes", names(full_votes), sep = "_")
    
    local_imp <- x[["localImportance"]]
    full_imp <- matrix(data = NA_real_, nrow = nrow(local_imp), ncol = n_data)
    
    if (!is.null(local_imp)) {
        full_imp[, which(!na_at)] <- local_imp
        rownames(full_imp) <- rownames(local_imp)
        full_imp <- as.data.frame(t(full_imp))
        names(full_imp) <- paste("li", names(full_imp), sep = "_")
    } else {
        warning("casewise importance measures are not available. Run randomForest(..., localImp = TRUE) for more detailed results.")
    }
    
    d <- data.frame(oob_times = oob_times, predicted = predicted)
    d <- dplyr::bind_cols(d, full_votes, full_imp)
    names(d) <- paste0(".", names(d))
    dplyr::bind_cols(data, d)
}

augment.randomForest.regression <- function(x, data, ...) {

    n_data <- nrow(data)
    na_at <- seq_len(n_data) %in% as.integer(x[["na.action"]])
    
    oob_times <- rep(NA_integer_, times = n_data)
    oob_times[!na_at] <- x[["oob.times"]]
    
    predicted <- rep(NA_real_, times = n_data)
    predicted[!na_at] <- x[["predicted"]]
    
    local_imp <- x[["localImportance"]]
    full_imp <- matrix(data = NA_real_, nrow = nrow(local_imp), ncol = n_data)
    
    if (!is.null(local_imp)) {
        full_imp[, which(!na_at)] <- local_imp
        rownames(full_imp) <- rownames(local_imp)
        full_imp <- as.data.frame(t(full_imp))
        names(full_imp) <- paste("li", names(full_imp), sep = "_")
    }
    
    d <- data.frame(oob_times = oob_times, predicted = predicted)
    d <- dplyr::bind_cols(d, full_imp)
    names(d) <- paste0(".", names(d))
    dplyr::bind_cols(data, d)
}

augment.randomForest.unsupervised <- function(x, ...) {
    stop("not yet implemented")
}

#' @export
augment.randomForest <- augment.randomForest.formula

#' @rdname rf_tidiers
#'   
#' @return \code{glance.randomForest.formula} returns a one-row data.frame with
#'   the following columns:
#'   \item{ntree}{The number of trees grown.}
#'   \item{mtry}{Number of variables randomly sampled as candidates at each split.}
#'   For regression trees, the following additional columns are present:
#'   \item{mse}{The average mean squared error across all trees.}
#'   \item{rsq}{The average pesudo-R-squared across all trees. See \code{\link[randomForest]{randomForest}} for more information.}
#'   For classification trees, the following columns are present for each class
#'   \item{*_precision}{}
#'   \item{*_recall}{}
#'   \item{*_accuracy}{}
#'   \item{*_f_measure}{}
#'   
#' @export
glance.randomForest.formula <- function(x, ...) {

    glance.method <- switch(x[["type"]],
                            "classification" = glance.randomForest.classification,
                            "regression" = glance.randomForest.regression,
                            "unsupervised" = glance.randomForest.unsupervised)
    
    glance.method(x, ...)
}

#' @export
glance.randomForest <- glance.randomForest.formula

#' @rdname rf_tidiers
glance.randomForest.classification <- function(x, ...) {
    ntree <- x[["ntree"]]
    mtry <- x[["mtry"]]
    
    actual <- x[["y"]]
    predicted <- x[["predicted"]]
    
    per_level <- function(l) {  
        tp <- sum(actual == l & predicted == l)
        tn <- sum(actual != l & predicted != l)
        fp <- sum(actual != l & predicted == l)
        fn <- sum(actual == l & predicted != l)
        
        precision <- tp / (tp + fp)
        recall <- tp / (tp + fn)
        accuracy <- (tp + tn) / (tp + tn + fp + fn)
        f_measure <- 2 * ((precision * recall) / (precision + recall))
        
        ml <- list(precision, recall, accuracy, f_measure)
        names(ml) <- paste(l, c("precision", "recall", "accuracy", "f_measure"), sep = "_")
        as.data.frame(ml)
    }
    
    measure_list <- dplyr::bind_cols(lapply(levels(actual), per_level))
    d <- data.frame(ntree = ntree, mtry = mtry)
    dplyr::bind_cols(d, measure_list)
}

#' @rdname rf_tidiers
glance.randomForest.regression <- function(x, ...) {
    ntree <- x[["ntree"]]
    mtry <- x[["mtry"]]
    mean_mse <- mean(x[["mse"]])
    mean_rsq <- mean(x[["rsq"]])
    data.frame(ntree = ntree, mtry = mtry, mean_mse = mean_mse, mean_rsq = mean_rsq)
}

#' @rdname rf_tidiers
glance.randomForest.unsupervised <- function(x, ...) {
    ntree <- x[["ntree"]]
    mtry <- x[["mtry"]]
    data.frame(ntree = ntree, mtry = mtry)
}

# Small helper function to append "group" before the numeric labels that
# randomForest gives to the unsupervised clusters that it produces.
rename_groups <- function(n) {
    ifelse(grepl("^\\d", n), paste0("group_", n), n)
}
