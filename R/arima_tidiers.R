#' Tidying methods for ARIMA modeling of time series
#'
#' These methods tidy the coefficients of ARIMA models of univariate time
#' series.
#' 
#' @param x An object of class "Arima"
#' 
#' @details \code{augment} is not currently implemented, as it is not clear
#' whether ARIMA predictions can or should be merged with the original
#' data frame.
#' 
#' @template boilerplate
#' 
#' @seealso \link{arima}
#' 
#' @examples
#' 
#' fit <- arima(lh, order = c(1, 0, 0))
#' tidy(fit)
#' glance(fit)
#' 
#' @name Arima_tidiers
NULL


#' @rdname Arima_tidiers
#' 
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' \code{conf.int=TRUE}
#'
#' @return \code{tidy} returns one row for each coefficient in the model,
#' with five columns:
#'   \item{term}{The term in the nonlinear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#' 
#' If \code{conf.int = TRUE}, also returns
#'   \item{conf.low}{low end of confidence interval}
#'   \item{conf.high}{high end of confidence interval}
#' 
#' @export
tidy.Arima <- function(x, conf.int=FALSE, conf.level=.95, ...) {
    coefs <- coef(x)
    # standard errors are computed as in stats:::print.Arima
    ses <- rep.int(0, length(coefs))
    ses[x$mask] <- sqrt(diag(x$var.coef))
    
    ret <- unrowname(data.frame(term = names(coefs),
                                estimate = coefs,
                                std.error = ses))

    if (conf.int) {
        ret <- cbind(ret, confint_tidy(x))
    }
    ret
}


#' @rdname Arima_tidiers
#' 
#' @param ... extra arguments (not used)
#' 
#' @return \code{glance} returns one row with the columns
#'   \item{sigma}{the square root of the estimated residual variance}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#' 
#' @export
glance.Arima <- function(x, ...) {
    ret <- unrowname(data.frame(sigma = sqrt(x$sigma2)))
    finish_glance(ret, x)
}
