#' Augment data according to a tidied model
#'
#' Given an R statistical model or other non-tidy object, add columns to the
#' original dataset such as predictions, residuals and cluster assignments.
#' 
#' Note that by convention the first argument is almost always \code{data},
#' which specifies the original data object. This is not part of the S3
#' signature, partly because it prevents \link{rowwise_df_tidiers} from
#' taking a column name as the first argument.
#' 
#' @details This generic originated in the ggplot2 package, where it was called
#' "fortify."
#'
#' @seealso \code{\link{augment.lm}}
#' @param x model or other R object to convert to data frame
#' @param ... other arguments passed to methods
#' @export
augment <- function(x, ...) UseMethod("augment")

#' @export
augment.NULL <- function(x, ...) NULL

#' @export
augment.default <- function(x, ...) {   
    stop("augment doesn't know how to deal with data of class ", class(x), call. = FALSE)
}
