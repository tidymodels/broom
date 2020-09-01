#' @templateVar class zoo
#' @template title_desc_tidy
#'
#' @param x A `zoo` object such as those created by [zoo::zoo()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("index", "series", "value")
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
#'   facet_wrap(~series, ncol = 1)
#'
#' Zrolled <- rollmean(Z, 5)
#' ggplot(tidy(Zrolled), aes(index, value, color = series)) +
#'   geom_line()
#' @aliases zoo_tidiers
#' @export
#' @seealso [tidy()], [zoo::zoo()]
#' @family time series tidiers
tidy.zoo <- function(x, ...) {
  # check for univariate zoo series
  if (length(dim(x)) > 0) {
    ret <- data.frame(as.matrix(x), index = zoo::index(x))
    ret <- tibble::as_tibble(ret)
    colnames(ret)[1:ncol(x)] <- colnames(x)
    out <- pivot_longer(ret,
                        cols = c(dplyr::everything(), -index),
                        names_to = "series",
                        values_to = "value"
    )
  } else {
    out <- tibble::tibble(index = zoo::index(x),
                          value = zoo::coredata(x))
  }
  return(out)
}
