#' Tidiers for summaryDefault objects
#' 
#' Tidy a summary of a vector.
#' 
#' @param x summaryDefault object
#' @param ... extra arguments, not used
#' 
#' @return Both \code{tidy} and \code{glance} return the same object:
#' a one-row data frame with columns
#'   \item{minimum}{smallest value in original vector}
#'   \item{q1}{value at the first quartile}
#'   \item{median}{median of original vector}
#'   \item{mean}{mean of original vector}
#'   \item{q3}{value at the third quartile}
#'   \item{maximum}{largest value in original vector}
#' 
#' @seealso \code{\link{summary}}
#' 
#' @examples
#' 
#' v <- rnorm(1000)
#' s <- summary(v)
#' s
#' 
#' tidy(s)
#' glance(s)
#' 
#' @name summary_tidiers
#' 
#' @export
tidy.summaryDefault <- function(x, ...) {
    ret <- as.data.frame(t(as.matrix(x)))
    colnames(ret) <- c("minimum", "q1", "median", "mean", "q3", "maximum")
    ret
}



#' @rdname summary_tidiers
#' 
#' @export
glance.summaryDefault <- function(x, ...) {
    tidy.summaryDefault(x, ...)
}
