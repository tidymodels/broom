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
#'
#' library(fixest)
#' 
#' gravity <- feols(log(Euros) ~ log(dist_km) | Origin + Destination + Product + Year, trade)
#' 
#' tidy(gravity)
#' glance(gravity)
#' augment(gravity, trade)
#' 
#' ## To get robust or clustered SEs, users can either:
#' # 1) Feed tidy() a summary.fixest object that has already accepted these arguments
#' gravity_summ <- summary(gravity, cluster = c("Product", "Year"))
#' tidy(gravity_summ, conf.int = T)
#' # 2) Or, specify the arguments directly in the tidy() call
#' tidy(gravity, conf.int = T, cluster = c("Product", "Year"))
#' tidy(gravity, conf.int = T, se = "threeway")
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
tidy.fixest <- function(x, conf.int = FALSE, conf.level = 0.95,   ...) {
  
  nn <- c("estimate", "std.error", "statistic", "p.value")
  
  ## Option 1) User specifies se or cluster arguments as part of tidy() call
  # if (!is.null(se) | !is.null(cluster)) {
  if (!missing(...)) {
    ret <- fix_data_frame(summary(x, ...)$coeftable, nn)
  }
  
  ## Option 2) Otherwise, just use whatever object the user feeds into tidy()
  if (missing(...)) {
    ret <- fix_data_frame(x$coeftable, nn)
  }
  
  ## CIs (if desired) will follow a simiar pattern as above, depending on what
  ## the user specifies in the tidy() call.
  if (conf.int) {
    ## Option 1
    if (!missing(...)) {
      CI <- stats::confint(x, level = conf.level, ...)
      colnames(CI) <- c("conf.low", "conf.high")
    }
    ## Option 2 (Requires some reverse engineering to get CIs)
    if (missing(...)) {
      ## First determine SE type (and cluster variables if applicable)
      se_type <- attributes(x$se)$type
      cluster_vars <- gsub("[\\(\\)]", "", regmatches(se_type, gregexpr("\\(.*?\\)", se_type)))
      cluster_vars <- gsub(" & ", "+", cluster_vars)
      if (cluster_vars=="character0") cluster_vars <- NULL ## Optional: Shouldn't make a difference
      ## Non-clustered SEs
      if (se_type=="Standard") se_type <- "standard"
      if (se_type=="White") se_type <- "white"
      if (grepl("Clustered", se_type)) se_type <- "cluster"
      if (grepl("Two-way", se_type)) se_type <- "twoway"
      if (grepl("Three-way", se_type)) se_type <- "threeway"
      if (grepl("Four-way", se_type)) se_type <- "fourway"
      CI <- stats::confint(x, level = conf.level, se = se_type, cluster = formula(noquote(paste0("~",cluster_vars))))
    }
    ## Bind to rest of tibble
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, unrowname(CI))
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
#' Important note: `fixest` models do not include a copy of the input data, so
#' you must provide it manually.
#'
#' @export
#' @family fixest tidiers
#' @seealso [augment()], [fixest::feglm()], [fixest::fenegbin()],
#' [fixest::feNmlm()], [fixest::femlm()], [fixest::feols()], [fixest::fepois()]
augment.fixest <- function(x, data = NULL, newdata = NULL, type.predict="link", ...) {
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
    df <- mutate(df,
      .resid = residuals(x),
      # https://github.com/lrberge/fixest/issues/3
      .fitted = predict(x, type = type.predict)
    )
  }
  df
}

#' @templateVar class fixest
#' @template title_desc_glance
#'
#' @inherit tidy.fixest params examples
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "nobs"
#' )
#'
#' @export
glance.fixest <- function(x, ...) {
  # Get R2, adjusted R2, and within R2 values. If these are NA, get their
  # pseudo-R2, pseudo-adjusted R2, or pseudo-within R2 counterparts.
  # NA status depends on the details of the model estimated.
  # Within adjusted R2 is also available. See the fixest::r2 docs.
  r2 <- fixest::r2(x, type="r2")
  if (is.na(r2)) {
    r2 <- fixest::r2(x, type="pr2")
  }
  r2adj <- fixest::r2(x, type="ar2")
  if (is.na(r2adj)) {
    r2adj <- fixest::r2(x, type="apr2")
  }
  # wr2 and wpr2 can be trouble because of https://github.com/lrberge/fixest/issues/5
  # r2within <- fixest::r2(x, type="wr2")
  # if (is.na(r2within)) {
  #   r2within <- fixest::r2(x, type="wpr2")
  # }

  ret <- with(
    summary(x, ...),
    tibble(
      r.squared = r2,
      adj.r.squared = r2adj,
      # within.r.squared = r2within,
      # sigma = sqrt(sigma2), # only available for feols?
      # statistic = fstat,
      # p.value = pval,
      logLik = logLik(x),
      AIC = AIC(x),
      BIC = BIC(x),
      # df = df[1],
      # df.residual = rdf,
      nobs = stats::nobs(x)
  ))
  ret
}
