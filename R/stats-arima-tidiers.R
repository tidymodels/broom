#' @templateVar class Arima
#' @template title_desc_tidy
#'
#' @param x An object of class `Arima` created by [stats::arima()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(
#'  "term",
#'  "estimate",
#'  "std.error",
#'  "conf.low",
#'  "conf.high"
#'  )
#' 
#' @examples
#'
#' fit <- arima(lh, order = c(1, 0, 0))
#' 
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
    ci <- broom_confint_terms(x, level = conf.level)
    ret <- dplyr::left_join(ret, ci, by = "term")
  }
  
  as_tibble(ret)
}


#' @templateVar class Arima
#' @template title_desc_glance
#' 
#' @inherit tidy.Arima params examples
#'
#' @evalRd return_glance("sigma", "logLik", "AIC", "BIC", "nobs")
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
  ret$nobs <- stats::nobs(x)
  as_tibble(ret)
}
