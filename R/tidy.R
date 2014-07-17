#' Tidy the result of a test into a summary data.frame
#' 
#' The output of tidy is always a data.frame with disposable row names. It is
#' therefore suited for further manipulation by packages like dplyr, reshape2,
#' ggplot2 and ggvis.
#' 
#' @param x An object to be converted into a tidy data.frame
#' @param ... extra arguments
#' 
#' @value a data.frame
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
#' @export
tidy.NULL <- function(x, ...) {
    data.frame()
}
