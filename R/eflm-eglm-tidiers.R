#' @templateVar class eglm
#' @template title_desc_tidy
#'
#' @param x An `eglm` object returned from [eflm::eglm()].
#' @template param_confint
#' @template param_exponentiate
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' clotting <- data.frame(
#'   u = c(5, 10, 15, 20, 30, 40, 60, 80, 100),
#'   lot1 = c(118, 58, 42, 35, 27, 25, 21, 19, 18)
#' )
#'
#' fit <- eflm::eglm(lot1 ~ log(u), data = clotting, family = Gamma(log))
#'
#' tidy(fit)
#' glance(fit)
#' @aliases eglm_tidiers
#' @export
#' @family elm tidiers
#' @seealso [eflm::eglm()]
tidy.eglm <- function(x, conf.int = FALSE, conf.level = .95,
                      exponentiate = FALSE) {
  stopifnot(any(class(x) %in% "eglm"))
  
  ret <- as.data.frame(summary(x)$coefficients)
  rownames(ret) <- NULL
  ret <- cbind(rownames(summary(x)$coefficients), ret)
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  
  coefs <- as.data.frame(coef(x))
  rownames(coefs) <- NULL
  coefs <- cbind(names(coef(x)), coefs)
  colnames(coefs) <- c("term", "estimate")
  
  if (exponentiate) {
    ret$estimate <- exp(ret$estimate)
  }
  
  if (conf.int) {
    ci <- suppressMessages(as.data.frame(confint(x, level = conf.level)))
    rownames(ci) <- NULL
    ci <- cbind(names(coef(x)), ci)
    colnames(ci) <- c("term", "conf.low", "conf.high")
    
    ret <- merge(ret, ci, by = "term")
    
    if (exponentiate) {
      ret$conf.low <- exp(ret$conf.low)
      ret$conf.high <- exp(ret$conf.high)
    }
  }
  
  return(tibble::as_tibble(ret))
}

#' @templateVar class eglm
#' @template title_desc_glance
#'
#' @inherit tidy.eflm params examples
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "null.deviance",
#'   "df.null",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @family eflm tidiers
#' @seealso [eflm::eglm()]
glance.eglm <- function(x, ...) {
  stopifnot(any(class(x) %in% "eglm"))
  
  df <- as_glance_tibble(
    null.deviance = x$null.deviance,
    df.null = x$df.null,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    na_types = "rirrrrii"
  )
  
  return(tibble::as_tibble(df))
}

#' @export
augment.eglm <- augment.default
