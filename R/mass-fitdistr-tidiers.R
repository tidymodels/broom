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
#' @inherit tidy.fitdistr params examples
#'
#' @evalRd return_glance("n", "logLik", "AIC", "BIC")
#'
#' @export
#' @family fitdistr tidiers
#' @seealso [tidy()], [MASS::fitdistr()]
glance.fitdistr <- function(x, ...) {
  finish_glance(data.frame(n = x$n), x)
}
