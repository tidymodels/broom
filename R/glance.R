#' Construct a single row summary "glance" of a model, fit, or other
#' object
#'
#' glance methods always return either a one-row data frame (except on NULL, which
#' returns an empty data frame)
#'
#' @param x model or other R object to convert to single-row data frame
#' @param ... other arguments passed to methods
#' @export
glance <- function(x, ...) UseMethod("glance")

#' @export
glance.NULL <- function(x, ...) data.frame()

#' @export
glance.default <- function(x, ...) {   
    stop("glance doesn't know how to deal with data of class ", class(x), call. = FALSE)
}
