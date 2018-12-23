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
#' @aliases survreg_tidiers
#' @export
#' @seealso [tidy()], [survival::survreg()]
#' @family survreg tidiers
#' @family survival tidiers
#' 
tidy.survreg <- function(x, conf.level = .95, conf.int = FALSE, ...) {
  s <- summary(x)
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(s$table, newnames = nn)
  
  if(conf.int){
    # add confidence interval
    ci <- stats::confint(x, level = conf.level)
    colnames(ci) <- c("conf.low", "conf.high")
    ci <- fix_data_frame(ci)
    ret <- as_tibble(merge(ret, ci, all.x = TRUE, sort = FALSE))
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
#'   statistic = "Chi-squared statistic."
#' )
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
