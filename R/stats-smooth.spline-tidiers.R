#' @templateVar class smooth.spline
#' @template title_desc_tidy
#'
#' @param x A `smooth.spline` object returned from [stats::smooth.spline()].
#' @template param_data
#' @template param_unused_dots
#' 
#' @examples
#'
#' spl <- smooth.spline(mtcars$wt, mtcars$mpg, df = 4)
#' augment(spl, mtcars)
#' augment(spl)  # calls original columns x and y
#'
#' library(ggplot2)
#' ggplot(augment(spl, mtcars), aes(wt, mpg)) +
#'     geom_point() + geom_line(aes(y = .fitted))
#'
#' @template return_augment_columns
#' 
#' @aliases smooth.spline_tidiers
#' @export
#' @family smoothing spline tidiers
#' @seealso [augment()], [stats::smooth.spline()], 
#'   [stats::predict.smooth.spline()]
augment.smooth.spline <- function(x, data = x$data, ...) {
  data <- as_tibble(data)
  data$.fitted <- stats::fitted(x)
  data$.resid <- stats::resid(x)
  data
}


#' @templateVar class smooth.spine
#' @template title_desc_tidy
#' 
#' @inheritParams augment.smooth.spline
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{spar}{smoothing parameter}
#'   \item{lambda}{choice of lambda corresponding to `spar`}
#'   \item{df}{equivalent degrees of freedom}
#'   \item{crit}{minimized criterion}
#'   \item{pen.crit}{penalized criterion}
#'   \item{cv.crit}{cross-validation score}
#'
#' @export
#' @family smoothing spline tidiers
#' @seealso [augment()], [stats::smooth.spline()]
#' 
glance.smooth.spline <- function(x, ...) {
  as_tibble(
    x[c("df", "lambda", "cv.crit", "pen.crit", "crit", "spar")]
  )
}
