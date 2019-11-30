#' @templateVar class fixest
#' @template title_desc_tidy
#'
#' @param x A `fixest` object returned from any of the `fixest` estimators
#' @template param_confint
#' @param ... Additional arguments passed to `summary` and `confint`. Important
#' arguments are `se` and `cluster`. See [fixest:::summary.fixest()].
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
#' # 1) Feed tidy() a summary.fixest object that has already accepted these arguments
#' gravity_summ <- summary(gravity, cluster = c("Product", "Year"))
#' tidy(gravity_summ, conf.int = TRUE)
#' # 2) Or, specify the arguments directly in the tidy() call
#' tidy(gravity, conf.int = TRUE, cluster = c("Product", "Year"))
#' tidy(gravity, conf.int = TRUE, se = "threeway")
#' # etc.
#'
#' ## The other fixest methods all working similarly. For example:
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
  has_dots <- !missing(...)
  # These two options are necessary because the user might specify
  # broom(x, cluster="something") or
  # broom(summary(x, cluster="something"))
  # and calling summary() again will overwrite the arguments in the second case.
  # Note that class(summary(x)) == class(x) == "fixest".
  if (has_dots) {
    # Option 1) User specifies se or cluster arguments as part of tidy() call
    coeftable <- summary(x, ...)$coeftable
  } else {
    # Option 2) Otherwise, just use whatever object the user feeds into tidy()
    coeftable <- x$coeftable
  }
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(coeftable, nn)

  # CIs (if desired) will follow a simiar pattern as above, depending on what
  # the user specifies in the tidy() call.
  if (conf.int) {
    if (has_dots) {
      CI <- stats::confint(x, level = conf.level, ...)
      # Bind to rest of tibble
      colnames(CI) <- c("conf.low", "conf.high")
      ret <- cbind(ret, unrowname(CI))
    } else {
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
  }
  as_tibble(ret)
}

#' @templateVar class fixest
#' @template title_desc_augment
#'
#' @inherit tidy.fixest params examples
#' @template param_data
#' @param type.predict Passed to [fixest:::predict.fixest()] `type` argument.
#'   Defaults to `"link"` (like [stats::glm.predict()]).
#'
#' @evalRd return_augment()
#'
#' @note Important note: `fixest` models do not include a copy of the input
#' data, so you must provide it manually.
#'
#' augment.fixest only works for [fixest::feols()], [fixest::feglm()], and
#' [fixest::femlm()] models.
#'
#' @export
#' @family fixest tidiers
#' @seealso [augment()], [fixest::feglm()], [fixest::femlm()], [fixest::feols()]
augment.fixest <- function(x, data = NULL, newdata = NULL, type.predict="link", ...) {
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
  df <- as_broom_tibble(df)
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
#' @return A one-row [tibble::tibble()] with exactly one row and columns:
#'
#' - logLik The log-likelihood of the model. [stats::logLik()] may be a useful
#'   reference.
#' - AIC Akaike's Information Criterion for the model.
#' - BIC Bayesian Information Criterion for the model.
#' - nobs Number of observations used.
#' - sigma (`feols` models only)
#' - r.squared (`feols` models only)
#' - adj.r.squared Adjusted R squared statistic, which is like the R squared
#'   statistic except taking degrees of freedom into account. (`feols` models only)
#' - within.r.squared R squared within fixed-effect groups (`feols` models only)
#' - pseudo.r.squared Like the R squared statistic, but for situations when the
#'   R squared statistic isn't defined. (non-`feols` models only)
#'
#' @export
glance.fixest <- function(x, ...) {
  stopifnot(length(x$method) == 1)
  # results that are common to all models:
  res_common <- tibble(
    logLik = logLik(x),
    AIC = AIC(x),
    BIC = BIC(x),
    nobs = nobs(x),
  )

  if (identical(x$method, "feols")) {
    r2_vals <- fixest::r2(x, type = c("r2", "ar2", "wr2"))
    r2_names <- c("r.squared", "adj.r.squared", "within.r.squared")

    # Pull the summary objects that are specific to OLS
    res_specific <- with(
      summary(x, ...),
      tibble(
        sigma = sqrt(sigma2),
      )
    )
  } else {
    # Note that calculating within R2 is expensive for non-OLS models: doing so
    # requires re-estimating the model, so don't do it.
    # Also, these are now pseudo R2. Could use adjusted pseudo R2, but that
    # isn't supported by modeltests, and seems niche.
    r2_vals <- fixest::r2(x, type = c("pr2"))
    r2_names <- c("pseudo.r.squared")

    # Currently no other stats for non-OLS models (beyond pseudo R2, logLik,
    # AIC, BIC, and nobs), but you could add them if you wanted.
    res_specific <- tibble()
  }
  names(r2_vals) <- r2_names
  res_r2 <- tibble(!!!r2_vals)
  bind_cols(res_common, res_r2, res_specific)
}
