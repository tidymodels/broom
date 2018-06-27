#' Tidying methods for an rlm (robust linear model) object
#'
#' This method provides a glance of an "rlm" object. The `tidy` and
#' `augment` methods are handled by [lm_tidiers].
#'
#' @param x rlm object
#' @param ... extra arguments (not used)
#'
#' @return `glance.rlm` returns a one-row data.frame with the columns
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{converged}{whether the IWLS converged}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'
#' @name rlm_tidiers
#'
#' @examples
#'
#' library(MASS)
#'
#' r <- rlm(stack.loss ~ ., stackloss)
#' tidy(r)
#' augment(r)
#' glance(r)
#'
#' @seealso [lm_tidiers]
#'
#' @export
glance.rlm <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(sigma = s$sigma, converged = x$converged)
  ret <- finish_glance(ret, x)
  # remove df.residual, which is always set to NA in rlm objects
  dplyr::select(ret, -df.residual)
}

# TODO: document that linking should be explicit to make it easier to find
# documentation

#' @rdname rlm_tidiers
#' @export
tidy.rlm <- function(x, ...) {
  tidy.lm(x, ...)
}


#' @rdname rlm_tidiers
#' @export
augment.rlm <- function(x, ...) {
  augment.lm(x, ...)
}
