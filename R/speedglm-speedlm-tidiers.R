#' @templateVar class speedlm
#' @template title_desc_tidy
#'
#' @param x A `speedlm` object returned from [speedglm::speedlm()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' mod <- speedglm::speedlm(mpg ~ wt + qsec, data = mtcars, fitted = TRUE)
#' 
#' tidy(mod)
#' glance(mod)
#' augment(mod)
#'
#' @aliases speedlm_tidiers
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()], [tidy.lm()]
#' @include stats-lm-tidiers.R
tidy.speedlm <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  
  ret <- as_tibble(summary(x)$coefficients, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  
  # summary(x)$coefficients misses rank deficient rows (i.e. coefs that
  # summary.lm() sets to NA), catch them here and add them back
  coefs <- tibble::enframe(stats::coef(x), name = "term", value = "estimate")
  ret <- left_join(coefs, ret)
  
  if (conf.int) {
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  ret
}

#' @templateVar class speedlm
#' @template title_desc_glance
#'
#' @inherit tidy.speedlm params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   statistic = "F-statistic.",
#'   "p.value",
#'   "df",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()]
glance.speedlm <- function(x, ...) {
  s <- summary(x)
  tibble(
    r.squared = s$r.squared,
    adj.r.squared = s$adj.r.squared,
    statistic = s$fstatistic[1],
    p.value = s$f.pvalue,
    df = x$nvar,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = x$RSS,
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
}

#' @templateVar class speedlm
#' @template title_desc_augment
#'
#' @inherit tidy.speedlm params examples
#' @template param_data
#' @template param_newdata
#' @template param_unused_dots
#' 
#' @evalRd return_augment()
#' 
#' @importFrom rlang expr enexpr
#' @export
#' @family speedlm tidiers
#' @seealso [speedglm::speedlm()]
augment.speedlm <- function(x, data = model.frame(x), newdata = NULL, ...) {
  
  # this is a hacky way to prevent the following bug:
  #    speedglm::speedglm(hp ~ log(mpg), mtcars, fitted = TRUE)
  # this also protects against the fact that speedlm doesn't save fitted
  # values by default, in which case predict(x, newdata = NULL) returns NULL
  default_data_arg <- identical(enexpr(data), expr(model.frame(x)))
  
  # both speedlm and speedglm work the same for cts outcomes, except they save
  # the fitted values in different ways.
  no_fitted <- is.null(x$linear.predictors) && is.null(x$fitted.values)
  
  if (default_data_arg && no_fitted)
    stop(
      "Must specify `data` argument or refit speedglm with `fitted = TRUE`.",
      call. = FALSE
    )
  
  # no influence measures for speedlm, can only get fitted values
  # standard errors also not available for fit
  augment_newdata(x, data, newdata, .se_fit = FALSE)
}

