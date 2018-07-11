#' @templateVar class lmRob
#' @template title_desc_tidy_lm_wrapper
#'
#' @param x A `lmRob` object returned from [robust::lmRob()].
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
#' @aliases robust_tidiers
#' @export
#' @family robust tidiers
#' @seealso [robust::lmRob()]
tidy.lmRob <- function(x, ...) {
  tidy.lm(x, ...)
}

#' @templateVar class lmRob
#' @template title_desc_augment_lm_wrapper
#'
#' @param x A `lmRob` object returned from [robust::lmRob()].
#' 
#' @details For tidiers for robust models from the \pkg{MASS} package see
#'   [tidy.rlm()].
#'
#' @export
#' @family robust tidiers
#' @seealso [robust::lmRob()]
augment.lmRob <- function(x, ...) {
  augment.lm(x, ...)
}

#' @templateVar class lmRob
#' @template title_desc_glance
#' 
#' @param x A `lmRob` object returned from [robust::lmRob()].
#' @template param_unused_dots
#' 
#' @return A one-row [tibble::tibble] with columns:
#' 
#'   \item{r.squared}{R-squared}
#'   \item{deviance}{Robust deviance}
#'   \item{sigma}{Residual scale estimate}
#'   \item{df.residual}{Number of residual degrees of freedom}
#' 
#' @export
#' @family robust tidiers
#' @seealso [robust::lmRob()]
#' 
glance.lmRob <- function(x, ...) {
  s <- robust::summary.lmRob(x)
  tibble(
    r.squared = x$r.squared,
    deviance = x$dev,
    sigma = s$sigma,
    df.residual = x$df.residual
  )
}
