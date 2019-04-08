#' @templateVar class rlm
#' @template title_desc_glance
#'
#' @param x An `rlm` object returned by [MASS::rlm()].
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "sigma", 
#'   "converged", 
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "nobs"
#' )
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
  ret <- tibble(sigma = s$sigma, 
                converged = x$converged,
                logLik = stats::logLik(x),
                AIC = stats::AIC(x),
                BIC = stats::BIC(x),
                deviance = stats::deviance(x),
                nobs = stats::nobs(x))
  ret
  # df.residual is always set to NA in rlm objects
}

# confint.lm gets called on rlm objects. should use the default instead.
confint.rlm <- confint.default

#' @templateVar class rlm
#' @template title_desc_tidy_lm_wrapper
#' 
#' @param x An `rlm` object returned by [MASS::rlm()].
#' @inheritParams tidy.lm
#' 
#' @details For tidiers for models from the \pkg{robust} package see
#'   [tidy.lmRob()] and [tidy.glmRob()].
#' 
#' @family rlm tidiers
#' @seealso [MASS::rlm()]
#' @export
#' @include stats-lm-tidiers.R
tidy.rlm <- tidy.lm

#' @templateVar class rlm
#' @template title_desc_augment
#' 
#' @param x An `rlm` object returned by [MASS::rlm()].
#' @template param_data
#' @template param_newdata
#' @template param_se_fit
#' @template param_unused_dots
#'
#' @evalRd return_augment(".se.fit", ".hat", ".sigma")
#' @inherit glance.rlm examples
#' 
#' @details For tidiers for models from the \pkg{robust} package see
#'   [tidy.lmRob()] and [tidy.glmRob()].
#' 
#' @family rlm tidiers
#' @seealso [MASS::rlm()]
#' @export
augment.rlm <- function(x, data = model.frame(x), newdata = NULL,
                        se_fit = FALSE, ...) {
  
  df <- augment_newdata(x, data, newdata, se_fit)
  
  if (is.null(newdata)) {
    tryCatch({
      infl <- influence(x, do.coef = FALSE)
      df <- add_hat_sigma_cols(df, x, infl)
    }, error = data_error)
  }
  
  df
}


