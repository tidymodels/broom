#' @templateVar class betareg
#' @template title_desc_tidy
#'
#' @param x A `betareg` object produced by a call to [betareg::betareg()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE,
#'   component = "Whether a particular term was used to model the mean or the
#'     precision in the regression. See details."
#' )
#'
#' @details The tibble has one row for each term in the regression. The
#'   `component` column indicates whether a particular
#'   term was used to model either the `"mean"` or `"precision"`. Here the
#'   precision is the inverse of the variance, often referred to as `phi`.
#'   At least one term will have been used to model the precision `phi`.
#'
#' @examplesIf rlang::is_installed("betareg")
#'
#' # load libraries for models and data
#' library(betareg)
#'
#' # load dats
#' data("GasolineYield", package = "betareg")
#'
#' # fit model
#' mod <- betareg(yield ~ batch + temp, data = GasolineYield)
#'
#' mod
#'
#' # summarize model fit with tidiers
#' tidy(mod)
#' tidy(mod, conf.int = TRUE)
#' tidy(mod, conf.int = TRUE, conf.level = .99)
#'
#' augment(mod)
#'
#' glance(mod)
#'
#' @export
#' @seealso [tidy()], [betareg::betareg()]
#' @family betareg tidiers
#' @aliases betareg_tidiers
tidy.betareg <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  check_ellipses("exponentiate", "tidy", "betareg", ...)

  ret <- map_as_tidy_tibble(
    purrr::map(coef(summary(x)), as.matrix),
    new_names = c("estimate", "std.error", "statistic", "p.value")
  )

  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::bind_cols(ret, ci[c("conf.low", "conf.high")])
  }

  as_tibble(ret)
}


#' @templateVar class betareg
#' @template title_desc_augment
#'
#' @inherit tidy.betareg params examples
#' @template param_data
#' @template param_newdata
#' @template param_type_predict
#' @template param_type_residuals
#'
#' @evalRd return_augment(".cooksd")
#'
#' @details For additional details on Cook's distance, see
#'   [stats::cooks.distance()].
#'
#' @seealso [augment()], [betareg::betareg()]
#' @export
augment.betareg <- function(x, data = model.frame(x), newdata = NULL,
                            type.predict, type.residuals, ...) {
  augment_columns(
    x, data, newdata,
    type.predict = type.predict,
    type.residuals = type.residuals
  )
}


#' @templateVar class betareg
#' @template title_desc_glance
#'
#' @inherit tidy.betareg params examples
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "pseudo.r.squared",
#'   "df.null",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @seealso [glance()], [betareg::betareg()]
#' @export
glance.betareg <- function(x, ...) {
  s <- summary(x)
  as_glance_tibble(
    pseudo.r.squared = s$pseudo.r.squared,
    df.null = s$df.null,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    na_types = "rirrrii"
  )
}
