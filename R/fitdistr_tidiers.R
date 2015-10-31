#' Tidying methods for fitdistr objects from the MASS package
#' 
#' These methods tidies the parameter estimates resulting
#' from an estimation of a univariate distribution's parameters.
#' 
#' @param x An object of class "fitdistr"
#' @param ... extra arguments (not used)
#'
#' @template boilerplate
#'
#' @name fitdistr_tidiers
#'
#' @examples
#' 
#' set.seed(2015)
#' x <- rnorm(100, 5, 2)
#' 
#' library(MASS)
#' fit <- fitdistr(x, dnorm, list(mean = 3, sd = 1))
#' 
#' tidy(fit)
#' glance(fit)
NULL


#' @rdname fitdistr_tidiers
#' 
#' @return \code{tidy.fitdistr} returns one row for each parameter that
#' was estimated, with columns:
#'   \item{term}{The term that was estimated}
#'   \item{estimate}{Estimated value}
#'   \item{std.error}{Standard error of estimate}
#' 
#' @export
tidy.fitdistr <- function(x, ...) {
    data.frame(term = names(x$estimate),
               estimate = unname(x$estimate),
               std.error = unname(x$sd))
}


#' @rdname fitdistr_tidiers
#' 
#' @return \code{glance.fitdistr} returns a one-row data.frame with the columns
#'   \item{n}{Number of observations used in estimation}
#'   \item{logLik}{log-likelihood of estimated data}
#'   \item{AIC}{Akaike Information Criterion}
#'   \item{BIC}{Bayesian Information Criterion}
#' 
#' @export
glance.fitdistr <- function(x, ...) {
    finish_glance(data.frame(n = x$n), x)
}
