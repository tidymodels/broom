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
tidy.rlm <- function(x, conf.int = FALSE, conf.level = .95,
                    exponentiate = FALSE, quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- data.frame(term = names(co), estimate = unname(co),
                      stringsAsFactors = FALSE)
    return(process_rlm(ret, x, conf.int = FALSE, exponentiate = exponentiate))
  }
  s <- summary(x)
  ret <- tidy.summary.lm(s)
  
  process_rlm(ret, x,
             conf.int = conf.int, conf.level = conf.level,
             exponentiate = exponentiate
  )
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

#'
process_rlm <- function(ret, x, conf.int = FALSE, conf.level = .95,
                       exponentiate = FALSE) {
  if (exponentiate) {
    # save transformation function for use on confidence interval
    if (is.null(x$family) ||
        (x$family$link != "logit" && x$family$link != "log")) {
      warning(paste(
        "Exponentiating coefficients, but model did not use",
        "a log or logit link function."
      ))
    }
    trans <- exp
  } else {
    trans <- identity
  }
  
  if (conf.int) {
    # avoid "Waiting for profiling to be done..." message
    CI <- suppressMessages(stats::confint.default(x, level = conf.level))
    # Handle case if regression is rank deficient
    p <- x$rank
    if (!is.null(p) && !is.null(x$qr)) {
      piv <- x$qr$pivot[seq_len(p)]
      CI <- CI[piv, , drop = FALSE]
    }
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, trans(unrowname(CI)))
  }
  ret$estimate <- trans(ret$estimate)
  
  as_tibble(ret)
}
