#' @templateVar class glmRob
#' @template title_desc_tidy
#'
#' @param x A `glmRob` object returned from [robust::glmRob()].
#' @template param_unused_dots
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @examples
#'
#' library(robust)
#'
#' gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")
#' 
#' tidy(gm)
#' glance(gm)
#'
#' @export
#' @family robust tidiers
#' @seealso [robust::glmRob()]
tidy.glmRob <- function (x, ...){
  co <- stats::coef(summary(x))
  nn <- c("estimate", "std.error", "statistic", "p.value")
  fix_data_frame(co, nn[1:ncol(co)])
}

#' @templateVar class glmRob
#' @template title_desc_augment
#' 
#' @param x Unused.
#' @param ... Unused.
#' 
#' @description `augment.glmRob()` has been removed from broom. We regret
#'   that we were unable to provide any warning for this change. The
#'   \pkg{robust} package does not provide the functionality necessary
#'   to implement an augment method. We are looking into supporting the
#'   \pkg{robustbase} package in the future.
#'
#' @export
augment.glmRob <- function(x, ...) {
  stop(
    "`augment.glmRob` has been removed from broom. See the documentation.",
    call. = FALSE
  )
}

#' @templateVar class glmRob
#' @template title_desc_glance
#' 
#' @inherit tidy.glmRob params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "deviance",
#'   "sigma",
#'   "null.deviance",
#'   "df.residual",
#'   "nobs"
#' )
#' 
#' @export
#' @family robust tidiers
#' @seealso [robust::glmRob()]
#' 
glance.glmRob <- function(x, ...) {
  s <- summary(x)
  ret <- tibble(
    deviance = x$deviance,
    sigma = stats::sigma(x),
    null.deviance = x$null.deviance,
    df.residual = stats::df.residual(x),
    nobs = stats::nobs(x)
  )
  ret
}
