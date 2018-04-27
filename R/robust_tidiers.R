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
#' @return \code{tidy} and \code{augment} return the same results as \code{\link{lm_tidiers}}.
#' 
#' On an \code{lmRob} \code{glance} returns a one-row data frame with the following columns:
#'   \item{r.squared}{R-squared}
#'   \item{deviance}{Robust deviance}
#'   \item{sigma}{Residual scale estimate}
#'   \item{df.residual}{Number of residual degrees of freedom}
#' 
#' On an \code{glmRob} \code{glance} returns a one-row data frame with the following columns:
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
#' @seealso \code{\link{lm_tidiers}}, \code{\link[robust]{lmRob}}, \code{\link[robust]{glmRob}}
#' 
#' @export
tidy.lmRob <- function(x, ...) {
    tidy.lm(x)
}

#' @rdname robust_tidiers
#' @export
augment.lmRob <- function(x, ...) {
    augment.lm(x)
}

#' @rdname robust_tidiers
#' @export
glance.lmRob <- function(x, ...) {
    s <- robust::summary.lmRob(x)
    ret <- data.frame(r.squared = x$r.squared,
                      deviance = x$dev,
                      sigma = s$sigma,
                      df.residual = x$df.residual)
    unrowname(ret)
}

#' @name robust_tidiers
#' 
#' @export
tidy.glmRob <- function(x, ...) {
    tidy.lm(x)
}

#' @rdname robust_tidiers
#' @export
augment.glmRob <- function(x, ...) {
    augment.lm(x)
}

#' @rdname robust_tidiers
#' @export
glance.glmRob <- function(x, ...) {
    ret <- data.frame(deviance = x$deviance,
                      null.deviance = x$null.deviance)
    finish_glance(ret, x)
}

