#' @templateVar class zoo
#' @template title_desc_tidy
#' 
#' @param x A `zoo` object such as those created by [zoo::zoo()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each observation in the `zoo`
#'   time series and columns:
#'   
#'   \item{index}{Index (usually date) for the zoo object}
#'   \item{series}{Name of the series}
#'   \item{value}{Value of the observation}
#'
#' @examples
#'
#' library(zoo)
#' library(ggplot2)
#' 
#' set.seed(1071)
#'
#' # data generated as shown in the zoo vignette
#' Z.index <- as.Date(sample(12450:12500, 10))
#' Z.data <- matrix(rnorm(30), ncol = 3)
#' colnames(Z.data) <- c("Aa", "Bb", "Cc")
#' Z <- zoo(Z.data, Z.index)
#'
#' tidy(Z)
#'
#' ggplot(tidy(Z), aes(index, value, color = series)) +
#'   geom_line()
#'   
#' ggplot(tidy(Z), aes(index, value)) +
#'   geom_line() +
#'   facet_wrap(~ series, ncol = 1)
#'
#' Zrolled <- rollmean(Z, 5)
#' ggplot(tidy(Zrolled), aes(index, value, color = series)) +
#'   geom_line()
#' 
#' @aliases zoo_tidiers
#' @export
#' @seealso [tidy()], [zoo::zoo()]
#' @family time series tidiers
tidy.zoo <- function(x, ...) {
  ret <- data.frame(as.matrix(x), index = zoo::index(x))
  ret <- tidyr::gather(ret, series, value, -index)
  as_tibble(ret)
}
