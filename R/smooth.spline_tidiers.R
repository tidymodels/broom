#' tidying methods for smooth.spline objects
#' 
#' This combines the original data given to smooth.spline with the
#' fit and residuals
#' 
#' @details No \code{tidy} method is provided for smooth.spline objects.
#' 
#' @param x a smooth.spline object
#' @param data defaults to data used to fit model
#' @param ... not used in this method
#' 
#' @examples
#' 
#' spl <- smooth.spline(mtcars$wt, mtcars$mpg, df = 4)
#' head(augment(spl, mtcars))
#' head(augment(spl))  # calls original columns x and y
#' 
#' library(ggplot2)
#' ggplot(augment(spl, mtcars), aes(wt, mpg)) +
#'     geom_point() + geom_line(aes(y = .fitted))
#' 
#' @name smooth.spline_tidiers


#' @rdname smooth.spline_tidiers
#' 
#' @return \code{augment} returns the original data with extra columns:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#' 
#' @export
augment.smooth.spline <- function(x, data = x$data, ...) {
    # move rownames if necessary
    data <- unrowname(as.data.frame(data))
    
    data <- as.data.frame(data)
    data$.fitted <- fitted(x)
    data$.resid <- resid(x)
    data
}


#' @rdname smooth.spline_tidiers
#' 
#' @return \code{glance} returns one row with columns
#'   \item{spar}{smoothing parameter}
#'   \item{lambda}{choice of lambda corresponding to \code{spar}}
#'   \item{df}{equivalent degrees of freedom}
#'   \item{crit}{minimized criterion}
#'   \item{pen.crit}{penalized criterion}
#'   \item{cv.crit}{cross-validation score}
#' 
#' @export
glance.smooth.spline <- function(x, ...) {
    unrowname(as.data.frame(
        x[c("df", "lambda", "cv.crit", "pen.crit", "crit", "spar", "lambda")]
        ))
}
