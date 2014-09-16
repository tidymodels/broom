### tidy methods for S3 classes used by the built-in stats package
### This file is only for miscellaneous methods that have *only* a tidy
### method (not augment or glance). In general, tidiers belong in in
### a file of "class-tidiers.R"


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
