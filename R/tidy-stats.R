# tidy methods for classes used by the built-in "stats" package

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

#' Default tidying method
#' 
#' By default, tidy uses `as.data.frame` to convert its output. This is 
#' dangerous, as it may fail with an uninformative error message.
#' Generally tidy is intended to be used on structured model objects
#' such as lm or htest for which a specific S3 object exists.
#' 
#' @export
tidy.default <- function(x, ...) {
    as.data.frame(x)
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


#' tidy a table object
#' 
#' A table contains a contingency table that 
#' 
#' @param x An object of class "table"
#' @param ... Extra arguments (not used)
#' 
#' @value A data.frame with 
tidy.table = function(x, ...) {
    as.data.frame(x)
}

#' tidy an ftable object
#' 
#' A table contains a contingency table that 
#' 
#' @param x An object of class "ftable"
#' @param ... Extra arguments (not used)
#' 
#' @value A data.frame with 
tidy.ftable = function(x, ...) {
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
    ret
}


#' tidy a density objet
#' 
#' Given a "density" object, returns a tidy data frame with two
#' columns: points x where the density is estimated, points y
#' for the estimate
#' 
#' @param an object of class "density"
#' @param ... extra arguments (not used)
#' 
#' @value a data frame with "x" and "y" columns
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
#' @param an object of class "spec"
#' @param ... extra arguments (not used)
#' 
#' @value a data frame with "freq" and "spec" columns
#' 
#' @export
tidy.density <- function(x, ...) {
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

# todo?
# tidy.manova
# tidy.ts
# tidy.ftable
# tidy.acf
# tidy.infl
# tidy.stepfun

