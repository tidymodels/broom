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
    indices <- rep(NA, nrow(original))
    indices[which(complete.cases(original))] = seq_len(nrow(x))
    x[indices, ]
}


#' add fitted values, residuals, and other common outputs to
#' an augment call
#' 
#' Add fitted values, residuals, and other common outputs to
#' the value returned from \code{augment}.
#' 
#' In the case that a residuals or influence generic is not implemented for the
#' model, fail quietly.
#' 
#' @param x a model
#' @param data original data onto which columns should be added
#' @param newdata new data to predict on, optional
#' @param type Type of prediction and residuals to compute
#' @param type.predict Type of prediction to compute; by default
#' same as \code{type}
#' @param type.residuals Type of residuals to compute; by default
#' same as \code{type}
#' @param se.fit Value to pass to predict's \code{se.fit}, or NULL for
#' no value
#' @param ... extra arguments (not used)
#' 
#' @export
augment_columns <- function(x, data, newdata, type, type.predict = type,
                            type.residuals = type, se.fit = TRUE, ...) {
    notNAs <- function(o) if (is.null(o) || all(is.na(o))) { NULL } else {o}
    residuals0 <- failwith(NULL, residuals, TRUE)
    influence0 <- failwith(NULL, influence, TRUE)
    cooks.distance0 <- failwith(NULL, cooks.distance, TRUE)
    rstandard0 <- failwith(NULL, rstandard, TRUE)
    predict0 <- failwith(NULL, predict, TRUE)
    
    # call predict with arguments
    args <- list(x)
    if (!missing(newdata)) {
        args$newdata <- newdata
    }
    if (!missing(type.predict)) {
        args$type <- type.predict
    }
    args$se.fit <- se.fit
    args <- c(args, list(...))
    
    # suppress warning: geeglm objects complain about predict being used
    pred <- suppressWarnings(do.call(predict0, args))

    if (is.null(pred)) {
        # try "fitted" instead- some objects don't have "predict" method
        pred <- do.call(fitted, args)
    }

    if (is.list(pred)) {
        ret <- data.frame(.fitted = pred$fit)
        ret$.se.fit <- pred$se.fit
    } else {
        ret <- data.frame(.fitted = as.numeric(pred))
    }
    
    na_action <- if (isS4(x)) {
        attr(model.frame(x), "na.action")
    } else {
        na.action(x)
    }

    if (missing(newdata) || is.null(newdata)) {
        if (!missing(type.residuals)) {
            ret$.resid <- residuals0(x, type = type.residuals)
        } else {
            ret$.resid <- residuals0(x)
        }
        
        infl <- influence0(x, do.coef = FALSE)
        if (!is.null(infl)) {
            ret$.hat <- infl$hat
            ret$.sigma <- infl$sigma
        }
        
        # if cooksd and rstandard can be computed and aren't all NA
        # (as they are in rlm), do so
        ret$.cooksd <- notNAs(cooks.distance0(x))
        ret$.std.resid <- notNAs(rstandard0(x))
        
        original <- data
        
        if (class(na_action) == "exclude") {
            # check if values are missing
            if (length(residuals(x)) > nrow(data)) {
                warning("When fitting with na.exclude, rows with NA in ",
                        "original data will be dropped unless those rows are provided ",
                        "in 'data' argument")
            }
        }
    } else {
        original <- newdata
    }
        
    if (is.null(na_action) || nrow(original) == nrow(ret)) {
        # no NAs were left out; we can simply recombine
        original <- fix_data_frame(original, newcol = ".rownames")
        return(unrowname(cbind(original, ret)))
    } else if (class(na_action) == "omit") {
        # if the option is "omit", drop those rows from the data
        original <- fix_data_frame(original, newcol = ".rownames")
        original <- original[-na_action, ]
        return(unrowname(cbind(original, ret)))
    }
    
    # add .rownames column to merge the results with the original; resilent to NAs
    ret$.rownames <- rownames(ret)
    original$.rownames <- rownames(original)    
    ret <- merge(original, ret, by = ".rownames")
    
    # reorder to line up with original
    ret <- ret[order(match(ret$.rownames, rownames(original))), ]

    rownames(ret) <- NULL
    # if rownames are just the original 1...n, they can be removed
    if (all(ret$.rownames == seq_along(ret$.rownames))) {
        ret$.rownames <- NULL
    }
    ret
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
#' \code{deviance(x, REML=FALSE)}.
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
    
    ret$logLik <- tryCatch(as.numeric(logLik(x)), error = function(e) NULL)
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
    
    return(unrowname(ret))
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


#' Expand a dataset to include all factorial combinations of one or more
#' variables
#'
#' @param .data a tbl
#' @param ... arguments
#' @param stringsAsFactors logical specifying if character vectors are
#' converted to factors.
#'
#' @return A tbl, grouped by the arguments in \code{...}
#'
#' @import dplyr
#'
#' @export
inflate <- function(.data, ..., stringsAsFactors = FALSE) {
    ret <- expand.grid(..., stringsAsFactors = stringsAsFactors)
    ret <- ret %>% group_by_(.dots = colnames(ret)) %>% do(.data)
    if (!is.null(groups(.data))) {
        ret <- ret %>% group_by_(.dots = groups(.data), add = TRUE)
    }
    ret
}


# utility function from tidyr::col_name
col_name <- function (x, default = stop("Please supply column name", call. = FALSE)) 
{
    if (is.character(x)) 
        return(x)
    if (identical(x, quote(expr = ))) 
        return(default)
    if (is.name(x)) 
        return(as.character(x))
    if (is.null(x)) 
        return(x)
    stop("Invalid column specification", call. = FALSE)
}
