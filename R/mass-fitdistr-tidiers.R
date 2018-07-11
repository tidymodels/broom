#' @templateVar class fitdistr
#' @template title_desc_tidy
#'
#' @param x A `fitdistr` object returned by [MASS::fitdistr()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row for estimated parameter, with
#'   columns:
#'   
#'   \item{term}{The term that was estimated}
#'   \item{estimate}{Estimated value}
#'   \item{std.error}{Standard error of estimate}
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
#'
#' @export
#' @family fitdistr tidiers
#' @aliases fitdistr_tidiers
#' @seealso [tidy()], [MASS::fitdistr()]
tidy.fitdistr <- function(x, ...) {
  tibble(
    term = names(x$estimate),
    estimate = unname(x$estimate),
    std.error = unname(x$sd)
  )
}


#' @templateVar class fitdistr
#' @template title_desc_glance
#' 
#' @inheritParams tidy.fitdistr
#'
#' @return A one-row [tibble::tibble] with columns:
#'   \item{n}{Number of observations used in estimation}
#'   \item{logLik}{log-likelihood of estimated data}
#'   \item{AIC}{Akaike Information Criterion}
#'   \item{BIC}{Bayesian Information Criterion}
#'
#' @export
#' @family fitdistr tidiers
#' @seealso [tidy()], [MASS::fitdistr()]
glance.fitdistr <- function(x, ...) {
  finish_glance(data.frame(n = x$n), x)
}
