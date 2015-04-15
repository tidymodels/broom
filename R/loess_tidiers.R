#' Augmenting methods for loess models
#' 
#' This method augments the original data with information
#' on the fitted values and residuals, and optionally the 
#' standard errors.
#' 
#' @return When \code{newdata} is not supplied \code{augment.loess}
#' returns one row for each observation with three columns added
#' to the original data (two if \code{se = FALSE}):
#'    \item{.fitted}{Fitted values of model}
#'    \item{.se.fit}{Standard errors of the fitted values}
#'    \item{.resid}{Residuals of the fitted values}
#'    
#'    When \code{newdata} is supplied \code{augment.loess} returns
#'    one row for each observation with one additional column (two
#'    if \code{se = TRUE}):
#'    \item{.fitted}{Fitted values of model}
#'    \item{.se.fit}{Standard errors of the fitted values}
#' @export
augment.loess <- function(x, data = model.frame(x), se = TRUE,...){
    augment_columns(x, data, se.fit = FALSE, se = se,...)
}
