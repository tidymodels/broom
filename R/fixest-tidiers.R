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
tidy.fixest <- function(x, conf.int = FALSE, conf.level = 0.95, se, ...) {
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(stats::coef(summary(x, ...)), nn)

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
#'
#' @evalRd return_augment()
#'
#' @export
#' @family fixest tidiers
#' @seealso [augment()], [fixest::feglm()], [fixest::fenegbin()],
#' [fixest::feNmlm()], [fixest::femlm()], [fixest::feols()], [fixest::fepois()]
augment.fixest <- function(x, data = model.frame(x), ...) {
  df <- as_broom_tibble(data)
  mutate(df, .fitted = x$fitted.values, .resid = x$residuals)
}

#' @templateVar class fixest
#' @template title_desc_glance
#'
#' @inherit tidy.fixest params examples
#'
#' @evalRd return_glance(
#'   "r.squared",
#'   "adj.r.squared",
#'   "sigma",
#'   "statistic",
#'   "p.value",
#'   "df",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
glance.fixest <- function(x, ...) {
  ret <- with(
    summary(x, ...),
    tibble(
      r.squared = r2,
      adj.r.squared = r2adj,
      sigma = rse,
      statistic = fstat,
      p.value = pval,
      df = df[1],
      df.residual = rdf,
      nobs = stats::nobs(x)
  ))
  ret
}
