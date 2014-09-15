# fortify functions originated in the ggplot2 package.

#' Augment data according to a tidied model
#'
#' Given an R statistical model or other non-tidy object, add columns to the
#' original dataset such as predictions, residuals and cluster assignments.
#' 
#' @details This function originated in the ggplot2 package, where it was called
#' "fortify."
#'
#' @seealso \code{\link{augment.lm}}
#' @param model model or other R object to convert to data frame
#' @param data original dataset, if needed (when possible this is extracted
#' from the model)
#' @param ... other arguments passed to methods
#' @export
augment <- function(model, data, ...) UseMethod("augment")

#' @export
augment.data.frame <- function(model, data, ...) model

#' @export
augment.NULL <- function(model, data, ...) NULL

#' @export
augment.default <- function(model, data, ...) {   
    stop("augment doesn't know how to deal with data of class ", class(model), call. = FALSE)
}
