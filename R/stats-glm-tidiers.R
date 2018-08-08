#' @templateVar class glm
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `glm` object returned from [stats::glm()].
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
tidy.glm <- function(x, ...) {
  NextMethod()
}

#' @templateVar class glm
#' @template title_desc_augment_lm_wrapper
#'
#' @param x A `glm` object returned from [stats::glm()].
#'
#' @details Note that if the weights for any of the observations in the model
#'   are 0, then columns ".infl" and ".hat" in the result will be 0
#'   for those observations.
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
#' @include stats-lm-tidiers.R
augment.glm <- augment.lm

#' @templateVar class glm
#' @template title_desc_glance
#' 
#'
#' @param x A `glm` object returned from [stats::glm()].
#' @template param_unused_dots
#'
#' @evalRd return_glance(
#'   "null.deviance",
#'   "df.null",
#'   "logLik",
#'   "AIC",
#'   "BIC",
#'   "deviance",
#'   "df.residual"
#' )
#'
#' @examples
#'
#' g <- glm(am ~ mpg, mtcars, family = "binomial")
#' glance(g)
#'
#' @export
#' @family lm tidiers
#' @seealso [stats::glm()]
glance.glm <- function(x, ...) {
  s <- summary(x)
  ret <- unrowname(as.data.frame(s[c("null.deviance", "df.null")]))
  finish_glance(ret, x)
}
