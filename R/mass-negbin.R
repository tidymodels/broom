#' @templateVar class negbin
#' @template title_desc_glance
#'
#' @param x A `negbin` object returned by [MASS::glm.nb()].
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "null.deviance",
#'   "df.null",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @examplesIf rlang::is_installed("MASS")
#'
#' # load libraries for models and data
#' library(MASS)
#'
#' # fit model
#' r <- glm.nb(Days ~ Sex / (Age + Eth * Lrn), data = quine)
#'
#' # summarize model fit with tidiers
#' tidy(r)
#' glance(r)
#'
#' @aliases glm.nb_tidiers
#' @family glm.nb tidiers
#' @seealso [glance()], [MASS::glm.nb()]
#' @export
glance.negbin <- function(x, ...) {
  s <- summary(x)

  ret <- tibble(
    null.deviance = s$null.deviance,
    df.null = s$df.null,
    logLik = stats::logLik(x),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = s$deviance,
    df.residual = s$df.residual,
    nobs = stats::nobs(x)
  )

  ret
}


#' @templateVar class negbin
#' @template title_desc_tidy
#' @template param_exponentiate
#'
#' @inherit glance.negbin examples
#'
#' @param x A `glm.nb` object returned by [MASS::glm.nb()].
#' @template param_confint
#' @param ... For `tidy()`, additional arguments passed to [summary()].
#' Otherwise ignored.
#'
#' @family glm.nb tidiers
#' @seealso [MASS::glm.nb()]
#' @export
tidy.negbin <- function(
  x,
  conf.int = FALSE,
  conf.level = 0.95,
  exponentiate = FALSE,
  ...
) {
  s <- summary(x, ...)

  ret <- tibble(
    term = row.names(s$coefficients),
    estimate = s$coefficients[, 1],
    std.error = s$coefficients[, 2],
    statistic = s$coefficients[, 3],
    p.value = s$coefficients[, 4]
  )

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  if (exponentiate) {
    ret <- exponentiate(ret)
  }

  ret
}
