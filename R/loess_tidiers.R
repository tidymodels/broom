#' Augmenting methods for loess models
#' 
#' This method augments the original data with information
#' on the fitted values and residuals, and optionally the 
#' standard errors.
#' 
#' @param x A "loess" object
#' @param data Original data, defaults to the extracting it from the model
#' @param newdata If provided, performs predictions on the new data
#' @param ... extra arguments
#' 
#' @name loess_tidiers
#' 
#' @template augment_NAs
#' 
#' @return When \code{newdata} is not supplied \code{augment.loess}
#' returns one row for each observation with three columns added
#' to the original data:
#'    \item{.fitted}{Fitted values of model}
#'    \item{.se.fit}{Standard errors of the fitted values}
#'    \item{.resid}{Residuals of the fitted values}
#'    
#' When \code{newdata} is supplied \code{augment.loess} returns
#'    one row for each observation with one additional column:
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
#' @export
augment.loess <- function(x, data = model.frame(x), newdata, ...){
    augment_columns(x, data, newdata, se.fit = FALSE, se = TRUE, ...)
}
