#' @templateVar class ts
#' @template title_desc_tidy
#'
#' @param x A univariate or multivariate `ts` times series object.
#' @template param_unused_dots
#'
#' @evalRd return_tidy("index", "series", "value")
#'
#' @details `series` column is only present for multivariate `ts` objects.
#'
#' @examples
#'
#' set.seed(678)
#'
#' tidy(ts(1:10, frequency = 4, start = c(1959, 2)))
#'
#' z <- ts(matrix(rnorm(300), 100, 3), start = c(1961, 1), frequency = 12)
#' colnames(z) <- c("Aa", "Bb", "Cc")
#'
#' tidy(z)
#' @export
#' @seealso [tidy()], [stats::ts()]
#' @family time series tidiers
#'
tidy.ts <- function(x, ...) {
  # This generates the "index" column using the same approach as time(x), but
  # without converting to a ts object.
  xtsp <- stats::tsp(x)
  index <- seq(xtsp[1], xtsp[2], by = 1 / xtsp[3])
  # Turn multi-column time series into tidy data frames.
  if (is.matrix(x)) {
    res <- as_tibble(as.data.frame(x))
    res <- tibble::add_column(res, index = index, .before = 1)
    res %>%
      pivot_longer(
        cols = c(dplyr::everything(), -index),
        names_to = "series",
        values_to = "value"
      )
  } else {
    tibble(index = index, value = as.vector(x))
  }
}

#' @templateVar class acf
#' @template title_desc_tidy
#'
#' @param x An `acf` object created by [stats::acf()], [stats::pacf()] or
#'   [stats::ccf()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("lag", "acf")
#'
#' @examples
#'
#' tidy(acf(lh, plot = FALSE))
#' tidy(ccf(mdeaths, fdeaths, plot = FALSE))
#' tidy(pacf(lh, plot = FALSE))
#' @export
#' @seealso [tidy()], [stats::acf()], [stats::pacf()], [stats::ccf()]
#' @family time series tidiers
tidy.acf <- function(x, ...) {
  tibble(lag = as.numeric(x$lag), acf = as.numeric(x$acf))
}


#' @templateVar class spec
#' @template title_desc_tidy
#'
#' @param x A `spec` object created by [stats::spectrum()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("freq", "spec")
#'
#' @examplesIf rlang::is_installed("ggplot2")
#'
#' spc <- spectrum(lh)
#' tidy(spc)
#'
#' library(ggplot2)
#' ggplot(tidy(spc), aes(freq, spec)) +
#'   geom_line()
#' @export
#' @seealso [tidy()], [stats::spectrum()]
#' @family time series tidiers
tidy.spec <- function(x, ...) {
  as_tibble(x[c("freq", "spec")])
}
