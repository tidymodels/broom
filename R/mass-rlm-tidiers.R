#' @templateVar class rlm
#' @template title_desc_glance
#'
#' @param x An `rlm` object returned by [MASS::rlm()].
#' @template param_unused_dots
#'
#' @return A one-row [tibble::tibble] with columns:
#'
#'   \item{sigma}{The square root of the estimated residual variance}
#'   \item{converged}{whether the IWLS converged}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'
#' @details For tidiers for models from the \pkg{robust} package see
#'   [tidy.lmRob()] and [tidy.glmRob()].
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
#' @export
#' @aliases rlm_tidiers
#' @family rlm tidiers
#' @seealso [glance()], [MASS::rlm()]
glance.rlm <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(sigma = s$sigma, converged = x$converged)
  ret <- finish_glance(ret, x)
  # remove df.residual, which is always set to NA in rlm objects
  dplyr::select(ret, -df.residual)
}

#' @templateVar class rlm
#' @template title_desc_tidy_lm_wrapper
#' 
#' @param x An `rlm` object returned by [MASS::rlm()].
#' 
#' @details For tidiers for models from the \pkg{robust} package see
#'   [tidy.lmRob()] and [tidy.glmRob()].
#' 
#' @family rlm tidiers
#' @seealso [MASS::rlm()]
#' @export
tidy.rlm <- function(x, ...) {
  tidy.lm(x, ...)
}

#' @templateVar class rlm
#' @template title_desc_augment_lm_wrapper
#' 
#' @param x An `rlm` object returned by [MASS::rlm()].
#' 
#' @details For tidiers for models from the \pkg{robust} package see
#'   [tidy.lmRob()] and [tidy.glmRob()].
#' 
#' @family rlm tidiers
#' @seealso [MASS::rlm()]
#' @export
augment.rlm <- function(x, ...) {
  augment.lm(x, ...)
}
