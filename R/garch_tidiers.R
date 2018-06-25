#' Tidying methods for a GARCH model (tseries package)
#'
#' This tidies the result of a coefficient of the GARCH model implemented in
#' `tseries` package.
#'
#' @param x garch object
#' @param method `character` which specifies the hypothesis test to be shown in `glance`.
#' The `garch` function reports 2 hypothesis tests: Jarque-Bera to residuals
#' and Box-Ljung to squared residuals.
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
#'     smp1 = window(dax, end = c(1997, frequency(dax)))
#'     smp2 = window(dax, start = c(1998, 1))
#'     dax.garch <- garch(smp1)
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
