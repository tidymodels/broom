#' @templateVar class glmrob
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `glmrob` object returned from [robustbase::glmrob()].
#' 
#' @details For tidiers for robustbase models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @examples
#'
#' library(robustbase)
#' m <- lmrob(mpg ~ wt, data = mtcars)
#'
#' tidy(m)
#' augment(m)
#' glance(m)
#'
#' gm <- glmrob(am ~ wt, data = mtcars, family = "binomial")
#' glance(gm)
#'
#' @export
#' @family robustbase tidiers
#' @seealso [robustbase::glmrob()]
#' @include stats-lm-tidiers.R
tidy.glmrob <- function (x, ...) {
  dots <- enquos(...)
  dots$conf.int <- FALSE
  
  rlang::exec(tidy.lm, x, !!!dots)
}

#' @templateVar class glmrob
#' @template title_desc_augment
#' 
#' @param x Unused.
#' @param ... Unused.
#' 
#' @description `augment.glmrob()` has been removed from broom. We regret
#'   that we were unable to provide any warning for this change. The
#'   \pkg{robustbase} package does not provide the functionality necessary
#'   to implement an augment method. We are looking into supporting the
#'   \pkg{robustbase} package in the future.
#'
#' @export
augment.glmrob <- function(x, ...) {
  stop(
    "`augment.glmrob` has been removed from broom. See the documentation.",
    call. = FALSE
  )
}

#' @templateVar class glmrob
#' @template title_desc_glance
#' 
#' @inherit tidy.glmrob params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "deviance",
#'   "null.deviance",
#'   "df.residual"
#' )
#' 
#' @export
#' @family robustbase tidiers
#' @seealso [robustbase::glmrob()]
#' 
glance.glmrob <- function(x, ...) {
  ret <- tibble(
    deviance = x$deviance,
    null.deviance = x$null.deviance
  )
  finish_glance(ret, x)
}
