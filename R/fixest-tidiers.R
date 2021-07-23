#' @templateVar class fixest
#' @template title_desc_tidy
#'
#' @param x A `fixest` object returned from any of the `fixest` estimators
#' @template param_confint
#' @param ... Additional arguments passed to `summary` and `confint`. Important
#'   arguments are `se` and `cluster`. Other arguments are `dof`, `exact_dof`,
#'   `forceCovariance`, and `keepBounded`.
#'   See [`summary.fixest`][fixest::summary.fixest()].
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details The `fixest` package provides a family of functions for estimating
#'   models with arbitrary numbers of fixed-effects, in both an OLS and a GLM
#'   context. The package also supports robust (i.e. White) and clustered
#'   standard error reporting via the generic `summary.fixest()` command. In a
#'   similar vein, the `tidy()` method for these models allows users to specify
#'   a desired standard error correction either 1) implicitly via the supplied
#'   fixest object, or 2) explicitly as part of the tidy call. See examples
#'   below.
#'
#'   Note that fixest confidence intervals are calculated assuming a normal
#'   distribution -- this assumes infinite degrees of freedom for the CI.
#'   (This assumption is distinct from the degrees of freedom used to calculate
#'   the standard errors. For more on degrees of freedom with clusters and
#'   fixed effects, see \url{https://github.com/lrberge/fixest/issues/6} and
#'   \url{https://github.com/sgaure/lfe/issues/1#issuecomment-530646990})
#'
#' @examples
#' \donttest{
#' library(fixest)
#' 
#' gravity <- feols(log(Euros) ~ log(dist_km) | Origin + Destination + Product + Year, trade)
#'
#' tidy(gravity)
#' glance(gravity)
#' augment(gravity, trade)
#'
#' ## To get robust or clustered SEs, users can either:
#' # 1) Or, specify the arguments directly in the tidy() call
#' 
#' tidy(gravity, conf.int = TRUE, cluster = c("Product", "Year"))
#' 
#' tidy(gravity, conf.int = TRUE, se = "threeway")
#' 
#' # 2) Feed tidy() a summary.fixest object that has already accepted these arguments
#' 
#' gravity_summ <- summary(gravity, cluster = c("Product", "Year"))
#' tidy(gravity_summ, conf.int = TRUE)
#' 
#' # Approach (1) is preferred.
#' 
#' }
#'
#' @export
#' @family fixest tidiers
#' @seealso [tidy()], [fixest::feglm()], [fixest::fenegbin()],
#' [fixest::feNmlm()], [fixest::femlm()], [fixest::feols()], [fixest::fepois()]
tidy.fixest <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  coeftable <- summary(x, ...)$coeftable
  ret <- as_tibble(coeftable, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  if (conf.int) {
    CI <- stats::confint(x, level = conf.level, ...)
    # Bind to rest of tibble
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- bind_cols(ret, unrowname(CI))
  }
  as_tibble(ret)
}


#' @templateVar class fixest
#' @template title_desc_augment
#'
#' @inherit tidy.fixest params examples
#' @template param_data
#' @template param_newdata
#' @param type.predict Passed to [`predict.fixest`][fixest::predict.fixest()]
#'   `type` argument. Defaults to `"link"` (like `predict.glm`).
#' @param type.residuals Passed to [`predict.fixest`][fixest::residuals.fixest()]
#'   `type` argument. Defaults to `"response"` (like `residuals.lm`, but unlike
#'   `residuals.glm`).
#' @evalRd return_augment()
#'
#' @note Important note: `fixest` models do not include a copy of the input
#' data, so you must provide it manually.
#'
#' augment.fixest only works for [fixest::feols()], [fixest::feglm()], and
#' [fixest::femlm()] models. It does not work with results from
#' [fixest::fenegbin()], [fixest::feNmlm()], or [fixest::fepois()].
#' @export
#' @family fixest tidiers
#' @seealso [augment()], [fixest::feglm()], [fixest::femlm()], [fixest::feols()]
augment.fixest <- function(x, data = NULL, newdata = NULL,
    type.predict = c("link", "response"),
    type.residuals = c("response", "deviance", "pearson", "working"),
    ...) {
  if (!x$method %in% c("feols", "feglm", "femlm")) {
    stop("augment is only supported for fixest models estimated with ",
      "feols, feglm, or femlm\n",
      "  (supplied model used ", x$method, ")"
    )
  }
  type.predict <- match.arg(type.predict)
  type.residuals <- match.arg(type.residuals)

  if (is.null(newdata)) {
    df <- data
  } else {
    df <- newdata
  }
  if (is.null(df)) {
    stop("Must specify either `data` or `newdata` argument.", call. = FALSE)
  }
  df <- as_augment_tibble(df)
  if (is.null(newdata)) {
    # use existing data
    df$.fitted <- predict(x, type = type.predict)
    df$.resid <- residuals(x, type = type.residuals)
  } else {
    # With new data, only provide predictions
    df$.fitted <- predict(x, type = type.predict, newdata = newdata)
  }
  df
}

#' @templateVar class fixest
#' @template title_desc_glance
#'
#' @inherit tidy.fixest params examples
#'
#' @note All columns listed below will be returned, but some will be `NA`,
#' depending on the type of model estimated. `sigma`, `r.squared`,
#' `adj.r.squared`, and `within.r.squared` will be NA for any model other than
#' `feols`. `pseudo.r.squared` will be NA for `feols`.
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "within.r.squared",
#'   "pseudo.r.squared",
#'   "sigma",
#'   "nobs",
#'   "AIC",
#'   "BIC",
#'   "logLik"
#' )
#' @export
glance.fixest <- function(x, ...) {
  stopifnot(length(x$method) == 1)
  # results that are common to all models:
  res_common <- as_glance_tibble(
    logLik = logLik(x),
    AIC = AIC(x),
    BIC = BIC(x),
    nobs = nobs(x),
    na_types = "rrri"
  )

  if (identical(x$method, "feols")) {
    r2_vals <- fixest::r2(x, type = c("r2", "ar2", "wr2"))
    r2_names <- c("r.squared", "adj.r.squared", "within.r.squared")
    # Pull the summary objects that are specific to OLS
    res_specific <- with(
      summary(x, ...),
      tibble(
        sigma = sqrt(sigma2),
        pseudo.r.squared = NA_real_, # always NA for OLS
      )
    )
  } else {
    # Note that calculating within R2 is expensive for non-OLS models: doing so
    # requires re-estimating the model, so don't do it.
    # Also, these are now pseudo R2. Could use adjusted pseudo R2, but that
    # isn't supported by modeltests, and seems niche.
    r2_vals <- fixest::r2(x, type = "pr2")
    r2_names <- "pseudo.r.squared"

    # Currently no other stats for non-OLS models (beyond pseudo R2, logLik,
    # AIC, BIC, and nobs), but you could add them if you wanted.
    # Fill in the sigma and other R2 values with NA.
    res_specific <- tibble(
      sigma = NA_real_,
      r.squared = NA_real_,
      adj.r.squared = NA_real_,
      within.r.squared = NA_real_,
    )
  }
  # Some of these will be NA, depending on the model, but for consistency we'll
  # always return all four R2 values.
  names(r2_vals) <- r2_names
  res_r2 <- tibble(!!!r2_vals)
  col_order <- c("r.squared", "adj.r.squared", "within.r.squared",
    "pseudo.r.squared", "sigma", "nobs", "AIC", "BIC", "logLik")
  res <- bind_cols(res_common, res_r2, res_specific) %>%
    select(col_order)
  res
}
