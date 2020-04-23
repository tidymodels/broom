#' @templateVar class loess
#' @template title_desc_tidy
#' 
#' @param x A `loess` objects returned by [stats::loess()].
#' @template param_data
#' @template param_newdata
<<<<<<< HEAD
#' @param ... Arguments passed on the loess predict method.
=======
#' @template param_se_fit
#' @template param_unused_dots
>>>>>>> 3c922d507f7cc758a987a9ef44ae4267ac6ed583
#'
#' @template augment_NAs
#'
#' @evalRd return_augment(".se.fit")
#' 
#' @details  Note that `loess` objects by default will not predict on data
#'   outside of a bounding hypercube defined by the training data unless the
#'   original `loess` object was fit with 
#'   `control = loess.control(surface = \"direct\"))`. See 
#'   [stats::predict.loess()] for details.
#'   
#' @examples
#'
#' lo <- loess(
#'   mpg ~ hp + wt, 
#'   mtcars, 
#'   control = loess.control(surface = "direct")
#' )
#' 
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
<<<<<<< HEAD
#' @seealso [augment()], [stats::loess()]
augment.loess <- function(x, data = stats::model.frame(x), newdata, ...) {
  augment_columns(x, data, newdata, se.fit = FALSE, se = TRUE, ...)
=======
#' @seealso [augment()], [stats::loess()], [stats::predict.loess()]
augment.loess <- function(x, data = model.frame(x), newdata = NULL,
                          se_fit = FALSE, ...) {
  augment_newdata(x, data, newdata, se_fit, se = se_fit)
>>>>>>> 3c922d507f7cc758a987a9ef44ae4267ac6ed583
}

