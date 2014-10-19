#' Ensure an object is a data frame, with rownames moved into a column
#' 
#' @param x a data.frame or matrix
#' @param newnames new column names, not including the rownames
#' @param newcol the name of the new rownames column
#' 
#' @return a data.frame, with rownames moved into a column and new column
#' names assigned
#' 
#' @export
fix_data_frame <- function(x, newnames=NULL, newcol="term") {
    if (all(rownames(x) == seq_len(nrow(x)))) {
        # don't need to move rownames into a new column
        ret <- data.frame(x, stringsAsFactors = FALSE)
        if (!is.null(newnames)) {
            colnames(ret) <- newnames
        }
    }
    else {
        ret <- data.frame(a = rownames(x), x, stringsAsFactors = FALSE)
        colnames(ret)[1] <- newcol
        if (!is.null(newnames)) {
            colnames(ret)[-1] <- newnames
        }
    }
    unrowname(ret)
}


#' strip rownames from an object
#' 
#' @param x a data frame
unrowname <- function(x) {
    rownames(x) <- NULL
    x
}


#' Remove NULL items in a vector or list
#' 
#' @param x a vector or list
compact <- function(x) Filter(Negate(is.null), x)


#' insert a row of NAs into a data frame wherever another data frame has NAs
#' 
#' @param x data frame that has one row for each non-NA row in original
#' @param original data frame with NAs
insert_NAs <- function(x, original) {
    indices <- rep(NA, nrow(x))
    indices[which(complete.cases(original))] = seq_len(nrow(x))
    x[indices, ]
}


#' add predictions, fitted values, residuals, and other common outputs from
#' an augment call
#' 
#' In the case that a generic is not implemented for the model, fail quietly.
#' 
#' @param x a model
#' @param newdata new data to predict on, optional
#' @param type Type of prediction and residuals to compute
#' @param type.predict Type of prediction to compute; by default
#' same as \code{type}
#' @param type.residuals Type of residuals to compute; by default
#' same as \code{type}
#' @param ... extra arguments (not used)
#' 
#' @export
augment_columns <- function(x, newdata, type, type.predict = type,
                            type.residuals = type, ...) {
    if (!missing(type.predict)) {
        pred <- predict(x, newdata, type = type.predict, se.fit = TRUE, ...)
    } else {
        pred <- predict(x, newdata, se.fit = TRUE, ...)        
    }
    if (is.list(pred)) {
        ret <- data.frame(.fitted = pred$fit)
        ret$.se.fit <- pred$se.fit
    } else {
        ret <- data.frame(.fitted = pred)
    }
    
    if (missing(newdata)) {
        if (!missing(type.residuals)) {
            ret$.resid <- tryCatch(residuals(x, type = type.residuals),
                                   error = function(e) NULL)
        } else {
            ret$.resid <- tryCatch(residuals(x), error = function(e) NULL)
        }
    }
    fix_data_frame(ret, newcol = ".rownames")
}



#' Add logLik, AIC, BIC, and other common measurements to a glance of
#' a prediction
#' 
#' A helper function for several functions in the glance generic. Methods
#' such as logLik, AIC, and BIC are defined for many prediction
#' objects, such as lm, glm, and nls. This is a helper function that adds
#' them to a glance data.frame can be performed. If any of them cannot be
#' computed, it fails quietly.
#' 
#' @details In one special case, deviance for objects of the
#' \code{lmerMod} class from lme4 is computed with
#' \code{deviance(x, REML=FALSE)}
#' 
#' @param ret a one-row data frame (a partially complete glance)
#' @param x the prediction model
#' 
#' @return a one-row data frame with additional columns added, such as
#'   \item{logLik}{log likelihoods}
#'   \item{AIC}{Akaike Information Criterion}
#'   \item{BIC}{Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#'   
#' Each of these are produced by the corresponding generics 
#' 
#' @export
finish_glance <- function(ret, x) {
    ret$logLik <- as.numeric(tryCatch(logLik(x), error = function(e) NULL))
    ret$AIC <- tryCatch(AIC(x), error = function(e) NULL)
    ret$BIC <- tryCatch(BIC(x), error = function(e) NULL)
    
    # special case for REML objects (better way?)
    if ("lmerMod" %in% class(x)) {
        ret$deviance <- tryCatch(deviance(x, REML=FALSE),
                                 error = function(e) NULL)
    } else {
        ret$deviance <- tryCatch(deviance(x), error = function(e) NULL)
    }
    ret$df.residual <- tryCatch(df.residual(x), error = function(e) NULL)
    
    return(ret)
}


#' Calculate confidence interval as a tidy data frame
#' 
#' Return a confidence interval as a tidy data frame. This directly wraps the
#' \code{\link{confint}} function, but ensures it folllows broom conventions:
#' column names of \code{conf.low} and \code{conf.high}, and no row names
#' 
#' @param x a model object for which \code{\link{confint}} can be calculated
#' @param conf.level confidence level
#' @param ... extra arguments passed on to \code{confint}
#' 
#' @return A data frame with two columns: \code{conf.low} and \code{conf.high}.
#' 
#' @seealso \link{confint}
#' 
#' @export
confint_tidy <- function(x, conf.level = .95, ...) {
    # avoid "Waiting for profiling to be done..." message for some models
    CI <- suppressMessages(confint(x, level = conf.level, ...))
    if (is.null(dim(CI))) {
        CI = matrix(CI, nrow=1)
    }
    colnames(CI) = c("conf.low", "conf.high")
    unrowname(as.data.frame(CI))
}

