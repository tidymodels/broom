#' Ensure an object is a data frame, with rownames moved into a column
#' 
#' @param x a data.frame or matrix
#' @param newnames new column names, not including the rownames
#' @param newcol the name of the new rownames column
#' 
#' @return a data.frame, with rownames moved into a column
#' 
#' @export
fix_data_frame = function(x, newnames=NULL, newcol="term") {
    ret <- data.frame(a=rownames(x), x, stringsAsFactors = FALSE)
    colnames(ret)[1] <- newcol
    if (!is.null(newnames)) {
        colnames(ret)[-1] <- newnames
    }
    rownames(ret) <- NULL
    ret
}

#' Tidy the result of a test into a summary data.frame
#' 
#' The output of tidy is always a data.frame with disposable row names. It is
#' therefore suited for further manipulation by packages like dplyr, reshape2,
#' ggplot2 and ggvis
#' 
#' @param x An object to be converted into a tidy data.frame
#' @param ... extra arguments
#' 
#' @export
tidy <- function(x, ...) {
    UseMethod("tidy")
}


#' tidy on a NULL input returns an empty data frame
#' 
#' @param x A value NULL
#' @param ... extra arguments (not used)
#' 
#' @export
tidy.NULL <- function(x, ...) {
    data.frame()
}


#' tidy a linear model by returning a data frame version of the coefficients
#' table
#' 
#' @param x An object of class "lm"
#' @param ... extra arguments (not used)
#' 
#' @return a data.frame with four columns:
#' 
#' @export
tidy.lm <- function(x, ...) {
    nn <- c("estimate", "stderror", "statistic", "p.value")
    fix_data_frame(coef(summary(x)), nn)
}


#' tidy a nonlinear fit into a data.frame of coefficients
#' 
#' @param x An object of class "nls"
#' @param ... extra arguments (not used)
#' 
#' @export
tidy.nls <- function(x, ...) {
    nn <- c("estimate", "stderror", "statistic", "p.value")
    fix_data_frame(coef(summary(x)), nn)
}

#' tidy an anova object into a data.frame of tests
#' 
#' @param x An object of class "anova"
#' @param ... extra arguments (not used)
#' 
#' @export
tidy.anova <- function(x, ...) {
    nn <- c("df", "sumsq", "meansq", "statistic", "p.value")
    fix_data_frame(x, nn)
}


#' tidy an anova object into a data.frame of tests
#' 
#' @param x An object of class "anova"
#' @param ... extra arguments (not used)
#' 
#' @export
tidy.aov <- function(x, ...) {
    nn <- c("df", "sumsq", "meansq", "statistic", "p.value")
    fix_data_frame(summary(x)[[1]], nn)
}


#' tidy an htest object into a data.frame
#' 
#' @param x An object of class "htest"
#' @param ... extra arguments (not used)
#' 
#' @export
tidy.htest <- function(x, ...) {
    ret <- x[c("estimate", "statistic", "p.value", "parameter")]
    # estimate may have multiple values
    if (length(ret$estimate) > 1) {
        names(ret$estimate) <- paste0("estimate", seq_along(ret$estimate))
        ret <- c(ret$estimate, ret)
        ret$estimate <- NULL
    }
    ret <- ret[!sapply(ret, is.null)]
    if (!is.null(x$conf.int)) {
        ret <- c(ret, conf.low=x$conf.int[1], conf.high=x$conf.int[2])
    }
    as.data.frame(ret)
}
