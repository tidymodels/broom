#' @templateVar class cv.glmnet
#' @template title_desc_tidy
#' 
#' @param x A `cv.glmnet` object returned from [glmnet::cv.glmnet()].
#' @template param_unused_dots
#' 
#' @return A [tibble::tibble] with one-row for each value of the penalization
#'   parameter `lambda` in `x` and columns:
#'   \item{lambda}{Value of the penalty parameter lambda.}
#'   \item{estimate}{Median loss across all cross-validation folds for a given
#'     lambda.}
#'   \item{std.error}{Standard error of the cross-validation estimated loss.}
#'   \item{conf.low}{lower bound on confidence interval for cross-validation
#'     estimated loss.}
#'   \item{conf.high}{Upper bound on confidence interval for cross-validation
#'     estimated loss.}
#'   \item{nzero}{Number of coefficients that are exactly zero for given
#'     lambda}.
#' 
#' @examples
#'
#' if (requireNamespace("glmnet", quietly = TRUE)) {
#' 
#'     library(glmnet)
#'     set.seed(27)
#'
#'     nobs <- 100
#'     nvar <- 50
#'     real <- 5
#'
#'     x <- matrix(rnorm(nobs * nvar), nobs, nvar)
#'     beta <- c(rnorm(real, 0, 1), rep(0, nvar - real))
#'     y <- c(t(beta) %*% t(x)) + rnorm(nvar, sd = 3)
#'
#'     cvfit1 <- cv.glmnet(x,y)
#'
#'     tidy(cvfit1)
#'     glance(cvfit1)
#'
#'     library(ggplot2)
#'     tidied_cv <- tidy(cvfit1)
#'     glance_cv <- glance(cvfit1)
#'
#'     # plot of MSE as a function of lambda
#'     g <- ggplot(tidied_cv, aes(lambda, estimate)) + geom_line() + scale_x_log10()
#'     g
#'
#'     # plot of MSE as a function of lambda with confidence ribbon
#'     g <- g + geom_ribbon(aes(ymin = conf.low, ymax = conf.high), alpha = .25)
#'     g
#'
#'     # plot of MSE as a function of lambda with confidence ribbon and choices
#'     # of minimum lambda marked
#'     g <- g + geom_vline(xintercept = glance_cv$lambda.min) +
#'         geom_vline(xintercept = glance_cv$lambda.1se, lty = 2)
#'     g
#'
#'     # plot of number of zeros for each choice of lambda
#'     ggplot(tidied_cv, aes(lambda, nzero)) + geom_line() + scale_x_log10()
#'
#'     # coefficient plot with min lambda shown
#'     tidied <- tidy(cvfit1$glmnet.fit)
#'     ggplot(tidied, aes(lambda, estimate, group = term)) + scale_x_log10() +
#'         geom_line() +
#'         geom_vline(xintercept = glance_cv$lambda.min) +
#'         geom_vline(xintercept = glance_cv$lambda.1se, lty = 2)
#' }
#'
#' @export
#' @family glmnet tidiers
#' @seealso [tidy()], [glmnet::cv.glmnet()]
tidy.cv.glmnet <- function(x, ...) {
  with(
    x,
    tibble(
      lambda = lambda,
      estimate = cvm,
      std.error = cvsd,
      conf.low = cvlo,
      conf.high = cvup,
      nzero = nzero
    )
  )
}

#' @templateVar class cv.glmnet
#' @template title_desc_glance
#' 
#' @inheritParams tidy.cv.glmnet
#' 
#' @return A [tibble::tibble] with one-row with columns:
#'   \item{lambda.min}{The value of the penalization parameter lambda that
#'     achieved minimum loss as estimated by cross validation.}
#'   \item{lambda.1se}{The value of the penalization parameter lambda that
#'     results in the sparsest model while remaining within one standard
#'     error of the minimum loss.}
#'
#' @export
#' @seealso [glance()], [glmnet::cv.glmnet()]
#' @family glmnet tidiers
glance.cv.glmnet <- function(x, ...) {
  tibble(lambda.min = x$lambda.min, lambda.1se = x$lambda.1se)
}
