#' Tidy the result of a test into a summary data.frame
#' 
#' The output of tidy is always a data.frame with disposable row names. It is
#' therefore suited for further manipulation by packages like dplyr, reshape2,
#' ggplot2 and ggvis.
#' 
#' @param x An object to be converted into a tidy data.frame
#' @param ... extra arguments
#' 
#' @return a data.frame
#' 
#' @export
tidy <- function(x, ...) UseMethod("tidy")


#' tidy on a NULL input
#' 
#' tidy on a NULL input returns an empty data frame, which means it can be
#' combined with other data frames (treated as "empty")
#' 
#' @param x A value NULL
#' @param ... extra arguments (not used)
#' 
#' @return An empty data.frame
#' 
#' @export
tidy.NULL <- function(x, ...) {
    data.frame()
}


#' Default tidying method
#' 
#' By default, tidy uses \code{as.data.frame} to convert its output. This is 
#' dangerous, as it may fail with an uninformative error message.
#' Generally tidy is intended to be used on structured model objects
#' such as lm or htest for which a specific S3 object exists.
#' 
#' If you know that you want to use \code{as.data.frame} on your untidy
#' object, just use it directly.
#' 
#' @param x an object to be tidied
#' @param ... extra arguments (not used)
#' 
#' @return A data frame, from \code{as.data.frame} applied to the input x. 
#' 
#' @export
tidy.default <- function(x, ...) {
    warning(paste("No method for tidying an S3 object of class",
                  class(x), ", using as.data.frame"))
    as.data.frame(x)
}
