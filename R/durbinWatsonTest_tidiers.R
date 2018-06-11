#' Tidying methods for a durbinWatsonTest object
#'
#' Tidies Durbin-Watson Test objects, from the `car` package
#' into a one-row data frame.
#'
#' @param x An object of class `"durbinWatsonTest"`
#' @param ... extra arguments (not used)
#'
#' @return Both `tidy` and `glance` return the same output,
#'   \item{statistic}{Test statistic used to compute the p-value}
#'   \item{p.value}{P-value}
#'   \item{autocorrelation}{Residual autocorrelations}
#'   \item{method}{Method used to compute the statistic as a string}
#'   \item{alternative}{Alternative hypothesis as a string}
#'
#' @examples
#'
#' dw <- car::durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
#' tidy(dw)
#' glance(dw)  # same output for all durbinWatsonTests
#'
#' @name durbinWatsonTest_tidiers
NULL

#' @rdname durbinWatsonTest_tidiers
#' @export
tidy.durbinWatsonTest <- function(x, ...) {
  fix_data_frame(
    data_frame(
      statistic = x$dw,
      p.value = x$p,
      autocorrelation = x$r,
      method = "Durbin-Watson Test",
      alternative = x$alternative
    )
  )
}

#' @rdname durbinWatsonTest_tidiers
#' @export
glance.durbinWatsonTest <- function(x, ...) tidy(x)
