#' @templateVar class glmRob
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `glmRob` object returned from [robust::glmRob()].
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @examples
#'
#' library(robust)
#' m <- lmRob(mpg ~ wt, data = mtcars)
#'
#' tidy(m)
#' augment(m)
#' glance(m)
#'
#' gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")
#' glance(gm)
#'
#' @export
#' @family robust tidiers
#' @seealso [robust::glmRob()]
tidy.glmRob <- function(x, ...) {
  tidy.lm(x, ...)
}

#' @templateVar class glmRob
#' @template title_desc_augment_lm_wrapper
#'
#' @inherit tidy.glmRob params examples
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @export
#' @family robust tidiers
#' @seealso [robust::glmRob()]
#' @include stats-lm-tidiers.R
augment.glmRob <- augment.lm

#' @templateVar class glmRob
#' @template title_desc_glance
#' 
#' @inherit tidy.glmRob params examples
#' @template param_unused_dots
#' 
#' @evalRd return_glance(
#'   "deviance",
#'   "null.deviance",
#'   "df.residual"
#' )
#' 
#' @export
#' @family robust tidiers
#' @seealso [robust::glmRob()]
#' 
glance.glmRob <- function(x, ...) {
  ret <- tibble(
    deviance = x$deviance,
    null.deviance = x$null.deviance
  )
  finish_glance(ret, x)
}
