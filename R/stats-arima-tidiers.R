#' @templateVar class Arima
#' @template title_desc_tidy
#'
#' @param x An object of class `Arima` created by [stats::arima()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' 
#' @return A [tibble::tibble] with one row for each coefficient and columns:
#' 
#'   \item{term}{The term in the nonlinear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'
#' If `conf.int = TRUE`, also returns
#'   \item{conf.low}{low end of confidence interval}
#'   \item{conf.high}{high end of confidence interval}
#' 
#' @examples
#'
#' fit <- arima(lh, order = c(1, 0, 0))
#' tidy(fit)
#' glance(fit)
#'
#' @aliases Arima_tidiers
#' @seealso [stats::arima()]
#' @export
#' @family Arima tidiers
tidy.Arima <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
  coefs <- stats::coef(x)
  # standard errors are computed as in stats:::print.Arima
  ses <- rep.int(0, length(coefs))
  ses[x$mask] <- sqrt(diag(x$var.coef))

  ret <- unrowname(data.frame(
    term = names(coefs),
    estimate = coefs,
    std.error = ses
  ))

  if (conf.int) {
    ret <- cbind(ret, confint_tidy(x))
  }
  as_tibble(ret)
}


#' @templateVar class Arima
#' @template title_desc_glance
#' 
#' @inheritParams tidy.Arima
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{sigma}{the square root of the estimated residual variance}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'
#' @seealso [stats::arima()]
#' @export
#' @family Arima tidiers
glance.Arima <- function(x, ...) {
  ret <- tibble(sigma = sqrt(x$sigma2))
  ret$logLik <- tryCatch(as.numeric(stats::logLik(x)), error = function(e) NULL)
  # special case for class Arima when method = "CSS"
  if (!is.na(ret$logLik)) {
    ret$AIC <- tryCatch(stats::AIC(x), error = function(e) NULL)
    ret$BIC <- tryCatch(stats::BIC(x), error = function(e) NULL)
  }
  as_tibble(ret)
}
