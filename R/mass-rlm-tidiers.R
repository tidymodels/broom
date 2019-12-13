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
#' 
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
  tibble(
    sigma = s$sigma, 
    converged = x$converged,
    logLik = stats::logLik(x),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    nobs = stats::nobs(x)
  )
}

# confint.lm gets called on rlm objects. should use the default instead.
confint.rlm <- confint.default

#' @templateVar class rlm
#' @template title_desc_tidy
#' 
#' @param x An `rlm` object returned by [MASS::rlm()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @details For tidiers for models from the \pkg{robust} package see
#'   [tidy.lmRob()] and [tidy.glmRob()].
#' 
#' @family rlm tidiers
#' @seealso [MASS::rlm()]
#' @export
#' @include stats-lm-tidiers.R
tidy.rlm <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  
  ret <- as_tibble(summary(x)$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic")
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  ret
}

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


