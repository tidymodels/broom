#' @templateVar class fitdistr
#' @template title_desc_tidy
#'
#' @param x A `fitdistr` object returned by [MASS::fitdistr()].
#' @template param_unused_dots
#'
#' @evalRd return_tidy("term", "estimate", "std.error")
#'
#' @examples
#' 
#' # feel free to ignore the following line—it allows {broom} to supply 
#' # examples without requiring the model-supplying package to be installed.
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'
#' # load libraries for models and data
#' library(MASS)
#'
#' # generate data
#' set.seed(2015)
#' x <- rnorm(100, 5, 2)
#'
#' #  fit models
#' fit <- fitdistr(x, dnorm, list(mean = 3, sd = 1))
#'
#' # summarize model fit with tidiers
#' tidy(fit)
#' glance(fit)
#' 
#' }
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
#' @inherit tidy.fitdistr params examples
#'
#' @evalRd return_glance("logLik", "AIC", "BIC", "nobs")
#'
#' @export
#' @family fitdistr tidiers
#' @seealso [tidy()], [MASS::fitdistr()]
glance.fitdistr <- function(x, ...) {
  as_glance_tibble(
    logLik = stats::logLik(x),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    nobs = stats::nobs(x),
    na_types = "rrri"
  )
  
}
