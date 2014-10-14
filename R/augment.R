#' Augment data according to a tidied model
#'
#' Given an R statistical model or other non-tidy object, add columns to the
#' original dataset such as predictions, residuals and cluster assignments.
#' 
#' @details This generic originated in the ggplot2 package, where it was called
#' "fortify."
#'
#' @seealso \code{\link{augment.lm}}
#' @param x model or other R object to convert to data frame
#' @param data original dataset, if needed (when possible this is extracted
#' from the model)
#' @param ... other arguments passed to methods
#' @export
augment <- function(x, data, ...) UseMethod("augment")

#' @export
augment.data.frame <- function(x, data, ...) {
    stop(paste("augment's first argument should be a model, not a data.frame"))
}

#' @export
augment.NULL <- function(x, data, ...) NULL

#' @export
augment.default <- function(x, data, ...) {   
    stop("augment doesn't know how to deal with data of class ", class(x), call. = FALSE)
}
