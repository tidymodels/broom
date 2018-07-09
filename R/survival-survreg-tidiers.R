#' @templateVar class survreg
#' @template title_desc_tidy
#'
#' @param x An `survreg` object returned from [survival::survreg()].
#' @param conf.level confidence level for CI
#' @template param_unused_dots
#' 
#' @template return_tidy_regression
#'
#' @examples
#'
#' library(survival)
#' 
#' sr <- survreg(
#'   Surv(futime, fustat) ~ ecog.ps + rx,
#'   ovarian,
#'   dist = "exponential"
#' )
#'
#' td <- tidy(sr)
#' augment(sr, ovarian)
#' glance(sr)
#'
#' # coefficient plot
#' library(ggplot2)
#' ggplot(td, aes(estimate, term)) + 
#'   geom_point() +
#'   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
#'   geom_vline(xintercept = 0)
#'
#' @aliases survreg_tidiers
#' @export
#' @seealso [tidy()], [survival::survreg()]
#' @family survreg tidiers
#' @family survival tidiers
#' 
tidy.survreg <- function(x, conf.level = .95, ...) {
  s <- summary(x)
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(s$table, newnames = nn)
  ret
  
  # add confidence interval
  ci <- stats::confint(x, level = conf.level)
  colnames(ci) <- c("conf.low", "conf.high")
  ci <- fix_data_frame(ci)
  as_tibble(merge(ret, ci, all.x = TRUE, sort = FALSE))
}


#' @templateVar class survreg
#' @template title_desc_augment
#' 
#' @param x An `survreg` object returned from [survival::survreg()].
#' @template param_data
#' @template param_newdata
#' @template param_type_residuals
#' @template param_type_predict
#' @template param_unused_dots
#'
#' @template augment_NAs
#'
#' @return A [tibble::tibble] with the passed data and additional columns:
#' 
#'   \item{.fitted}{Fitted values of model}
#'   \item{.se.fit}{Standard errors of fitted values}
#'   \item{.resid}{Residuals}
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
#' @inheritParams tidy.survreg
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{iter}{number of iterations}
#'   \item{df}{degrees of freedom}
#'   \item{statistic}{chi-squared statistic}
#'   \item{p.value}{p-value from chi-squared test}
#'   \item{logLik}{log likelihood}
#'   \item{AIC}{Akaike information criterion}
#'   \item{BIC}{Bayesian information criterion}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' @export
#' @seealso [glance()], [survival::survreg()]
#' @family survreg tidiers
#' @family survival tidiers
glance.survreg <- function(x, ...) {
  ret <- tibble(iter = x$iter, df = sum(x$df))
  ret$statistic <- 2 * diff(x$loglik)
  ret$p.value <- 1 - stats::pchisq(ret$statistic, sum(x$df) - x$idf)
  finish_glance(ret, x)
}
