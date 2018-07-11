#' @templateVar class coeftest
#' @template title_desc_tidy
#' 
#' @param x A `coeftest` object returned from [lmtest::coeftest()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one row for each coefficient and columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error}
#'   \item{statistic}{test statistic}
#'   \item{p.value}{p-value}
#'
#' @examples
#'
#' if (require("lmtest", quietly = TRUE)) {
#'     data(Mandible)
#'     fm <- lm(length ~ age, data=Mandible, subset=(age <= 28))
#'
#'     lmtest::coeftest(fm)
#'     tidy(coeftest(fm))
#' }
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
