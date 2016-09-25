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
#' @seealso \code{\link{summary.lm}}
#'   
#' @name rf_tidiers
#'   
#' @param x randomForest object
#'   
#' @examples
NULL

#' @rdname rf_tidiers
#' 
#' @return Returns one row for each coefficient, with five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' @export
tidy.randomForest.formula <- function(x, ...) {
    if (is.null(x[["importance"]]))
        stop("To use tidy() on a randomForest model, build the model with importance = TRUE")
    
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
    imp_m <- fix_data_frame(imp_m)
    imp_sd <- as.data.frame(x[["importanceSD"]])
    names(imp_sd) <- paste("sd", names(imp_sd), sep = "_")
    
    dplyr::bind_cols(imp_m, imp_sd)
}

tidy.randomForest.regression <- function(x, ...) {
    imp_m <- as.data.frame(x[["importance"]])
    names(imp_m) <- c("percent_inc_mse", "inc_node_purity")
    imp_m <- fix_data_frame(imp_m)
    imp_sd <- x[["importanceSD"]]
    
    imp_m$imp_sd <- imp_sd
    imp_m
}

# Small helper function to append "group" before the numeric labels that
# randomForest gives to the unsupervised clusters that it produces.
rename_groups <- function(n) {
    ifelse(grepl("^\\d", n), paste0("group_", n), n)
}

tidy.randomForest.unsupervised <- function(x, ...) {
    imp_m <- as.data.frame(x[["importance"]])
    imp_m <- tibble::rownames_to_column(imp_m, var = "term")
    names(imp_m) <- rename_groups(names(imp_m))
    imp_sd <- as.data.frame(x[["importanceSD"]])
    names(imp_sd) <- paste("sd", names(imp_sd), sep = "_")
    
    dplyr::bind_cols(imp_m, imp_sd)
}

#' @rdname rf_tidiers
#' 
#' @template augment_NAs
#'  
#' @export
augment.randomForest.formula <- function(x, data = NULL, ...) {   
    
    if (is.null(data)) {
        if (is.null(x$call$data)) {
            list <- lapply(all.vars(x$call$formula), as.name)
            data <- eval(as.call(list(quote(data.frame),list)), parent.frame())
        } else{
            data <- eval(x$call$data,parent.frame())
        }
        if (!is.null(x$na.action)) {
            data <- slice(data,-as.vector(x$na.action))
        }
    }
    
    augment.randomForest.method <- switch(x[["type"]],
                                       "classification" = augment.randomForest.classification,
                                       "regression" = augment.randomForest.regression,
                                       "unsupervised" = augment.randomForest.unsupervised)
    augment.randomForest.method(x, data, ...)
}

#' @export
augment.randomForest <- augment.randomForest.formula

augment.randomForest.classification <- function(x, data, ...) {
    oob_times <- x[["oob.times"]]
    votes <- as.data.frame(x[["votes"]])
    names(votes) <- paste("votes", names(votes), sep = "_")
    predicted <- x[["predicted"]]
    local_imp <- x[["localImportance"]]
    
    if (!is.null(local_imp)) {
        local_imp <- as.data.frame(t(local_imp))
        names(local_imp) <- paste("li", names(local_imp), sep = "_")
    }
    
    d <- dplyr::bind_cols(votes, local_imp)
    d$oob_times <- oob_times
    d$predicted <- predicted
    names(d) <- paste0(".", names(d))
    dplyr::bind_cols(data, d)
}

augment.randomForest.regression <- function(x, ...) {
    stop("not yet implemented")
}

augment.randomForest.unsupervised <- function(x, ...) {
    stop("not yet implemented")
}

#' @export
augment.randomForest <- augment.randomForest.formula

#' @rdname rf_tidiers
#'   
#' @param ... extra arguments (not used)
#'   
#' @return \code{glance.randomForest.formula} returns a one-row data.frame, with
#'   the number of trees and \code{mtry} for the model. Classification models
#'   additionally have the mean error rate, while regression models contain the
#'   mean \code{mse} and \code{rsq} value.
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
    err.rate <- mean(x[["err.rate"]])
    data.frame(ntree = ntree, mtry = mtry, err.rate = err.rate)
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
