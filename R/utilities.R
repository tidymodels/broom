#' Ensure an object is a data frame, with rownames moved into a column
#' 
#' @param x a data.frame or matrix
#' @param newnames new column names, not including the rownames
#' @param newcol the name of the new rownames column
#' 
#' @return a data.frame, with rownames moved into a column
#' 
#' @export
fix_data_frame <- function(x, newnames=NULL, newcol="term") {
    if (all(rownames(x) == seq_len(nrow(x)))) {
        # don't need to move rownames into a new column
        ret <- data.frame(x, stringsAsFactors = FALSE)
    }
    else {
        ret <- data.frame(a=rownames(x), x, stringsAsFactors = FALSE)
        colnames(ret)[1] <- newcol
    }
    if (!is.null(newnames)) {
        colnames(ret)[-1] <- newnames
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
