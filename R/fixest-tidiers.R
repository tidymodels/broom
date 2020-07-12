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
#' gravity <- feols(log(Euros) ~ log(dist_km) | Origin + Destination + Product + Year, trade)
#'
#' tidy(gravity)
#' glance(gravity)
#' augment(gravity, trade)
#'
#' ## To get robust or clustered SEs, users can either:
#  # 1) Or, specify the arguments directly in the tidy() call
#' tidy(gravity, conf.int = TRUE, cluster = c("Product", "Year"))
#' tidy(gravity, conf.int = TRUE, se = "threeway")
#' # 2) Feed tidy() a summary.fixest object that has already accepted these arguments
#' gravity_summ <- summary(gravity, cluster = c("Product", "Year"))
#' tidy(gravity_summ, conf.int = TRUE)
#' # Approach (1) is preferred.
#'
#' ## The other fixest methods all work similarly. For example:
#' gravity_pois <- feglm(Euros ~ log(dist_km) | Origin + Destination + Product + Year, trade)
#' tidy(gravity_pois)
#' glance(gravity_pois)
#' augment(gravity_pois, trade)
#' }
#'
#' @export
#' @family fixest tidiers
#' @seealso [tidy()], [fixest::feglm()], [fixest::fenegbin()],
#' [fixest::feNmlm()], [fixest::femlm()], [fixest::feols()], [fixest::fepois()]
tidy.fixest <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  not_summary <- !is_fixest_summary(x)
  # These two options are necessary because the user might specify
  # broom(x, cluster="something") or
  # broom(summary(x, cluster="something"))
  # and calling summary() again will overwrite the arguments in the second case.
  # Note that class(summary(x)) == class(x) == "fixest".
  if (not_summary) {
    # Option 1) User provides a non-summary object
    ret <- tidy_fixest(x, conf.int = conf.int, conf.level = conf.level, ...)
  } else {
    # Option 2) User provides a fixest summary object
    ret <- tidy_summary_fixest(x, conf.int = conf.int, conf.level = conf.level)
  }
  as_tibble(ret)
}

is_fixest_summary <- function(x) {
  # Is `x` the result of summary(some_fixest_result)?
  # Returns TRUE/FALSE.
  if (!inherits(x, "fixest")) {
    stop("This is a fixest helper function only.")
  }
  "cov.scaled" %in% names(x)
}

tidy_summary_fixest <- function(x, conf.int = conf.int, conf.level = conf.level, ...) {
  # If this is a summary object, assume the user has already applied whatever
  # clustering or standard error specification they want.
  if (length(list(...)) > 0) {
    stop(
      "The fixest object provided to tidy() was already a summary. ",
      "Additional arguments were provided but can't be used. ",
      "To specify `cluster` or `se`, call tidy() without summary()."
    )
  }
  coeftable <- x$coeftable
  ret <- as_tibble(coeftable, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")

  if (conf.int) {
    # It's possible we were passed a summary of a fixest object. If no `...`
    # arguments were specified, then we want to use the std error that `x`
    # already has. That is, we don't want to call confint() because
    # doing so throws away whatever arguments were provided to summary().
    ci_fact <- abs(qnorm((1 - conf.level) / 2))
    ret <- mutate(ret,
      conf.low  = estimate - ci_fact * std.error,
      conf.high = estimate + ci_fact * std.error
    )
  }
  ret
}

tidy_fixest <- function(x, conf.int = conf.int, conf.level = conf.level, ...) {
  coeftable <- summary(x, ...)$coeftable
  ret <- as_tibble(coeftable, rownames = "term")
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  if (conf.int) {
    CI <- stats::confint(x, level = conf.level, ...)
    # Bind to rest of tibble
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- bind_cols(ret, unrowname(CI))
  }
  ret
}



#' @templateVar class fixest
#' @template title_desc_augment
#'
#' @inherit tidy.fixest params examples
#' @template param_data
#' @template param_newdata
#' @param type.predict Passed to [`predict.fixest`][fixest::predict.fixest()]
#'   `type` argument. Defaults to `"link"` (like `glm.predict`).
#'
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
                           type.predict = "response", ...) {
  if (!x$method %in% c("feols", "feglm", "femlm")) {
    stop("augment is only supported for fixest models estimated with ",
      "feols, feglm, or femlm\n",
      "  (supplied model used ", x$method, ")"
    )
  }

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
    df <- mutate(df,
      .fitted = predict(x, type = type.predict),
      .resid = residuals(x)
    )
  } else {
    #
    df$.fitted <- residuals(x, type = type.predict, newdata = newdata)
  }
  df
}

#' @templateVar class fixest
#' @template title_desc_glance
#'
#' @inherit tidy.fixest params examples
#'
#' @note The columns of the result depend on the type of model estimated.
#'
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
