#' @templateVar class nls
#' @template title_desc_tidy
#' 
#' @param x An `nls` object returned from [stats::nls()].
#' @template param_confint
#' @template param_quick
#' @template param_unused_dots
#' 
#' @template return_tidy_regression
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
#' 
#' @template return_augment_columns
#'
#' @export
#' @seealso [tidy], [stats::nls()], [stats::predict.nls()]
#' @family nls tidiers
#' 
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


#' @templateVar class nls
#' @template title_desc_glance
#' 
#' @inheritParams tidy.nls
#'
#' @return A one-row [tibble::tibble] with columns:
#' 
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
#' @seealso [tidy], [stats::nls()]
#' @family nls tidiers
glance.nls <- function(x, ...) {
  s <- summary(x)
  ret <- unrowname(data.frame(
    sigma = s$sigma, isConv = s$convInfo$isConv,
    finTol = s$convInfo$finTol
  ))
  as_tibble(finish_glance(ret, x))
}
