#' @templateVar class nls
#' @template title_desc_tidy
#'
#' @param x An `nls` object returned from [stats::nls()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @examplesIf rlang::is_installed("ggplot2")
#'
#' # fit model
#' n <- nls(mpg ~ k * e^wt, data = mtcars, start = list(k = 1, e = 2))
#' 
#' # summarize model fit with tidiers + visualization
#' tidy(n)
#' augment(n)
#' glance(n)
#'
#' library(ggplot2)
#' 
#' ggplot(augment(n), aes(wt, mpg)) +
#'   geom_point() +
#'   geom_line(aes(y = .fitted))
#'
#' newdata <- head(mtcars)
#' newdata$wt <- newdata$wt + 1
#' 
#' augment(n, newdata = newdata)
#' 
#' @aliases  nls_tidiers
#' @export
#' @seealso [tidy], [stats::nls()], [stats::summary.nls()]
#' @family nls tidiers
tidy.nls <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  check_ellipses("exponentiate", "tidy", "nls", ...)
  
  ret <- as_tidy_tibble(
    stats::coef(summary(x)), 
    new_names = c("estimate", "std.error", "statistic", "p.value")
  )

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
#' @inherit tidy.nls params examples
#' @template param_data
#' @template param_newdata
#'
#' @evalRd return_augment()
#'
#' @details augment.nls does not currently support confidence intervals due to
#' a lack of support in stats::predict.nls().
#'
#' @export
#' @seealso [tidy], [stats::nls()], [stats::predict.nls()]
#' @family nls tidiers
#'
augment.nls <- function(x, data = NULL, newdata = NULL, ...) {
  if (is.null(data) && is.null(newdata)) {
    pars <- names(x$m$getPars())
    env <- as.list(x$m$getEnv())
    data <- as_tibble(env[!(names(env) %in% pars)])
  }

  augment_columns(x, data, newdata, .se_fit = FALSE)
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

  as_glance_tibble(
    sigma = s$sigma,
    isConv = s$convInfo$isConv,
    finTol = s$convInfo$finTol,
    logLik = as.numeric(stats::logLik(x)),
    AIC = stats::AIC(x),
    BIC = stats::BIC(x),
    deviance = stats::deviance(x),
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x),
    na_types = "rlrrrrrii"
  )
}
