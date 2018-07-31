#' @templateVar class garch
#' @template title_desc_tidy
#'
#' @param x A `garch` object returned by [tseries::garch()].
#' @template param_unused_dots
#'
#' @return A [tibble::tibble] with one row for each coefficient and columns:
#' 
#'   \item{term}{The term in the linear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error}
#'   \item{statistic}{test statistic}
#'   \item{p.value}{p-value}
#'
#' @examples
#'
#' library(tseries)
#' 
#' data(EuStockMarkets)
#' dax <- diff(log(EuStockMarkets))[,"DAX"]
#' dax.garch <- garch(dax)
#' dax.garch
#' 
#' tidy(dax.garch)
#' glance(dax.garch)
#' 
#' @aliases garch_tidiers
#' @export
#' @family garch tidiers
#' @seealso [tidy()], [tseries::garch()]
tidy.garch <- function(x, ...) {
  s <- summary(x)
  co <- s$coef
  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(co, nn[1:ncol(co)])
  as_tibble(ret)
}

#' @templateVar class garch
#' @template title_desc_tidy
#'
#' @param x A `garch` object returned by [tseries::garch()].
#' @param test Character specification of which hypothesis test to use. The
#'   `garch` function reports 2 hypothesis tests: Jarque-Bera to residuals
#'    and Box-Ljung to squared residuals.
#' @template param_unused_dots
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
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
#' @family garch tidiers
#' @seealso [glance()], [tseries::garch()], []
glance.garch <- function(x, test = c("box-ljung-test", "jarque-bera-test"), ...) {
  test <- match.arg(test)
  s <- summary(x)
  ret <- garch_glance_helper(s, test, ...)
  ret <- finish_glance(ret, x)
  as_tibble(ret)
}

garch_glance_helper <- function(x, test, ...) {
  ret <- if (test == "box-ljung-test") {
    glance.htest(x$l.b.test)
  } else {
    glance.htest(x$j.b.test)
  }
  as_tibble(ret)
}
