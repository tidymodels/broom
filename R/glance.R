#' Construct a single row summary "glance" of a model, fit, or other
#' object
#'
#' glance methods always return either a one-row data frame, or NULL
#'
#' @param x model or other R object to convert to single-row data frame
#' @param ... other arguments passed to methods
#' @export
glance <- function(x, ...) UseMethod("glance")

#' @export
glance.data.frame <- function(x, ...) {
    if (nrow(x) > 1) {
        stop(paste("Can't construct a glance of a data frame with more than",
             "one row"))
    }
    x
}

#' @export
glance.NULL <- function(x, ...) NULL

#' @export
glance.default <- function(x, ...) {   
    stop("glance doesn't know how to deal with data of class ", class(x), call. = FALSE)
}
