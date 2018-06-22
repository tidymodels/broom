#' Tidiers for lmRob and glmRob objects
#'
#' Tidying robust regression objects from the robust package. The tidy and augment
#' methods simply pass it on to the linear model tidiers.
#'
#' @param x An lmRob or glmRob object with a robust regression
#' @param ... Extra arguments, not used
#'
#' @template boilerplate
#'
#' @return `tidy` and `augment` return the same results as [lm_tidiers()].
#'
#' On an `lmRob` `glance` returns a one-row data frame with the following columns:
#'   \item{r.squared}{R-squared}
#'   \item{deviance}{Robust deviance}
#'   \item{sigma}{Residual scale estimate}
#'   \item{df.residual}{Number of residual degrees of freedom}
#'
#' On an `glmRob` `glance` returns a one-row data frame with the following columns:
#'   \item{deviance}{Robust deviance}
#'   \item{null.deviance}{Deviance under the null model}
#'   \item{df.residual}{Number of residual degrees of freedom}
#'
#' @examples
#'
#' if (require("robust", quietly = TRUE)) {
#'   m <- lmRob(mpg ~ wt, data = mtcars)
#'
#'   tidy(m)
#'   augment(m)
#'   glance(m)
#'
#'   gm <- glmRob(am ~ wt, data = mtcars, family = "binomial")
#'   glance(gm)
#' }
#'
#' @name robust_tidiers
#'
#' @seealso [lm_tidiers()], [robust::lmRob()], [robust::glmRob()]
#'
#' @export
tidy.lmRob <- tidy.lm

#' @rdname robust_tidiers
#' @export
augment.lmRob <- augment.lm

#' @rdname robust_tidiers
#' @export
glance.lmRob <- function(x, ...) {
  s <- robust::summary.lmRob(x)
  tibble(
    r.squared = x$r.squared,
    deviance = x$dev,
    sigma = s$sigma,
    df.residual = x$df.residual
  )
}

#' @name robust_tidiers
#'
#' @export
tidy.glmRob <- tidy.lm

#' @rdname robust_tidiers
#' @export
augment.glmRob <- augment.lm

#' @rdname robust_tidiers
#' @export
glance.glmRob <- function(x, ...) {
  ret <- tibble(
    deviance = x$deviance,
    null.deviance = x$null.deviance
  )
  finish_glance(ret, x)
}
