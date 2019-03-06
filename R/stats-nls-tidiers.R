#' @templateVar class nls
#' @template title_desc_tidy
#' 
#' @param x An `nls` object returned from [stats::nls()].
#' @template param_confint
#' @template param_quick
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examples
#'
#' n <- nls(mpg ~ k * e ^ wt, data = mtcars, start = list(k = 1, e = 2))
#'
#' tidy(n)
#' augment(n)
#' glance(n)
#'
#' library(ggplot2)
#' ggplot(augment(n), aes(wt, mpg)) +
#'   geom_point() +
#'   geom_line(aes(y = .fitted))
#'
#' newdata <- head(mtcars)
#' newdata$wt <- newdata$wt + 1
#' augment(n, newdata = newdata)
#'
#' @aliases  nls_tidiers
#' @export
#' @seealso [tidy], [stats::nls()], [stats::summary.nls()]
#' @family nls tidiers
tidy.nls <- function(x, conf.int = FALSE, conf.level = .95,
                     quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- data.frame(
      term = names(co), estimate = unname(co),
      stringsAsFactors = FALSE
    )
    return(as_tibble(ret))
  }

  nn <- c("estimate", "std.error", "statistic", "p.value")
  ret <- fix_data_frame(stats::coef(summary(x)), nn)

  if (conf.int) {
    # avoid "Waiting for profiling to be done..." message
    CI <- suppressMessages(stats::confint(x, level = conf.level))
    if (is.null(dim(CI))) {
      CI <- matrix(CI, nrow = 1)
    }
    colnames(CI) <- c("conf.low", "conf.high")
    ret <- cbind(ret, unrowname(CI))
  }
  as_tibble(ret)
}

#' @templateVar class nls
#' @template title_desc_augment
#' 
#' @inheritParams tidy.nls
#' @template param_data
#' @template param_newdata
#' @template param_se_fit
#' 
#' @evalRd return_augment()
#'
#' @export
#' @seealso [tidy], [stats::nls()], [stats::predict.nls()]
#' @family nls tidiers
#' 
augment.nls <- function(x, data = NULL, newdata = NULL, se_fit = FALSE, ...) {
  
  if (is.null(data) && is.null(newdata)) {
    pars <- names(x$m$getPars())
    env <- as.list(x$m$getEnv())
    data <- as_tibble(env[!(names(env) %in% pars)])
  }
  
  augment_newdata(x, data, newdata, se_fit)
}


#' @templateVar class nls
#' @template title_desc_glance
#' 
#' @inherit tidy.nls params examples
#'
#' @evalRd return_glance(
#'   "sigma",
#'   "isConv",
#'   "finTol",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual",
#'   "nobs"
#' )
#'
#' @export
#' @seealso [tidy], [stats::nls()]
#' @family nls tidiers
glance.nls <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(sigma = s$sigma, 
                isConv = s$convInfo$isConv,
                finTol = s$convInfo$finTol,
                logLik = as.numeric(stats::logLik(x)),
                AIC = stats::AIC(x),
                BIC = stats::BIC(x),
                deviance = stats::deviance(x),
                df.residual = stats::df.residual(x),
                nobs = stats::nobs(x))
  ret
}
