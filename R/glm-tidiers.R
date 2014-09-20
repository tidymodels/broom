#' Tidying methods for a glm object
#' 
#' Tidy a \code{glm} object. The \code{tidy} and \code{augment} methods are handled
#' by \code{\link{lm-tidiers}}.
#' 
#' @param x glm object
#' @param ... extra arguments, not used
#' 
#' @return \code{tidy} and \code{augment} return the same values as do
#' \code{\link{tidy.lm}} and \code{\link{augment.lm}}.
#'
#' @seealso \code{\link{tidy.lm}} and \code{\link{augment.lm}}. Also \code{\link{glm}}, which
#' computes the values reported by the \code{glance} method.
#'
#' @name glm-tidiers
#'
#' @export


#' @rdname glm-tidiers
#' 
#' @return \code{glance} returns a one-row data.frame with the columns
#'   \item{deviance}{Minus twice the maximized log-likelihood}
#'   \item{null.deviance}{The deviance of the null model}
#'   \item{df.residual}{The residual degrees of freedom}
#'   \item{df.null}{The residual degrees of freedom for the null model}
#'   \item{logLik}{The data's log-likelihood under the model}
#'   \item{AIC}{The Akaike Information Criterion}
#'   \item{BIC}{The Bayesian Information Criterion}
glance.glm <- function(x, ...) {
    s <- summary(x)
    ret <- unrowname(as.data.frame(s[c("deviance", "null.deviance",
                                       "df.residual", "df.null")]))
    finish_glance(ret, x)
}
