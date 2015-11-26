#' Tidying methods for gamlss objects
#' 
#' Tidying methods for "gamlss" objects from the gamlss package.
#' 
#' @param x A "gamlss" object
#' @param quick Whether to perform a fast version, and return only the coefficients
#' @param ... Extra arguments (not used)
#' 
#' @name gamlss_tidiers
#' 
#' @template boilerplate
#' 
#' @return A data.frame with one row for each coefficient, containing columns
#'   \item{parameter}{Type of coefficient being estimated: \code{mu}, \code{sigma},
#'   \code{nu}, or \code{tau}}
#'   \item{term}{The term in the model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#' 
#' if (requireNamespace("gamlss", quietly = TRUE)) {
#'     data(abdom)
#'     mod<-gamlss(y~pb(x),sigma.fo=~pb(x),family=BCT, data=abdom, method=mixed(1,20))
#'     
#'     tidy(mod)
#' }
#' 
#' @export
tidy.gamlss <- function(x, quick = FALSE, ...){
    if (quick) {
        co <- stats::coef(x)
        return(data.frame(term = names(co), estimate = unname(co)))
    }
    
    # need gamlss for summary to work
    if (!requireNamespace("gamlss", quietly = TRUE)) {
        stop("gamlss package not installed, cannot tidy gamlss")
    }
    
    # use capture.output to prevent summary from being printed to screen
    utils::capture.output(s <- summary(x, type = "qr"))
    
    # tidy the coefficients much as would be done for a linear model
    nn <- c("estimate", "std.error", "statistic", "p.value")
    ret <- fix_data_frame(s, nn)
    
    # add parameter types. This assumes each coefficient table starts
    # with "(Intercept)": unclear if this is guaranteed
    parameters <- x$parameters[cumsum(ret$term == "(Intercept)")]
    cbind(parameter = parameters, ret)
}
