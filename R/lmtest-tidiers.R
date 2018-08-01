#' @templateVar class coeftest
#' @template title_desc_tidy
#' 
#' @param x A `coeftest` object returned from [lmtest::coeftest()].
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'   "term",
#'   "estimate",
#'   "std.error",
#'   "statistic",
#'   "p.value"
#' )
#'
#' @examples
#'
#' library(lmtest)
#' 
#' data(Mandible)
#' fm <- lm(length ~ age, data = Mandible, subset = (age <= 28))
#'
#' lmtest::coeftest(fm)
#' tidy(coeftest(fm))
#'
#' @export
#' @seealso [tidy()], [lmtest::coeftest()]
#' @aliases lmtest_tidiers coeftest_tidiers
tidy.coeftest <- function(x, ...) {
  co <- as.data.frame(unclass(x))
  nn <- c("estimate", "std.error", "statistic", "p.value")[1:ncol(co)]
  ret <- fix_data_frame(co, nn)
  ret
}
