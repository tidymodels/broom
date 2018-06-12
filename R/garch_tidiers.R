#' Tidying methods for a GARCH model (tseries package)
#'
#' This tidies the result of a coefficient of the GARCH model implemented in
#' `tseries` package.
#'
#' @param x garch object
#' @param method `character` which specifies the hypothesis test to be shown in `glance`.
#' The `garch` function reports 2 hypothesis tests: Jarque-Bera to residuals
#' and Box-Ljung to squared residuals.
#' @param data original data (used with `augment`)
#' @param newdata new data provided for predition use (used with `augment`)
#' @param ... extra arguments (not used)
#'
#' @return A `data.frame` with one row for each coefficient, with five columns:
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error}
#'   \item{statistic}{test statistic}
#'   \item{p.value}{p-value}
#'
#' @examples
#'
#' if (require("tseries", quietly = TRUE)) {
#'     data(EuStockMarkets)
#'     dax <- diff(log(EuStockMarkets))[,"DAX"]
#'     dax.garch <- garch(dax)
#'     dax.garch
#'     tidy(dax.garch)
#'     glance(dax.garch)
#'     head(augment(dax.garch, dax))
#'     smp1 = window(dax, end = c(1997, frequency(dax)))
#'     smp2 = window(dax, start = c(1998, 1))
#'     dax.garch <- garch(smp1)
#'     augment(dax.garch, newdata = smp2)
#' }
#'
#' @name garch_tidiers
#' @export
tidy.garch <- function(x, ...) {
  s <- summary(x)
  co <- s$coef
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(co, nn[1:ncol(co)])
  as_tibble(ret)
}

#' @rdname garch_tidiers
#'
#' @return A `data.frame` with one row, with seven columns:
#'   \item{statistic}{Test statistic used to compute the p-value}
#'   \item{p.value}{P-value}
#'   \item{parameter}{Parameter field in the htest, typically degrees of
#'   freedom}
#'   \item{method}{Method used to compute the statistic as a string}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'
#' @export
glance.garch <- function(x, method = c("box-ljung-test", "jarque-bera-test"), ...) {
  method <- match.arg(method)
  s <- summary(x)
  ret <- glance.summary.garch(s, method, ...)
  ret <- finish_glance(ret, x)
  as_tibble(ret)
}

glance.summary.garch <- function(x, method, ...) {
  ret <- if (method == "box-ljung-test") {
    glance.htest(x$l.b.test)
  } else {
    glance.htest(x$j.b.test)
  }
  as_tibble(unrowname(ret))
}

#' @rdname garch_tidiers
#'
#' @return `augment.garch` returns one row for each observation of the
#' original `data`, with three columns added:
#'   \item{.time}{Sampling times of time series}
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#' The `data` must be provided, since the garch object doesn't has the data
#' in it.
#' When `newdata` is supplied, `augment.garch` returns one row for each
#' observation of `newdata` with the columns added:
#'   \item{.time}{Sampling times of time series}
#'   \item{.fitted}{Fitted values of model}
#'
#' @export
augment.garch <- function(x, data = NULL, newdata = NULL, ...) {
  if (!is.null(data) & stats::is.ts(data)) {
    .data <- as.matrix(data)
    .data <- cbind(.data, .resid = as.numeric(stats::residuals(x)))
    .data <- fix_data_frame(.data, newnames = c("data", ".resid"))
    .data$.time <- as.numeric(stats::time(data))
    .data$.fitted <- as.numeric(stats::fitted(x)[, 1])
  }
  if (!is.null(newdata) & stats::is.ts(newdata)) {
    .data <- as.matrix(newdata)
    .data <- fix_data_frame(.data, newnames = "newdata")
    .data$.time <- as.numeric(stats::time(newdata))
    .data$.fitted <- as.numeric(stats::predict(x, newdata)[, 1])
  }
  .c <- colnames(.data)
  .i <- which(.c == ".time")
  as_tibble(.data[, c(.c[.i], .c[-.i])])
}
