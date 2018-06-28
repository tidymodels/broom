#' @rdname rq_tidiers
#'
#' @return `tidy.nlrq` returns one row for each coefficient in the model,
#' with five columns:
#'   \item{term}{The term in the nonlinear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#'
#' @export
tidy.nlrq <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(coef(summary(x)), nn)
  
  if (conf.int) {
    x_summary <- summary(x)
    a <- (1 - conf.level) / 2
    cv <- qt(c(a, 1 - a), df = x_summary[["rdf"]])
    ret[["conf.low"]] <- ret[["estimate"]] + (cv[1] * ret[["std.error"]])
    ret[["conf.high"]] <- ret[["estimate"]] + (cv[2] * ret[["std.error"]])
  }
  tibble::as_tibble(ret)
}

#' @rdname rq_tidiers
#'
#' @return `glance.rq` returns one row for each quantile (tau)
#' with the columns:
#'  \item{tau}{quantile estimated}
#'  \item{logLik}{the data's log-likelihood under the model}
#'  \item{AIC}{the Akaike Information Criterion}
#'  \item{BIC}{the Bayesian Information Criterion}
#'  \item{df.residual}{residual degrees of freedom}
#' @export
glance.nlrq <- function(x, ...) {
  n <- length(x[["m"]]$fitted())
  s <- summary(x)
  tibble::tibble(
    tau = x[["m"]]$tau(),
    logLik = logLik(x),
    AIC = AIC(x),
    BIC = AIC(x, k = log(n)),
    df.residual = s[["rdf"]]
  )
}

#' @rdname rq_tidiers
#'
#' @details This simply calls `augment.nls` on the "nlrq" object.
#'
#' @return `augment.rqs` returns a row for each original observation
#' with the following columns added:
#'  \item{.resid}{Residuals}
#'  \item{.fitted}{Fitted quantiles of the model}
#'
#'
#' @export
augment.nlrq <- function(x, ...) {
  augment.nls(x, ...)
}
