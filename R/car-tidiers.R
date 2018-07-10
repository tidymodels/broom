#' @templateVar class durbinWatsonTest
#' @template title_desc_tidy_glance
#'
#' @param x An object of class `durbinWatsonTest` created by a call to
#'   [car::durbinWatsonTest()].
#' @template param_unused_dots
#' 
#' @return A one-row [tibble::tibble] with columns:
#'   \item{statistic}{Test statistic for Durbin-Watson test.}
#'   \item{p.value}{P-value of test statistic.}
#'   \item{autocorrelation}{Residual autocorrelations.}
#'   \item{method}{Always `"Durbin-Watson Test"`.}
#'   \item{alternative}{Alternative hypothesis (character).}
#'
#' @examples
#'
#' dw <- car::durbinWatsonTest(lm(mpg ~ wt, data = mtcars))
#' tidy(dw)
#' glance(dw)  # same output for all durbinWatsonTests
#'
#' @name durbinWatsonTest_tidiers
#' @family car tidiers
#' @export
#' @seealso [tidy()], [glance()], [car::durbinWatsonTest()]
tidy.durbinWatsonTest <- function(x, ...) {
  tibble(
    statistic = x$dw,
    p.value = x$p,
    autocorrelation = x$r,
    method = "Durbin-Watson Test",
    alternative = x$alternative
  )
}

#' @rdname durbinWatsonTest_tidiers
#' @export
glance.durbinWatsonTest <- function(x, ...) tidy(x)
