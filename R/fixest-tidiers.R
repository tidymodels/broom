#' @templateVar class fixest
#' @template title_desc_tidy
#'
#' @param x A `fixest` object returned from any of the `fixest` estimators
#' @template param_confint
#' @param ... Additional arguments passed to `summary` and `confint`. Important
#' arguments are `se` and `cluster`. See [fixest:::summary.fixest()].
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' library(fixest)
#'
#' N=1e2
#' DT <- data.frame(
#'   id = sample(5, N, TRUE),
#'   v1 =  sample(5, N, TRUE),
#'   v2 =  sample(1e6, N, TRUE),
#'   v3 =  sample(round(runif(100,max=100),4), N, TRUE),
#'   v4 =  sample(round(runif(100,max=100),4), N, TRUE)
#' )
#'
#' result_feols <- feols(v2~v3, DT)
#' tidy(result_feols)
#' augment(result_feols)
#'
#' result_feols <- feols(v2~v3|id+v1, DT)
#' tidy(result_feols, fe = TRUE)
#' augment(result_feols)
#'
#' v1<-DT$v1
#' v2 <- DT$v2
#' v3 <- DT$v3
#' id <- DT$id
#' result_feols <- feols(v2~v3|id+v1)
#'
#' tidy(result_feols)
#' augment(result_feols)
#' glance(result_feols)
#'
#' @export
#' @family fixest tidiers
#' @seealso [tidy()], [fixest::feglm()], [fixest::fenegbin()],
#' [fixest::feNmlm()], [fixest::femlm()], [fixest::feols()], [fixest::fepois()]
tidy.fixest <- function(x, conf.int = FALSE, conf.level = 0.95,   ...) {
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(summary(x, ...)$coeftable, nn)

  if (conf.int) {
    CI <- stats::confint(x, level = conf.level, ...)
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
