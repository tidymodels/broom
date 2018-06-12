#' Tidying methods for a list of nonlinear models
#'
#' These methods tidy the coefficients of a list of nonlinear models into a summary.
#' At the moment only the \code{tidy} method is available for this class of models.
#' This method applies to models fit with the \code{\link{nlsList}} function from the nlme package.
#' 
#' @param x An object of class "nlsList"
#' @param data original data this was fitted on; if not given this will
#' attempt to be reconstructed from nlsList (may not be successful)
#' 
#' @return All tidying methods return a \code{data.frame} without rownames.
#' The structure depends on the method chosen.
#' 
#' @seealso \code{\link{nlsList}}, \code{\link{summary.nlsList}}.
#' 
#' @examples
#' 
#' chick <- as.data.frame(ChickWeight)
#'
#' library(nlme)
#' nlsl1 <- nlsList(weight ~ a*Time^b | Diet, start=list(a=10, b=1), data=chick)
#' 
#' tidy(nlsl1)
#' 
#' @name nlslist_tidiers
NULL


#' @rdname nlslist_tidiers
#' 
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#' @param quick whether to compute a smaller and faster version, containing
#' only the \code{term} and \code{estimate} columns.
#'
#' @return \code{tidy} returns one row for each coefficient in the model,
#' with five columns:
#'   \item{term}{The term in the nonlinear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' @export
tidy.nlsList <- function(x, conf.int = FALSE, conf.level = .95,
                     quick = FALSE, ...) {

    l <- lapply(names(x), function(n, ...){
        cbind(group=n, tidy(x[[n]], 
                            conf.int = conf.int, 
                            conf.level = conf.level, 
                            quick = quick, ...), stringsAsFactors=FALSE)
    })
    bind_rows(l)
    
}



