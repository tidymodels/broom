#' @templateVar class survreg
#' @template title_desc_tidy
#'
#' @param x An `survreg` object returned from [survival::survreg()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#' 
#' if (requireNamespace("survival", quietly = TRUE)) {
#'
#' library(survival)
#'
#' sr <- survreg(
#'   Surv(futime, fustat) ~ ecog.ps + rx,
#'   ovarian,
#'   dist = "exponential"
#' )
#'
#' tidy(sr)
#' augment(sr, ovarian)
#' glance(sr)
#'
#' # coefficient plot
#' td <- tidy(sr, conf.int = TRUE)
#' library(ggplot2)
#' ggplot(td, aes(estimate, term)) +
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
#'   geom_vline(xintercept = 0)
#'   
#' }
#' 
#' @aliases survreg_tidiers
#' @export
#' @seealso [tidy()], [survival::survreg()]
#' @family survreg tidiers
#' @family survival tidiers
#'
tidy.survreg <- function(x, conf.level = .95, conf.int = FALSE, ...) {
  s <- summary(x)$table
  # If the user requested robust SE in the survreg call, don't return naive SE
  # (The column is not present if robust=FALSE)
  s <- s[, colnames(s) != "(Naive SE)", drop = FALSE]
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- as_tidy_tibble(s, new_names = nn)
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }

  ret
}


#' @templateVar class survreg
#' @template title_desc_augment
#'
#' @inherit tidy.survreg params examples
#' @template param_data
#' @template param_newdata
#' @template param_type_residuals
#' @template param_type_predict
#' @template param_unused_dots
#'
#' @evalRd return_augment(".se.fit")
#'
#' @export
#' @seealso [augment()], [survival::survreg()]
#' @family survreg tidiers
#' @family survival tidiers
augment.survreg <- function(x, data = NULL, newdata = NULL,
                            type.predict = "response",
                            type.residuals = "response", ...) {
  if (is.null(data) && is.null(newdata)) {
    stop("Must specify either `data` or `newdata` argument.", call. = FALSE)
  }

  augment_columns(x, data, newdata,
    type.predict = type.predict,
    type.residuals = type.residuals
  )
}


#' @templateVar class survreg
#' @template title_desc_glance
#'
#' @inherit tidy.survreg params examples
#'
#' @evalRd return_glance(
#'   "iter",
#'   "df",
#'   "p.value",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "df.residual",
#'   statistic = "Chi-squared statistic.",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [glance()], [survival::survreg()]
#' @family survreg tidiers
#' @family survival tidiers
glance.survreg <- function(x, ...) {
  as_glance_tibble(
    iter = x$iter, 
    df = sum(x$df),
    statistic = 2 * diff(x$loglik),
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    p.value = 1 - stats::pchisq(2 * diff(x$loglik), sum(x$df) - x$idf),
    na_types = "iirrrriir"
  )
}
