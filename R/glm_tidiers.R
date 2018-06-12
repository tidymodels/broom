#' Tidying methods for a glm object
#'
#' Tidy a `glm` object. The `tidy` and `augment` methods are handled
#' by \link{lm_tidiers}.
#'
#' @param x glm object
#' @param ... extra arguments, not used
#'
#' @return `tidy` and `augment` return the same values as do
#' [tidy.lm()] and [augment.lm()].
#'
#' @seealso [tidy.lm()] and [augment.lm()]. Also [glm()], which
#' computes the values reported by the `glance` method.
#'
#' @name glm_tidiers
#'
#' @examples
#'
#' g <- glm(am ~ mpg, mtcars, family = "binomial")
#' glance(g)
#'
#' @export


#' @rdname glm_tidiers
#'
#' @return `glance` returns a one-row data.frame with the columns
#'   \item{null.deviance}{the deviance of the null model}
#'   \item{df.null}{the residual degrees of freedom for the null model}
#'   \item{logLik}{the data's log-likelihood under the model}
#'   \item{AIC}{the Akaike Information Criterion}
#'   \item{BIC}{the Bayesian Information Criterion}
#'   \item{deviance}{deviance}
#'   \item{df.residual}{residual degrees of freedom}
glance.glm <- function(x, ...) {
  s <- summary(x)
  ret <- unrowname(as.data.frame(s[c("null.deviance", "df.null")]))
  finish_glance(ret, x)
}
