#' @details When the modeling was performed with \code{na.action = "na.omit"}
#' (as is the typical default), rows with NA in the initial data are omitted
#' entirely from the augmented data frame. When the modeling was performed
#' with \code{na.action = "na.exclude"}, one should provide the original data
#' as a second argument, at which point the augmented data will contain those
#' rows (typically with NAs in place of the new columns). If the original data
#' is not provided to \code{augment} and \code{na.action = "na.exclude"}, a
#' warning is raised and the incomplete rows are dropped.
#' 
#' @seealso \link{na.action}
