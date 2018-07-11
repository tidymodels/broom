#' @templateVar class loess
#' @template title_desc_tidy
#' 
#' @param x A `loess` objects returned by [stats::loess()].
#' @template param_data
#' @template param_newdata
#' @inheritDotParams stats:::predict.loess
#'
#' @template augment_NAs
#'
#' @return When `newdata` is not supplied `augment.loess`
#' returns one row for each observation with three columns added
#' to the original data:
#' 
#'    \item{.fitted}{Fitted values of model}
#'    \item{.se.fit}{Standard errors of the fitted values}
#'    \item{.resid}{Residuals of the fitted values}
#'
#' When `newdata` is supplied `augment.loess` returns
#'    one row for each observation with one additional column:
#'    
#'    \item{.fitted}{Fitted values of model}
#'    \item{.se.fit}{Standard errors of the fitted values}
#'
#' @examples
#'
#' lo <- loess(mpg ~ wt, mtcars)
#' augment(lo)
#'
#' # with all columns of original data
#' augment(lo, mtcars)
#'
#' # with a new dataset
#' augment(lo, newdata = head(mtcars))
#'
#' @aliases loess_tidiers
#' @export
#' @seealso [augment()], [stats::loess()], [stats::predict.loess()]
augment.loess <- function(x, data = stats::model.frame(x), newdata, ...) {
  augment_columns(x, data, newdata, se.fit = FALSE, se = TRUE, ...)
}
