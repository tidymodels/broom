#' Tidying methods for a zoo object
#' 
#' Tidies \code{zoo} (Z's ordered observations) time series objects.
#' \code{zoo} objects are not tidy by default because they contain one row
#' for each index and one series per column, rather than one row per
#' observation per series.
#' 
#' @param x An object of class \code{"zoo"}
#' @param ... extra arguments (not used)
#' 
#' @return \code{tidy} returns a data frame with one row for each observation
#' in each series, with the following columns:
#'   \item{index}{Index (usually date) for the zoo object}
#'   \item{series}{Name of the series}
#'   \item{value}{Value of the observation}
#' 
#' @name zoo_tidiers
#' 
#' @examples
#' 
#' if (require("zoo", quietly = TRUE)) {
#'     set.seed(1071)
#' 
#'     # data generated as shown in the zoo vignette
#'     Z.index <- as.Date(sample(12450:12500, 10))
#'     Z.data <- matrix(rnorm(30), ncol = 3)
#'     colnames(Z.data) <- c("Aa", "Bb", "Cc")
#'     Z <- zoo(Z.data, Z.index)
#'     
#'     tidy(Z)
#'     
#'     if (require("ggplot2", quietly = TRUE)) {
#'         ggplot(tidy(Z), aes(index, value, color = series)) + geom_line()
#'         ggplot(tidy(Z), aes(index, value)) + geom_line() +
#'             facet_wrap(~ series, ncol = 1)
#' 
#'         Zrolled <- rollmean(Z, 5)
#'         ggplot(tidy(Zrolled), aes(index, value, color = series)) + geom_line()
#'     }
#' }
#' 
#' @export
tidy.zoo <- function(x, ...) {
    ret <- data.frame(as.matrix(x), index = zoo::index(x))
    ret <- tidyr::gather(ret, series, value, -index)
    ret
}
