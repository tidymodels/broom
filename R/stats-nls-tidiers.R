#' Tidying methods for a nonlinear model
#'
#' These methods tidy the coefficients of a nonlinear model into a summary,
#' augment the original data with information on the fitted values and residuals,
#' and construct a one-row glance of the model's statistics.
#'
#' @param x An object of class "nls"
#' @param data original data this was fitted on; if not given this will
#' attempt to be reconstructed from nls (may not be successful)
#'
#' @return All tidying methods return a `tibble` without rownames.
#' The structure depends on the method chosen.
#'
#' @template augment_NAs
#'
#' @seealso [nls()] and [summary.nls()]
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
#' ggplot(augment(n), aes(wt, mpg)) + geom_point() + geom_line(aes(y = .fitted))
#'
#' # augment on new data
#' newdata <- head(mtcars)
#' newdata$wt <- newdata$wt + 1
#' augment(n, newdata = newdata)
#'
#' @name nls_tidiers
NULL


#' @rdname nls_tidiers
#'
#' @param conf.int whether to include a confidence interval
#' @param conf.level confidence level of the interval, used only if
#' `conf.int=TRUE`
#' @param quick whether to compute a smaller and faster version, containing
#' only the `term` and `estimate` columns.
#'
#' @return `tidy` returns one row for each coefficient in the model,
#' with five columns:
#'   \item{term}{The term in the nonlinear model being estimated and tested}
#'   \item{estimate}{The estimated coefficient}
#'   \item{std.error}{The standard error from the linear model}
#'   \item{statistic}{t-statistic}
#'   \item{p.value}{two-sided p-value}
#'
#' @export
tidy.nls <- function(x, conf.int = FALSE, conf.level = .95,
                     quick = FALSE, ...) {
  if (quick) {
    co <- stats::coef(x)
    ret <- data.frame(
      term = names(co), estimate = unname(co),
      stringsAsFactors = FALSE
    )
    return(tibble::as_tibble(ret))
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
  tibble::as_tibble(ret)
}


#' @rdname nls_tidiers
#'
#' @param newdata new data frame to use for predictions
#'
#' @return `augment` returns one row for each original observation,
#' with two columns added:
#'   \item{.fitted}{Fitted values of model}
#'   \item{.resid}{Residuals}
#'
#' If `newdata` is provided, these are computed on based on predictions
#' of the new data.
#'
#' @export
augment.nls <- function(x, data = NULL, newdata = NULL, ...) {
  
  validate_augment_input(x, data, newdata)
  
  if (!is.null(newdata)) {
    ret <- as_rw_tibble(newdata)
    ret$.fitted <- predict(x, newdata = newdata)
    return(ret)
  }
  
  if (is.null(data)) {
    pars <- names(x$m$getPars())
    env <- as.list(x$m$getEnv())
    data <- as_tibble(env[!(names(env) %in% pars)])
  }
  
  augment_columns(x, data)
}


#' @rdname nls_tidiers
#'
#' @param ... extra arguments (not used)
#'
#' @return `glance` returns one row with the columns
#'   \item{sigma}{the square root of the estimated residual variance}
#'   \item{isConv}{whether the fit successfully converged}
#'   \item{finTol}{the achieved convergence tolerance}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
#'
#' @export
glance.nls <- function(x, ...) {
  s <- summary(x)
  ret <- unrowname(data.frame(
    sigma = s$sigma, isConv = s$convInfo$isConv,
    finTol = s$convInfo$finTol
  ))
  tibble::as_tibble(finish_glance(ret, x))
}
