
#' Tidiers for a parametric regression survival model
#'
#' Tidies the coefficients of a parametric survival regression model,
#' from the "survreg" function, adds fitted values and residuals, or
#' summarizes the model statistics.
#'
#' @param x a "survreg" model
#' @param conf.level confidence level for CI
#' @param ... extra arguments (not used)
#'
#' @template boilerplate
#'
#' @examples
#'
#' if (require("survival", quietly = TRUE)) {
#'     sr <- survreg(Surv(futime, fustat) ~ ecog.ps + rx, ovarian,
#'            dist="exponential")
#'
#'     td <- tidy(sr)
#'     augment(sr, ovarian)
#'     glance(sr)
#'
#'     # coefficient plot
#'     library(ggplot2)
#'     ggplot(td, aes(estimate, term)) + geom_point() +
#'         geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0) +
#'         geom_vline(xintercept = 0)
#' }
#'
#' @name survreg_tidiers


#' @rdname survreg_tidiers
#'
#' @template coefficients
#'
#' @export
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


#' @name survreg_tidiers
#'
#' @param data original data; if it is not provided, it is reconstructed
#' as best as possible with [model.frame()]
#' @param newdata New data to use for prediction; optional
#' @param type.predict type of prediction, default "response"
#' @param type.residuals type of residuals to calculate, default "response"
#'
#' @template augment_NAs
#'
#' @return `augment` returns the original data.frame with the following
#' additional columns:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.se.fit}{Standard errors of fitted values}
#'   \item{.resid}{Residuals}
#'
#' @export
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




#' @rdname survreg_tidiers
#'
#' @return `glance` returns a one-row data.frame with the columns:
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
glance.survreg <- function(x, ...) {
  ret <- data.frame(iter = x$iter, df = sum(x$df))
  
  ret$statistic <- 2 * diff(x$loglik)
  ret$p.value <- 1 - stats::pchisq(ret$statistic, sum(x$df) - x$idf)
  
  finish_glance(ret, x)
}
