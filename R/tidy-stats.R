### tidy methods for S3 classes used by the built-in stats package

#' tidy a linear model by returning a data frame version of the coefficients
#' table
#' 
#' @param x An object of class "lm"
#' @param ... extra arguments (not used)
#' 
#' @return a data.frame with five columns:
#' 
#' \itemize{
#' \item{term}{The term in the linear model being estimated and tested}
#' \item{estimate}{The estimated coefficient}
#' \item{stderror}{The standard error from the linear model}
#' \item{statistic}{t-statistic}
#' \item{p.value}{two-sided p-value}
#' }
#' 
#' These are the values contained in the coefficients matrix computed by \link{summary.lm}
#' (though with new column names)
#' 
#' @export
tidy.lm <- function(x, ...) {
    nn <- c("estimate", "stderror", "statistic", "p.value")
    fix_data_frame(coef(summary(x)), nn)
}


#' tidy a nonlinear fit into a data.frame of coefficients
#' 
#' Tidies on a nonlinear fit, such as that returned from the \link{nls} function.
#' 
#' @param x An object of class "nls"
#' @param ... extra arguments (not used)
#' 
#' \itemize{
#' \item{term}{The term in the nonlinear model being estimated and tested}
#' \item{estimate}{The estimated coefficient}
#' \item{stderror}{The standard error from the linear model}
#' \item{statistic}{t-statistic}
#' \item{p.value}{two-sided p-value}
#' }
#' 
#' These are the values contained in the coefficients matrix computed by \link{summary.nls}
#' (though with new column names)
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

        # special case: in a t-test, estimate = estimate1 - estimate2
        if (x$method == "Welch Two Sample t-test") {
            ret <- c(estimate=ret$estimate1 - ret$estimate2, ret)
        }
    }
    ret <- ret[!sapply(ret, is.null)]
    if (!is.null(x$conf.int)) {
        ret <- c(ret, conf.low=x$conf.int[1], conf.high=x$conf.int[2])
    }
    as.data.frame(ret)
}


#' tidy a table object
#' 
#' A table, typically created by the \link{table} function, contains a contingency
#' table of frequencies across multiple vectors.
#' 
#' @param x An object of class "table"
#' @param ... Extra arguments (not used)
#' 
#' @return A data.frame with a column for each variable that has been counted,
#' named \code{Var1}, \code{Var2}, etc, then  
#' 
#' @export
tidy.table <- function(x, ...) {
    as.data.frame(x)
}

#' tidy an ftable object
#' 
#' A table contains a contingency table that 
#' 
#' @param x An object of class "ftable"
#' @param ... Extra arguments (not used)
#' 
#' @return A data.frame with a column for each variable that has been counted,
#' named \code{Var1}, \code{Var2}, etc, then  
#' 
#' @export
tidy.ftable <- function(x, ...) {
    as.data.frame(x)
}



#' tidy a kmeans object
#' 
#' Constructs a data.frame with one row for each center, including
#' the position, the size, and the within-cluster sum of squares.
#' 
#' @param x an object of class "kmeans"
#' @param ... extra arguments (not used)
#' 
#' @export
tidy.kmeans <- function(x, ...) {
    ret <- data.frame(x$centers)
    colnames(ret) <- paste0("x", seq_len(ncol(x$centers)))
    ret$size <- x$size
    ret$withinss <- x$withinss
    ret$cluster <- factor(seq_len(nrow(ret)))
    ret
}


#' tidy a density objet
#' 
#' Given a "density" object, returns a tidy data frame with two
#' columns: points x where the density is estimated, points y
#' for the estimate
#' 
#' @param x an object of class "density"
#' @param ... extra arguments (not used)
#' 
#' @return a data frame with "x" and "y" columns
#' 
#' @export
tidy.density <- function(x, ...) {
    as.data.frame(x[c("x", "y")])
}


#' tidy a spec objet
#' 
#' Given a "spec" object, which shows a spectrum across a range of frequencies,
#' returns a tidy data frame with two columns: "freq" and "spec"
#' 
#' @param x an object of class "spec"
#' @param ... extra arguments (not used)
#' 
#' @return a data frame with "freq" and "spec" columns
#' 
#' @export
tidy.spec <- function(x, ...) {
    as.data.frame(x[c("freq", "spec")])
}


#' tidy a TukeyHSD object
#' 
#' Returns a data.frame with one row for each pairwise comparison
#' 
#' @param x object of class "TukeyHSD"
#' @param ... additional arguments (not used)
#' 
#' @export
tidy.TukeyHSD <- function(x, ...) {
    nn <- c("estimate", "conf.low", "conf.high", "adj.p.value")
    fix_data_frame(x[[1]], nn, "comparison")
}

#' tidy a MANOVA object
#' 
#' Constructs a data frame with one row for each of the terms in the model,
#' containing the information from \link{summary.manova}.
#' 
#' @param x object of class "manova"
#' @param ... additional arguments (not used)
#' 
#' @export
tidy.manova <- function(x, ...) {
    ret <- fix_data_frame(summary(x)$stats, c("df", "pillai", "statistic", "num.df", "den.df", "p.value"))
    # remove residuals row (doesn't have useful information)
    ret <- ret[-nrow(ret), ]
    ret
}

# todo?
# tidy.ts
# tidy.acf
# tidy.infl
# tidy.stepfun
