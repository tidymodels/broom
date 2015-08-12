#' Tidiers for data.frame objects
#' 
#' These perform tidy summaries of data.frame objects. \code{tidy} produces
#' summary statistics about each column, while \code{glance} simply reports
#' the number of rows and columns. Note that \code{augment.data.frame} will
#' throw an error.
#' 
#' @param x A data.frame
#' @param data data, not used
#' @param ... extra arguments: for \code{tidy}, these are passed on to
#' \code{\link{describe}} from \code{psych} package
#' 
#' @details The \code{tidy} method calls the psych method
#' \code{\link{describe}} directly to produce its per-columns summary
#' statistics.
#' 
#' @examples
#' 
#' td <- tidy(mtcars)
#' td
#' 
#' glance(mtcars)
#' 
#' library(ggplot2)
#' # compare mean and standard deviation
#' ggplot(td, aes(mean, sd)) + geom_point() +
#'      geom_text(aes(label = column), hjust = 1, vjust = 1) +
#'      scale_x_log10() + scale_y_log10() + geom_abline()
#' 
#' @name data.frame_tidiers


#' @rdname data.frame_tidiers
#' 
#' @return \code{tidy.data.frame} produces a data frame with one
#' row per original column, containing summary statistics of each:
#'   \item{column}{name of original column}
#'   \item{n}{Number of valid (non-NA) values}
#'   \item{mean}{mean}
#'   \item{sd}{standard deviation}
#'   \item{median}{median}
#'   \item{trimmed}{trimmed mean, with trim defaulting to .1}
#'   \item{mad}{median absolute deviation (from the median)}
#'   \item{min}{minimum value}
#'   \item{max}{maximum value}
#'   \item{range}{range}
#'   \item{skew}{skew}
#'   \item{kurtosis}{kurtosis}
#'   \item{se}{standard error}
#' 
#' @importFrom psych describe
#' 
#' @seealso \code{\link{describe}}
#' 
#' @export
tidy.data.frame <- function(x, ...) {
    ret <- psych::describe(x, ...)
    ret <- fix_data_frame(ret, newcol = "column")
    # remove vars column, which contains an index (not useful here)
    ret$vars <- NULL
    ret
}


#' @rdname data.frame_tidiers
#' 
#' @export
augment.data.frame <- function(x, data, ...) {
    stop(paste("augment's first argument should be a model, not a data.frame"))
}


#' @rdname data.frame_tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with
#'   \item{nrow}{number of rows}
#'   \item{ncol}{number of columns}
#'   \item{complete.obs}{number of rows that have no missing values}
#'   \item{na.fraction}{fraction of values across all rows and columns that
#'   are missing}
#' 
#' @export
glance.data.frame <- function(x, ...) {
    ret <- data.frame(nrow = nrow(x), ncol = ncol(x))
    ret$complete.obs <- sum(stats::complete.cases(x))
    ret$na.fraction <- mean(is.na(x))
    return(ret)
}
