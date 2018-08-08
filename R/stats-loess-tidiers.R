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
#' @evalRd return_augment(".se.fit")
#' 
#' @details The `.se.fit` column is only present when data is specified via
#'   the `data` argument.
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
augment.loess <- function(x, data = stats::model.frame(x), newdata = NULL, ...) {
  augment_columns(x, data, newdata, se.fit = FALSE, se = TRUE, ...)
}

